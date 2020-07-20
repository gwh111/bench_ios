//
//  CC_Thread.h
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

@interface CC_Thread : CC_Object

+ (instancetype)shared;

- (void)delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block;
- (void)delayStop:(NSString *)key;

- (void)gotoThread:(void (^)(void))block;
- (void)gotoMain:(void (^)(void))block;

- (void)gotoThreadSync:(void (^)(void))block;
- (void)gotoMainSync:(void (^)(void))block;

- (void)delay:(double)delayInSeconds block:(void (^)(void))block;

// Run task in multiple thread same time.
// Will return back to main thread after finish all the task.
- (void)group:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block;

// Run block function in order.
// Use 'blockFinish:' in block.
- (void)blockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;

// Will block 'finish==YES' after block functions finish, default is back in main thread!
// Use 'blockFinish:' in block.
- (void)blockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;

// Mark a semaphore after block is done.
- (void)blockFinish:(id)sema;

@end

