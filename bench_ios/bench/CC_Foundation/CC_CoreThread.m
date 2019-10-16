//
//  CC_Thread.m
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

// NSThread三种实现开启线程方式：

// NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(xxx:) object:xxx];
// thread.threadPriority = 1;// 设置线程的优先级(0.0 - 1.0，1.0最高级)
// [thread start];

// [NSThread detachNewThreadSelector:@selector(xxx:) toTarget:self withObject:xxx];

// [self performSelectorInBackground:@selector(loadImageSource:) withObject:imgUrl];

// 异步函数 + 并发队列：可以同时开启多条线程
// 同步函数 + 并发队列：不会开启新的线程
// 异步函数 + 主队列：只在主线程中执行任务
// 同步函数 + 主队列：堵塞主线程，禁用

#import "CC_CoreThread.h"

@interface CC_CoreThread ()

@property (nonatomic,retain) NSMutableDictionary *queueMap;

@end
@implementation CC_CoreThread

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (void)cc_delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block{
    if (!CC_CoreThread.shared.queueMap) {
        CC_CoreThread.shared.queueMap = [[NSMutableDictionary alloc] init];
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:delayInSeconds];
    }];
    [queue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            block();
        }];
    }];
    if (CC_CoreThread.shared.queueMap[key]) {
        [self cc_delayStop:key];
    }
    [CC_CoreThread.shared.queueMap cc_setKey:key value:queue];
}

- (void)cc_delayStop:(NSString *)key {
    NSOperationQueue *queue = CC_CoreThread.shared.queueMap[key];
    if (queue) {
        [queue cancelAllOperations];
        [CC_CoreThread.shared.queueMap cc_removeKey:key];
    }
}

- (void)cc_gotoThread:(void (^)(void))block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作放在这里
        block();
    });
}

- (void)cc_gotoMain:(void (^)(void))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 回到主线程进行UI操作
        block();
    });
}

- (void)cc_gotoThreadSync:(void (^)(void))block {
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作放在这里
        block();
    });
}

- (void)cc_gotoMainSync:(void (^)(void))block {
    dispatch_sync(dispatch_get_main_queue(), ^{
        // 回到主线程进行UI操作
        block();
    });
}

- (void)cc_delay:(double)delayInSeconds block:(void (^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block();
    });
}

- (void)cc_blockFinish:(id)sema {
    dispatch_semaphore_signal(sema);
}

- (void)cc_blockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block {
    [self cc_gotoThread:^{
        int count = (int)taskCount;
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            block(i,0,sema);
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        [self cc_gotoMain:^{
            block(taskCount,1,nil);
        }];
    }];
}

- (void)cc_group:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block{
    dispatch_group_t group = dispatch_group_create();
    int count = (int)taskCount;
    for (int i = 0; i < count; i++) {
        [self cc_gotoThread:^{
            block(i, 0);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        block(taskCount, 1);
    });
}

- (void)cc_blockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block{
    dispatch_group_t group = dispatch_group_create();
    int count = (int)taskCount;
    for (int i = 0; i < count; i++) {
        [self cc_gotoThread:^{
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            block(i,0,sema);
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        block(taskCount,1,nil);
    });
}

@end

