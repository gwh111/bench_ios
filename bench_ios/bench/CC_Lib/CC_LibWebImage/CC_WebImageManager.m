//
//  CC_WebImageManager.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageConfig.h"
#import "CC_WebImageManager.h"
#import "CC_WebImageDownloader.h"
#import "CC_Base.h"

@interface CC_WebImageCombineOperation : NSObject <CC_WebImageOperationDelegate>
@property (nonatomic, strong) NSOperation *cacheOperation;
@property (nonatomic, strong) CC_WebImageDownloadToken* downloadToken;
@property (nonatomic, copy) NSString *url;

@end

@implementation CC_WebImageCombineOperation

- (void)cancelOperation{
    if (self.cacheOperation) {
        [self.cacheOperation cancel];
    }
    if (self.downloadToken) {
        [[CC_WebImageDownloader shared] cancelWithToken:self.downloadToken];
    }
}

@end

@implementation CC_WebImageManager

+ (instancetype)shared{
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_WebImageManager.shared setup];
    }];
}

- (void)setup{
    self.imageCache = [CC_Base.shared cc_init:CC_ImageCache.class];
    
}

#pragma methods
- (id<CC_WebImageOperationDelegate>)loadImageWithURL:(NSURL *)url progress:(CC_WebImageProgressBlock)progressBlock completed:(CC_WebImageCompletionBlock)completedBlock{
    //判空等预处理
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }
    __block CC_WebImageCombineOperation *combineOperation = [CC_WebImageCombineOperation new];
    combineOperation.url = url.absoluteString;
    combineOperation.cacheOperation = [self.imageCache queryImageForKey:url.absoluteString  completion:^(UIImage * _Nullable image) {
        if (image) {
            dispatch_main_async_safe(^{
                SAFE_CALL_BLOCK(completedBlock, image, nil, YES);
            });
        }else{
            combineOperation.downloadToken = [self fetchImageWithUrl:url progressBlock:progressBlock completionBlock:completedBlock];
        }
    }];
    return combineOperation;
}

- (CC_WebImageDownloadToken *)fetchImageWithUrl:(NSURL *)url  progressBlock:(CC_WebImageProgressBlock)progressBlock completionBlock:(CC_WebImageCompletionBlock)completionBlock {
    __weak typeof(self) weakSelf = self;
    CC_WebImageDownloadToken *downloadToken = [[CC_WebImageDownloader shared] downloadImageWithURL:url progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_main_async_safe(^{
            SAFE_CALL_BLOCK(progressBlock, receivedSize, expectedSize, targetURL);
        });
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (!finished) {
            dispatch_main_async_safe(^{
                SAFE_CALL_BLOCK(completionBlock, image, error, NO);
            });
        } else {
            if (!data || error) {
                dispatch_main_async_safe(^{
                    SAFE_CALL_BLOCK(completionBlock, nil, error, YES);
                });
                return;
            }
            [[CC_WebImageCoder shared] decodeImageWithData:data WithBlock:^(UIImage * _Nullable image) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                NSData *cacheData = data;
                UIImage* transformImage = image;
                if (image.images) {
                    //动图
                }else{
                    //静图
                    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
                    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
                    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0.0] addClip];
                    [image drawInRect:rect];
                    transformImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                }
                
                [strongSelf.imageCache storeImage:transformImage imageData:cacheData forKey:url.absoluteString completion:nil];
                dispatch_main_async_safe(^{
                    SAFE_CALL_BLOCK(completionBlock, transformImage, nil, YES);
                });
            }];
        }
    }];
    return downloadToken;
}

- (void)clearAllMemoryWebImageCache:(void (^)(void))completionBlock{
    [self.imageCache clearAllMemoryCacheWithCompletion:completionBlock];
}

- (void)clearAllDiskWebImageCache:(void (^)(void))completionBlock{
    [self.imageCache clearAllDiskCacheWithCompletion:completionBlock];
}

- (void)clearAllWebImageCache:(void(^)(void))completionBlock{
    [self.imageCache clearAllWithCompletion:completionBlock];
}

- (void)clearWebImageCacheForKey:(NSString *)url completionBlock:(void (^)(void))completionBlock{
    [self.imageCache removeImageForKey:url completion:completionBlock];
}
#pragma mark - setter

- (void)setCacheConfig:(CC_WebImageCacheConfig *)cacheConfig {
    self.imageCache.cacheConfig = cacheConfig;
}

@end
