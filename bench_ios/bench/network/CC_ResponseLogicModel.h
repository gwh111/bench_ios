//
//  CC_ResponseLogicModel.h
//  bench_ios
//
//  Created by gwh on 2018/7/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_HttpResponseModel.h"

@interface CC_ResLModel : NSObject

/**
 *  统一处理回调的名字
 */
@property(nonatomic,retain) NSString *logicNameStr;
/**
 *  统一处理回调的判断字段路径
 */
@property(nonatomic,retain) NSArray *logicPathArr;
/**
 *  统一处理回调判断相等的字段
 */
@property(nonatomic,retain) NSString *logicEqualStr;
/**
 *  统一处理回调是否立即停止不传递
 */
@property(nonatomic,assign) BOOL logicPassStop;
/**
 *  统一处理回调只回调一次
 */
@property(nonatomic,assign) BOOL logicPopOnce;
/**
 *  统一处理回调条件判断成立
 */
@property(nonatomic,assign) BOOL logicPassed;
/**
 *  统一处理回调
 */
@property(strong) void (^logicBlock)(ResModel *result, void (^finishCallbackBlock)(NSString *error,ResModel *result));

@end
