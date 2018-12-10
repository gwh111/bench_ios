//
//  CC_TManager.h
//  bench_ios
//
//  Created by gwh on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_TManager : NSObject

+ (instancetype)getInstance;

/**
 *  初始化
    在getInstance里自动初始化
 */
- (void)initT;

/**
 *  注册定时任务
    name 定时任务名称
    interval 时间间隔
    每个间隔后回调出去
 */
- (void)registerT:(NSString *)name interval:(float)interval block:(void (^)(void))block;

/**
 *  取消注册的定时任务
 */
- (void)unRegisterT:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
