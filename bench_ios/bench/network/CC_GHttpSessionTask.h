//
//  GHttpSessionTask.h
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_GHttpSessionTask : NSObject<NSURLSessionDelegate>{
    NSMutableData *resultData; // 存放请求结果
    void (^finishCallbackBlock)(NSDictionary *resultDic,NSString *resultString,NSString *errorString); // 执行完成后回调的block
}

@property(strong) void (^finishCallbackBlock)(NSDictionary *,NSString *,NSString *);

/** 对于json的请求*/
//- (void)postSessionWithJsonUrl:(NSURL *)url ParamterStr:(NSString *)paramsString FinishCallbackBlock:(void (^)(NSDictionary *, NSString *))block;

/** 直接使用字典*/
//- (void)postSessionWithJsonUrl:(NSURL *)url ParamterStr:(NSMutableDictionary *)paramsDic FinishCallbackBlock:(void (^)(NSDictionary *, NSString *))block;

+ (void)postSessionWithJsonUrl:(NSURL *)url ParamterStr:(NSMutableDictionary *)paramsDic Info:(id)info FinishCallbackBlock:(void (^)(NSDictionary *,NSString *, NSString *))block;

@end
