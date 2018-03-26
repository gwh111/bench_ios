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

@property(nonatomic,retain) NSDictionary *requestHTTPHeaderFieldDic;
@property(nonatomic,retain) NSString *signKeyStr;
@property(nonatomic,retain) NSDictionary *extreDic;

@property(strong) void (^finishCallbackBlock)(NSString *error,ResModel *result);

- (void)post:(NSURL *)url Params:(id)paramsDic model:(ResModel *)model FinishCallbackBlock:(void (^)(NSString *, ResModel *))block;

@end
