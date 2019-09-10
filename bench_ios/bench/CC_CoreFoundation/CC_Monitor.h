//
//  CC_Monitor.h
//  testbenchios
//
//  Created by gwh on 2019/8/21.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Monitor : NSObject

// 启动监控 默认开启
@property (nonatomic,assign) BOOL startLaunchMonitor;
// 启动监控日志 默认开启
@property (nonatomic,assign) BOOL startLaunchMonitorLog;
// 定期检查 默认开启
@property (nonatomic,assign) BOOL startPatrolMonitor;
// 定期检查日志 默认关闭
@property (nonatomic,assign) BOOL startPatrolMonitorLog;

+ (instancetype)shared;

- (void)watchStart:(NSString *)appDelegateName method:(NSString *)method;

- (void)watchEnd:(NSString *)appDelegateName method:(NSString *)method;

- (void)reviewLaunchFinish;

@end

NS_ASSUME_NONNULL_END
