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

@interface CC_CoreThread : NSObject

+ (instancetype)shared;

- (void)cc_delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block;
- (void)cc_delayStop:(NSString *)key;

- (void)cc_gotoThread:(void (^)(void))block;
- (void)cc_gotoMain:(void (^)(void))block;

- (void)cc_gotoThreadSync:(void (^)(void))block;
- (void)cc_gotoMainSync:(void (^)(void))block;

- (void)cc_delay:(double)delayInSeconds block:(void (^)(void))block;

// Run task in multiple thread same time.
// Will return back to main thread after finish all the task.
- (void)cc_group:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block;

// Run block function in order.
// Use 'cc_blockFinish:' in block.
- (void)cc_blockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;

// Will block 'finish==YES' after block functions finish, default is back in main thread!
// Use 'cc_blockFinish:' in block.
- (void)cc_blockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;

// Mark a semaphore after block is done.
- (void)cc_blockFinish:(id)sema;

@end

