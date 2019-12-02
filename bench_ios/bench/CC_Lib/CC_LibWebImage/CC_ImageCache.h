//
//  CC_ImageCache.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageConfig.h"
#import "UIImage+CC_WebImageFormat.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CC_WebDiskCacheDelegate <NSObject>

- (void)storeImageData:(nullable NSData *)imageData
                forKey:(nullable NSString *)key;
- (nullable NSData *)queryImageDataForKey:(nullable NSString *)key;
- (BOOL)removeImageDataForKey:(nullable NSString *)key;
- (void)clearDiskCache;

@optional

- (void)deleteOldFiles; //后台更新文件

@end

@interface CC_WebImageCacheConfig : NSObject
@property (nonatomic, assign) BOOL shouldDecompressImages;
@property (nonatomic, assign) BOOL shouldCacheImagesInMemory; //是否使用内存缓存
@property (nonatomic, assign) BOOL shouldCacheImagesInDisk; //是否使用磁盘缓存
@property (nonatomic, assign) NSInteger maxCacheAge; //文件最大缓存时间
@property (nonatomic, assign) NSInteger maxCacheSize; //文件缓存最大限制
@end

@interface CC_WebDiskCache : NSObject <CC_WebDiskCacheDelegate>

- (instancetype)initWithPath:(nullable NSString *)path withConfig:(nullable CC_WebImageCacheConfig *)config;

@end

typedef NSCache CC_WebMemoryCache;
typedef NSCache CC_ImageAddressCache;

typedef void(^CC_CacheQueryCompletedBlock)(UIImage * _Nullable image, NSData * _Nullable data);

@interface CC_ImageCache : NSObject

@property (nonatomic, strong) id<CC_WebDiskCacheDelegate> diskCache;
@property (nonatomic, strong) CC_WebMemoryCache *memoryCache;
@property (nonatomic, strong) CC_ImageAddressCache *addressCache;
@property (nonatomic, strong) CC_WebImageCacheConfig *cacheConfig;

- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns;

// 保存图片
- (void)storeImage:(nullable UIImage *)image imageData:(nullable NSData *)imageData forKey:(nullable NSString *)key
        completion:(nullable void(^)(void))completionBlock;

// 查询图片
- (nullable NSOperation *)queryImageForKey:(nullable NSString *)key
                                completion:(nullable void(^)(UIImage *_Nullable image))completionBlock;

// 移除图片
- (void)removeImageForKey:(nullable NSString *)key
               completion:(nullable void(^)(void))completionBlock;

// 清除内存缓存
-(void)clearAllMemoryCacheWithCompletion:(nullable void(^)(void))completionBlock;

// 清除磁盘缓存
-(void)clearAllDiskCacheWithCompletion:(nullable void(^)(void))completionBlock;

// 清除缓存
- (void)clearAllWithCompletion:(nullable void(^)(void))completionBlock;

@end

#pragma mark - coder

@interface CC_WebImageCoder : NSObject

+ (instancetype)shared;

// 二进制数据转图片
- (nullable UIImage *)decodeImageSyncWithData:(nullable NSData *)data;

// 图片转二进制数据
- (nullable NSData *)encodedDataSyncWithImage:(nullable UIImage *)image;

// 二进制数据转图片，带回调
- (void)decodeImageWithData:(NSData *)data WithBlock:(void(^)(UIImage *_Nullable image))completionBlock;

// 图片转二进制数据，带回调
- (void)encodedDataWithImage:(UIImage *)image WithBlock:(void(^)(NSData *_Nullable data))completionBlock;

@end

@interface CC_WebImageCoderHelper : NSObject

// 获取图片数据格式
+ (CC_WebImageFormat)imageFormatWithData:(NSData *)data;

+ (UIImageOrientation)imageOrientationFromEXIFOrientation:(NSInteger)exifOrientation;

@end

NS_ASSUME_NONNULL_END
