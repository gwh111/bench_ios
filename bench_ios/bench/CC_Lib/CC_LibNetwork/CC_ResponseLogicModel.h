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

// Give a name for response logic, use service name as recommand
@property(nonatomic,retain) NSString *logicName;

// 统一处理回调的判断字段路径
@property(nonatomic,retain) NSArray *logicPathList;

// 统一处理回调判断相等的字段
@property(nonatomic,retain) NSString *logicEqualName;

// 统一处理回调是否立即停止不传递到业务层
@property(nonatomic,assign) BOOL logicPassStop;

// If 'logicName' is same, will block only once.
@property(nonatomic,assign) BOOL logicPopOnce;

// 统一处理回调条件判断成立
@property(nonatomic,assign) BOOL logicPassed;

// 统一处理回调
@property(strong) void (^logicBlock)(HttpModel *result, void (^finishCallbackBlock)(NSString *error,HttpModel *result));

@end
