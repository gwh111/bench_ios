//
//  GHttpSessionTask.h
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

/*
 需求：
 1、配置http头
    setHttpHeader
 2、
 */

#import <Foundation/Foundation.h>
#import "CC_HttpResponseModel.h"

@interface CC_HttpTask : NSObject<NSURLSessionDelegate>{
    void (^finishCallbackBlock)(NSString *errorStr, ResModel *model); // 执行完成后回调的block
}

+ (instancetype)getInstance;

/**
 *  获取 根据response里返回的http头部的时间 即服务端相应发送时间
 */
@property(nonatomic,assign) BOOL needResponseDate;
/**
 *  设置http请求头部
 */
@property(nonatomic,retain) NSDictionary *requestHTTPHeaderFieldDic;
/**
 *  设置登录后拿到的signKey
 */
@property(nonatomic,retain) NSString *signKeyStr;
/**
 *  设置一次 额外的 每个接口都要发送的数据
 *  可放入 比如 authedUserId timestamp
 */
@property(nonatomic,retain) NSDictionary *extreDic;
/**
 *  额外的 每个接口都要发送的数据
 */

@property(strong) void (^finishCallbackBlock)(NSString *error,ResModel *result);

/**
 * paramsDic的关键字
 * getDate 可以获取时间
 */
- (void)post:(NSURL *)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block;
- (void)get:(NSURL *)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block;

@end
