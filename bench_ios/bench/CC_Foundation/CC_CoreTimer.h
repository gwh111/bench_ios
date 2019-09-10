//
//  CC_TManager.h
//  bench_ios
//
//  Created by gwh on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_CoreThread.h"

@interface CC_CoreTimer : NSObject

+ (instancetype)shared;

// 注册定时任务
// @param name 定时任务名称
// @param interval 时间间隔
- (void)cc_registerT:(NSString *)name interval:(float)interval block:(void (^)(void))block;

// 取消注册的定时任务
- (void)cc_unRegisterT:(NSString *)name;

- (NSString *)cc_uniqueNowTimestamp;
- (NSString *)cc_nowTimeTimestamp;

@end



