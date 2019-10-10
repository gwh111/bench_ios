//
//  CC_Monitor.m
//  testbenchios
//
//  Created by gwh on 2019/8/21.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Monitor.h"
#import "CC_CoreBase.h"
#import "CC_Base.h"
#import "CC_Array.h"

#include <malloc/malloc.h>

@interface CC_Monitor ()

@property (nonatomic,retain) NSMutableDictionary *appDelegateMonitorDic;
@property (nonatomic,strong) NSThread *thread; // 监控的常驻线程

@end

@implementation CC_Monitor
@synthesize startPatrolMonitor,startLaunchMonitor,appDelegateMonitorDic,startLaunchMonitorLog,startPatrolMonitorLog;

static NSString *KEY_TIME_CONSUMINNG = @"execution time-consuming";
static NSString *KEY_MALLOC_SIZE = @"malloc_size";

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        CC_Monitor.shared.appDelegateMonitorDic = [NSMutableDictionary new];
        
        CC_Monitor.shared.startLaunchMonitor = YES;
        CC_Monitor.shared.startLaunchMonitorLog = YES;
        CC_Monitor.shared.startPatrolMonitor = YES;
        CC_Monitor.shared.thread = [[NSThread alloc]initWithTarget:CC_Monitor.shared selector:@selector(run) object:nil];
        [CC_Monitor.shared.thread start];
    }];
}

- (void)run {
    // 巡查周期
    float interval = 10.0;
    #ifdef DEBUG
    interval = 5;
    #else
    
    #endif
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(monitorPatrol) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
}

- (void)monitorPatrol {
    if (startPatrolMonitor == 0) {
        return;
    }
    NSArray *keys = CC_CoreBase.shared.sharedInstanceDic.allKeys;
    NSMutableArray *mutArr = [NSMutableArray new];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        id target = CC_CoreBase.shared.sharedInstanceDic[key];
        double size = malloc_size((__bridge const void *)target);
        [mutArr addObject:@{@"size":@(size),@"name":key}];
    }
    mutArr = [CC_Array cc_sortMutArr:mutArr byKey:@"size" desc:1];
    NSString *sizeRank = @"<<< malloc_size rank:";
    for (int i = 0; i < mutArr.count; i++) {
        sizeRank = [sizeRank stringByAppendingFormat:@"\n%@ %@",mutArr[i][@"name"],mutArr[i][@"size"]];
    }
    if (startPatrolMonitorLog) {
        CCLOG(@"%@",sizeRank);
    }
}

- (void)watchStart:(NSString *)appDelegateName method:(NSString *)method {
    if (startLaunchMonitor == 0) {
        return;
    }
    NSMutableDictionary *delegateDic = appDelegateMonitorDic[appDelegateName];
    if (!delegateDic) {
        delegateDic = [NSMutableDictionary new];
    }
    NSMutableDictionary *methodDic = delegateDic[KEY_TIME_CONSUMINNG];
    if (!methodDic) {
        methodDic = [NSMutableDictionary new];
    }
    [methodDic setObject:[NSDate date] forKey:method];
    [delegateDic setObject:methodDic forKey:KEY_TIME_CONSUMINNG];
    [appDelegateMonitorDic setObject:delegateDic forKey:appDelegateName];
}

- (void)watchEnd:(NSString *)appDelegateName method:(NSString *)method {
    if (startLaunchMonitor == 0) {
        return;
    }
    NSMutableDictionary *delegateDic = appDelegateMonitorDic[appDelegateName];
    id target = CC_CoreBase.shared.cc_sharedAppDelegate[appDelegateName];
    
    NSMutableDictionary *methodDic = delegateDic[KEY_TIME_CONSUMINNG];
    NSDate *date1 = methodDic[method];
    NSDate *date2 = [NSDate date];
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
    if (timeInterval >= 0.5) {
        // 需要优化启动速度
        if (startLaunchMonitorLog) {
            CCLOG(@"<<< warning\n<<< '%@' in '%@' need optimize '%@'",method,appDelegateName,KEY_TIME_CONSUMINNG);
        }
    }
    [methodDic setObject:@(timeInterval) forKey:method];
    [delegateDic setObject:methodDic forKey:KEY_TIME_CONSUMINNG];
    NSNumber *size = @(malloc_size((__bridge const void *)target));
    if (size.doubleValue > 1024) {
        // 需要优化内存大小
        if (startLaunchMonitorLog) {
            CCLOG(@"<<< warning\n<<< '%@' in '%@' need optimize '%@'",method,appDelegateName,KEY_MALLOC_SIZE);
        }
    }
    [delegateDic setObject:size forKey:KEY_MALLOC_SIZE];
    [appDelegateMonitorDic setObject:delegateDic forKey:appDelegateName];
}

- (void)reviewLaunchFinish {
    if (startLaunchMonitor == 0) {
        return;
    }
    if (startLaunchMonitorLog) {
        CCLOG(@"%@",appDelegateMonitorDic);
    }
}

@end
