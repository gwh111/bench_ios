//
//  CC_WebImageOperation.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageConfig.h"
#import "CC_WebImageManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CC_WebImageDownloadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL *_Nullable targetURL);
typedef void(^CC_WebImageDownloadCompletionBlock)(UIImage *_Nullable image, NSData *_Nullable imageData, NSError *_Nullable error, BOOL finished);

@interface CC_WebImageOperation : NSOperation<CC_WebImageOperationDelegate>

/**
 初始化 请求

 @param request 请求
 @return 实例
 */
- (instancetype)initWithRequest:(NSURLRequest *)request;

/**
 添加进度回调和完成回调

 @param progressBlock 进度回调
 @param completionBlock 完成回调
 @return 实例
 */
- (id)addProgressHandler:(CC_WebImageDownloadProgressBlock)progressBlock withCompletionBlock:(CC_WebImageDownloadCompletionBlock)completionBlock;

/**
 取消

 @param token token
 @return 是否成功
 */
- (BOOL)cancelWithToken:(id)token;

@end

NS_ASSUME_NONNULL_END
