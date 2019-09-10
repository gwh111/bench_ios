//
//  CC_WebImageDownloader.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageConfig.h"
#import "CC_WebImageOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_WebImageDownloadToken : NSObject
@property (nonatomic, strong, nullable) id downloadToken;//所有下载任务的字典
@property (nonatomic, strong, nullable) NSURL *url;
@end

typedef void(^CC_WebImageDownloadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
typedef void(^CC_WebImageDownloadCompletionBlock)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished);

@interface CC_WebImageDownloader : NSObject

+ (instancetype)shared;

/**
 创建下载，带进度回调，带完成回调

 @param url URL
 @param progressBlock 进度回调
 @param completedBlock 完成回调
 @return 下载实例
 */
- (nullable CC_WebImageDownloadToken*)downloadImageWithURL:(nullable NSURL *)url
                                                   progress:(nullable CC_WebImageDownloadProgressBlock)progressBlock
                                                  completed:(nullable CC_WebImageDownloadCompletionBlock)completedBlock;

/**
 取消下载

 @param token 下载实例
 */
- (void)cancelWithToken:(CC_WebImageDownloadToken *)token;

@end

NS_ASSUME_NONNULL_END
