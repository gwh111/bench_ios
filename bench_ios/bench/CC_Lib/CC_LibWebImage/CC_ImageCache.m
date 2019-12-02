//
//  CC_ImageCache.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_ImageCache.h"
#import <CommonCrypto/CommonDigest.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "CC_MD5Object.h"

@implementation CC_WebImageCacheConfig

static const NSInteger kDefaultMaxCacheAge = 60 * 60 * 24 * 7;

- (instancetype)init{
    if (self = [super init]) {
        self.shouldDecompressImages = YES;
        self.shouldCacheImagesInDisk = YES;
        self.shouldCacheImagesInMemory = YES;
        self.maxCacheAge = kDefaultMaxCacheAge;
        self.maxCacheSize = NSIntegerMax;
    }
    return self;
}

@end

@interface CC_ImageCache()
@property (nonatomic, strong) dispatch_queue_t ioQueue;
@end

@implementation CC_ImageCache

- (instancetype)init{
    return [self initWithNamespace:@"default"];
}

- (instancetype)initWithNamespace:(NSString *)ns{
    return [self initWithNameSpace:ns diskDirectoryPath:[self diskPathWithNameSpace:ns]];
}

- (instancetype)initWithNameSpace:(NSString *)nameSpace diskDirectoryPath:(NSString *)directory{
    if (self = [super init]) {
        NSString *fullNameSpace = [@"com.ccimage.cache" stringByAppendingString:nameSpace];
        NSString *diskPath;
        if (directory) {
            diskPath = [directory stringByAppendingPathComponent:fullNameSpace];
        } else {
            diskPath = [[self diskPathWithNameSpace:nameSpace] stringByAppendingString:fullNameSpace];
        }
        self.cacheConfig = [[CC_WebImageCacheConfig alloc] init];
        self.diskCache = [[CC_WebDiskCache alloc] initWithPath:diskPath withConfig:self.cacheConfig];
        self.memoryCache = [[NSCache alloc] init];
        self.addressCache = [[NSCache alloc] init];
        self.ioQueue = dispatch_queue_create("com.ccimage.cache", DISPATCH_QUEUE_SERIAL);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)diskPathWithNameSpace:(NSString *)namespace{
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:namespace];
}

- (void)storeImage:(UIImage *)image imageData:(NSData *)imageData forKey:(NSString *)key completion:(void (^)(void))completionBlock{
    if (!key || key.length == 0 || (!image && !imageData)) {
        SAFE_CALL_BLOCK(completionBlock);
        return;
    }
    void(^storeBlock)(void) = ^ {
        if (self.cacheConfig.shouldCacheImagesInMemory) {
            if (image) {
                [self.memoryCache setObject:image forKey:key cost:image.memoryCost];
            } else if (imageData) {
                UIImage *decodedImage = [[CC_WebImageCoder shared] decodeImageSyncWithData:imageData];
                if (decodedImage) {
                    [self.memoryCache setObject:decodedImage forKey:key cost:decodedImage.memoryCost];
                }
            }
        }
        if (self.cacheConfig.shouldCacheImagesInDisk) {
            if (imageData) {
                [self.diskCache storeImageData:imageData forKey:key];
            } else if (image) {
                NSData *data = [[CC_WebImageCoder shared] encodedDataSyncWithImage:image];
                if (data) {
                    [self.diskCache storeImageData:data forKey:key];
                }
            }
        }
        SAFE_CALL_BLOCK(completionBlock);
    };
    dispatch_async(self.ioQueue, storeBlock);
}

- (NSOperation *)queryImageForKey:(NSString *)key completion:(void (^)(UIImage * _Nullable))completionBlock{
    if (!key || key.length == 0) {
        SAFE_CALL_BLOCK(completionBlock, nil);
        return nil;
    }
    NSOperation *operation = [NSOperation new];
    void(^queryBlock)(void) = ^ {
        if (operation.isCancelled) {
            return;
        }
        UIImage *image = nil;
            image = [self.memoryCache objectForKey:key];
            if (!image) {
                NSData *data = [self.diskCache queryImageDataForKey:key];
                if (data) {
                    image = [[CC_WebImageCoder shared] decodeImageSyncWithData:data];
                    if (image) {
                        [self.memoryCache setObject:image forKey:key cost:image.memoryCost];
                    }
                }
            }
        SAFE_CALL_BLOCK(completionBlock, image);
    };
    dispatch_async(self.ioQueue, queryBlock);
    return operation;
}

- (void)removeImageForKey:(NSString *)key completion:(void (^)(void))completionBlock{
    if (!key || key.length == 0) {
        SAFE_CALL_BLOCK(completionBlock);
        return;
    }
    
    void(^diskRemovedBlock)(void) = ^{
        [self.diskCache removeImageDataForKey:key];
        SAFE_CALL_BLOCK(completionBlock);
    };
    
        [self.memoryCache removeObjectForKey:key];
        dispatch_async(self.ioQueue, diskRemovedBlock);
}


- (void)clearAllMemoryCacheWithCompletion:(void (^)(void))completionBlock{
    [self.memoryCache removeAllObjects];
    [self.addressCache removeAllObjects];
    SAFE_CALL_BLOCK(completionBlock);
}

- (void)clearAllDiskCacheWithCompletion:(void (^)(void))completionBlock{
    dispatch_async(self.ioQueue, ^{
        [self.diskCache clearDiskCache];
        SAFE_CALL_BLOCK(completionBlock);
    });
}

- (void)clearAllWithCompletion:(void (^)(void))completionBlock{
    [self.memoryCache removeAllObjects];
    [self.addressCache removeAllObjects];
    dispatch_async(self.ioQueue, ^{
        [self.diskCache clearDiskCache];
        SAFE_CALL_BLOCK(completionBlock);
    });
}

- (void)onDidEnterBackground:(NSNotification *)notification{
    [self backgroundDeleteOldFiles];
}

- (void)backgroundDeleteOldFiles{
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    UIApplication *application = [UIApplication performSelector:@selector(sharedApplication)];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];
    
    void(^deleteBlock)(void) = ^ {
        if ([self.diskCache respondsToSelector:@selector(deleteOldFiles)]) {
            [self.diskCache deleteOldFiles];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [application endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        });
    };
    
    dispatch_async(self.ioQueue, deleteBlock);
}

@end

#pragma mark - CC_WebDiskCache 磁盘缓存

@interface CC_WebDiskCache ()

@property (nonatomic, copy) NSString *diskPath;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, assign) NSInteger maxCacheAge;
@property (nonatomic, assign) NSInteger maxCacheSize;

@end

@implementation CC_WebDiskCache

- (instancetype)initWithPath:(NSString *)path withConfig:(CC_WebImageCacheConfig *)config{
    if (self = [super init]) {
        if (path) {
            self.diskPath = path;
        } else {
            self.diskPath = [self defaultDiskPath];
        }
        if (config) {
            self.maxCacheAge = config.maxCacheAge;
            self.maxCacheSize = config.maxCacheSize;
        } else {
            self.maxCacheSize = NSIntegerMax;
            self.maxCacheAge = NSIntegerMax;
        }
        self.fileManager = [NSFileManager new];
    }
    return self;
}

#pragma mark - JDiskCacheDelegate

- (void)storeImageData:(NSData *)imageData forKey:(nullable NSString *)key{
    if (!imageData || !key || key.length == 0) {
        return;
    }
    
    if (![self.fileManager fileExistsAtPath:self.diskPath]) {
        [self.fileManager createDirectoryAtPath:self.diskPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [self.diskPath stringByAppendingPathComponent:[self cachedFileNameForKey:key]];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [imageData writeToURL:fileURL atomically:YES];
}

- (BOOL)removeImageDataForKey:(NSString *)key{
    if (!key || key.length == 0) {
        return NO;
    }
    
    NSString *filePath = [self filePathForKey:key];
    return [self.fileManager removeItemAtPath:filePath error:nil];
}

- (NSData *)queryImageDataForKey:(NSString *)key{
    if (!key || key.length == 0) {
        return nil;
    }
    
    NSString *filePath = [self filePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}


- (void)clearDiskCache{
    NSError *error;
    [self.fileManager removeItemAtPath:self.diskPath error:&error];
    if (error) {
        CCLOG(@"clear disk cache fail: %@", error ? error.description : @"");
    }
}

- (void)deleteOldFiles{
    CCLOG(@"start clean up old files");
    NSURL *diskCacheURL = [NSURL fileURLWithPath:self.diskPath isDirectory:YES];
    NSArray<NSString *> *resourceKeys = @[NSURLIsDirectoryKey, NSURLContentAccessDateKey, NSURLTotalFileAllocatedSizeKey];
    NSDirectoryEnumerator *fileEnumerator = [self.fileManager enumeratorAtURL:diskCacheURL includingPropertiesForKeys:resourceKeys options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:NULL];
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
    NSMutableArray <NSURL *> *deleteURLs = [NSMutableArray array];
    NSMutableDictionary<NSURL *, NSDictionary<NSString *, id>*> *cacheFiles = [NSMutableDictionary dictionary];
    NSInteger currentCacheSize = 0;
    for (NSURL *fileURL in fileEnumerator) {
        NSError *error;
        NSDictionary<NSString *, id> *resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:&error];
        if (error || !resourceValues || [resourceValues[NSURLIsDirectoryKey] boolValue]) {
            continue;
        }
        NSDate *accessDate = resourceValues[NSURLContentAccessDateKey];
        if ([accessDate earlierDate:expirationDate]) {
            [deleteURLs addObject:fileURL];
            continue;
        }
        
        NSNumber *fileSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
        currentCacheSize += fileSize.unsignedIntegerValue;
        [cacheFiles setObject:resourceValues forKey:fileURL];
    }
    
    for (NSURL *URL in deleteURLs) {
        NSLog(@"delete old file: %@", URL.absoluteString);
        [self.fileManager removeItemAtURL:URL error:nil];
    }
    
    if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
        NSUInteger desiredCacheSize = self.maxCacheSize / 2;
        NSArray<NSURL *> *sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1[NSURLContentAccessDateKey] compare:obj2[NSURLContentAccessDateKey]];
        }];
        for (NSURL *fileURL in sortedFiles) {
            if ([self.fileManager removeItemAtURL:fileURL error:nil]) {
                NSDictionary<NSString *, id> *resourceValues = cacheFiles[fileURL];
                NSNumber *fileSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                currentCacheSize -= fileSize.unsignedIntegerValue;
                
                if (currentCacheSize < desiredCacheSize) {
                    break;
                }
            }
        }
    }
}

#pragma mark - private method
- (NSString *)filePathForKey:(NSString *)key{
    return [self.diskPath stringByAppendingPathComponent:[self cachedFileNameForKey:key]];
}

- (NSString *)defaultDiskPath{
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingString:@"com.jimage.cache"];
}

- (NSString *)cachedFileNameForKey:(nullable NSString *)key{
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[16];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSURL *keyURL = [NSURL URLWithString:key];
    NSString *ext = keyURL ? keyURL.pathExtension : key.pathExtension;
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];
    return filename;
}

@end

#pragma mark - CC_WebImageCoder
static const NSTimeInterval kJAnimatedImageDelayTimeIntervalMinimum = 0.02;
static const NSTimeInterval kJAnimatedImageDefaultDelayTimeInterval = 0.1;

FOUNDATION_EXTERN_INLINE CFStringRef getImageUTType(CC_WebImageFormat imageFormat) {
    switch (imageFormat) {
        case CC_WebImageFormatPNG:
            return kUTTypePNG;
        case CC_WebImageFormatJPEG:
            return kUTTypeJPEG;
        case CC_WebImageFormatGIF:
            return kUTTypeGIF;
        default:
            return kUTTypePNG;
    }
}

FOUNDATION_EXTERN_INLINE BOOL CC_WebCGImageRefContainsAlpha(CGImageRef imageRef) {
    if (!imageRef) {
        return NO;
    }
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    BOOL hasAlpha = !(alphaInfo == kCGImageAlphaNone ||
                      alphaInfo == kCGImageAlphaNoneSkipFirst ||
                      alphaInfo == kCGImageAlphaNoneSkipLast);
    return hasAlpha;
}

@interface CC_WebImageCoder ()

@property (nonatomic, strong) dispatch_queue_t coderQueue;

@end

@implementation CC_WebImageCoder

+ (instancetype)shared{
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_WebImageCoder.shared setup];
    }];
}

- (void)setup{
    self.coderQueue = dispatch_queue_create("com.jimage.coder.queue", DISPATCH_QUEUE_SERIAL);
}

#pragma mark - encode
- (void)encodedDataWithImage:(UIImage *)image WithBlock:(void (^)(NSData * _Nullable))completionBlock{
    dispatch_async(self.coderQueue, ^{
        NSData *data = [self encodedDataSyncWithImage:image];
        completionBlock(data);
    });
}

- (NSData *)encodedDataSyncWithImage:(UIImage *)image{
    if (!image) {
        return nil;
    }
    switch (image.imageFormat) {
        case CC_WebImageFormatPNG:
        case CC_WebImageFormatJPEG:
            return [self encodedDataWithImage:image imageFormat:image.imageFormat];
            
        case CC_WebImageFormatGIF:{
            return [self encodedGIFDataWithImage:image];
        }
            
        case CC_WebImageFormatUndefined:{
            if (CC_WebCGImageRefContainsAlpha(image.CGImage)) {
                return [self encodedDataWithImage:image imageFormat:CC_WebImageFormatPNG];
            } else {
                return [self encodedDataWithImage:image imageFormat:CC_WebImageFormatJPEG];
            }
        }
    }
}

- (nullable NSData *)encodedDataWithImage:(UIImage *)image imageFormat:(CC_WebImageFormat)imageFormat{
    UIImage *fixedImage = [image normalizedImage];
    if (imageFormat == CC_WebImageFormatPNG) {
        return UIImagePNGRepresentation(fixedImage);
    } else {
        return UIImageJPEGRepresentation(fixedImage, 1.0);
    }
}

- (nullable NSData *)encodedGIFDataWithImage:(UIImage *)image{
    NSMutableData *gifData = [NSMutableData data];
    
    CGImageDestinationRef imageDestination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)gifData, kUTTypeGIF, image.images.count, NULL);
    if (!imageDestination) {
        return nil;
    }
    if (image.images.count == 0) {
        CGImageDestinationAddImage(imageDestination, image.CGImage, nil);
    } else {
        NSUInteger loopCount = image.loopCount;
        NSDictionary *gifProperties = @{(__bridge NSString *)kCGImagePropertyGIFDictionary : @{(__bridge NSString *)kCGImagePropertyGIFLoopCount : @(loopCount)}};
        CGImageDestinationSetProperties(imageDestination, (__bridge CFDictionaryRef)gifProperties);
        size_t count = MIN(image.images.count, image.delayTimes.count);
        for (size_t i = 0; i < count; i ++) {
            NSDictionary *properties = @{(__bridge NSString *)kCGImagePropertyGIFDictionary : @{(__bridge NSString *)kCGImagePropertyGIFDelayTime : image.images[i]}};
            CGImageDestinationAddImage(imageDestination, image.images[i].CGImage, (__bridge CFDictionaryRef)properties);
        }
    }
    if (CGImageDestinationFinalize(imageDestination) == NO) {
        gifData = nil;
    }
    CFRelease(imageDestination);
    return [gifData copy];
}

#pragma mark - decode
- (void)decodeImageWithData:(NSData *)data WithBlock:(void (^)(UIImage * _Nullable))completionBlock{
    dispatch_async(self.coderQueue, ^{
        UIImage *image = [self decodeImageSyncWithData:data];
        completionBlock(image);
    });
}

- (UIImage *)decodeImageSyncWithData:(NSData *)data{
    CC_WebImageFormat format = [CC_WebImageCoderHelper imageFormatWithData:data];
    switch (format) {
        case CC_WebImageFormatJPEG:
        case CC_WebImageFormatPNG:{
            UIImage *image = [[UIImage alloc] initWithData:data];
            image.imageFormat = format;
            return image;
        }
        case CC_WebImageFormatGIF:
            return [self decodeGIFWithData:data];
        default:
            return nil;
    }
}

- (UIImage *)decodeGIFWithData:(NSData *)data{
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    if (!source) {
        return nil;
    }
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
        animatedImage.imageFormat = CC_WebImageFormatGIF;
    } else {
        NSInteger loopCount = 0;
        CFDictionaryRef properties = CGImageSourceCopyProperties(source, NULL);
        if (properties) {
            CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
            if (gif) {
                CFTypeRef loop = CFDictionaryGetValue(gif, kCGImagePropertyGIFLoopCount);
                if (loop) {
                    CFNumberGetValue(loop, kCFNumberNSIntegerType, &loopCount);
                }
            }
            CFRelease(properties);
        }
        
        NSMutableArray<NSNumber *> *delayTimeArray = [NSMutableArray array];
        NSMutableArray<UIImage *> *imageArray = [NSMutableArray array];
        NSTimeInterval duration = 0;
        for (size_t i = 0; i < count; i ++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!imageRef) {
                continue;
            }
            
            UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
            [imageArray addObject:image];
            CGImageRelease(imageRef);
            
            float delayTime = kJAnimatedImageDefaultDelayTimeInterval;
            CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
            if (properties) {
                CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
                if (gif) {
                    CFTypeRef value = CFDictionaryGetValue(gif, kCGImagePropertyGIFUnclampedDelayTime);
                    if (!value) {
                        value = CFDictionaryGetValue(gif, kCGImagePropertyGIFDelayTime);
                    }
                    if (value) {
                        CFNumberGetValue(value, kCFNumberFloatType, &delayTime);
                        if (delayTime < ((float)kJAnimatedImageDelayTimeIntervalMinimum - FLT_EPSILON)) {
                            delayTime = kJAnimatedImageDefaultDelayTimeInterval;
                        }
                    }
                }
                CFRelease(properties);
            }
            duration += delayTime;
            [delayTimeArray addObject:@(delayTime)];
        }
        
        animatedImage = [[UIImage alloc] init];
        animatedImage.imageFormat = CC_WebImageFormatGIF;
        animatedImage.images = [imageArray copy];
        animatedImage.delayTimes = [delayTimeArray copy];
        animatedImage.loopCount = loopCount;
        animatedImage.totalTimes = duration;
    }
    CFRelease(source);
    return animatedImage;
}

@end

@implementation CC_WebImageCoderHelper

+ (CC_WebImageFormat)imageFormatWithData:(NSData *)data{
    if (!data) {
        return CC_WebImageFormatUndefined;
    }
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return CC_WebImageFormatJPEG;
        case 0x89:
            return CC_WebImageFormatPNG;
        case 0x47:
            return CC_WebImageFormatGIF;
        default:
            return CC_WebImageFormatUndefined;
    }
}

+ (UIImageOrientation)imageOrientationFromEXIFOrientation:(NSInteger)exifOrientation{
    UIImageOrientation imageOrientation = UIImageOrientationUp;
    switch (exifOrientation) {
        case 1:
            imageOrientation = UIImageOrientationUp;
            break;
        case 3:
            imageOrientation = UIImageOrientationDown;
            break;
        case 8:
            imageOrientation = UIImageOrientationLeft;
            break;
        case 6:
            imageOrientation = UIImageOrientationRight;
            break;
        case 2:
            imageOrientation = UIImageOrientationUpMirrored;
            break;
        case 4:
            imageOrientation = UIImageOrientationDownMirrored;
            break;
        case 5:
            imageOrientation = UIImageOrientationLeftMirrored;
            break;
        case 7:
            imageOrientation = UIImageOrientationRightMirrored;
            break;
        default:
            break;
    }
    return imageOrientation;
}

@end
