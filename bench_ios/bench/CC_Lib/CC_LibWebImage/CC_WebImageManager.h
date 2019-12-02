//
//  CC_WebImageManager.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//
#import "CC_WebImageConfig.h"
#import "CC_ImageCache.h"
#import "CC_WebImageDownloader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CC_WebImageProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
typedef void(^CC_WebImageCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished);

@interface CC_WebImageManager : NSObject

+ (instancetype)shared;

@property (strong, nonatomic, nullable) CC_ImageCache *imageCache;

- (id<CC_WebImageOperationDelegate>)loadImageWithURL:(nullable NSURL *)url
                                              progress:(nullable CC_WebImageProgressBlock)progressBlock
                                             completed:(nullable CC_WebImageCompletionBlock)completedBlock;

- (void)setCacheConfig:(CC_WebImageCacheConfig *)cacheConfig;

// 清除所有内存的图片缓存
- (void)clearAllMemoryWebImageCache:(void(^)(void))completionBlock;

// 清除所有磁盘的图片缓存
- (void)clearAllDiskWebImageCache:(void(^)(void))completionBlock;

// 清除所有内存和磁盘的图片缓存
- (void)clearAllWebImageCache:(void(^)(void))completionBlock;

// 清除指定key的图片缓存
- (void)clearWebImageCacheForKey:(NSString*)url completionBlock:(void(^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
