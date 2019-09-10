//
//  testThread.m
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestThread.h"

@implementation TestThread

+ (void)start{
    
    // 一组异步任务 在多个线程执行
    if ((1)) {
        CCLOG(@"cc_group %@",[NSThread currentThread]);
        [ccs threadGroup:3 block:^(NSUInteger taskIndex, BOOL finish) {
            if (taskIndex==0) {
                CCLOG(@"cc_group 0 finish %d %@",finish,[NSThread currentThread]);
            }else if (taskIndex==1){
                CCLOG(@"cc_group 1 finish %d %@",finish,[NSThread currentThread]);
            }else if (taskIndex==2){
                CCLOG(@"cc_group 2 finish %d %@",finish,[NSThread currentThread]);
            }else{
                CCLOG(@"cc_group 3 finish %d %@",finish,[NSThread currentThread]);
            }
        }];
    }
    
    // 异步完成一组有异步回调的函数后执行下一个函数
    if ((1)) {
        CCLOG(@"cc_blockGroup %@",[NSThread currentThread]);
        [ccs threadBlockGroup:2 block:^(NSUInteger taskIndex, BOOL finish, id sema) {
            if (taskIndex==0) {
                CCLOG(@"cc_blockGroup 0 %@",[NSThread currentThread]);
                [ccs delay:10 block:^{
                    [ccs threadBlockFinish:sema];
                }];
            }else if (taskIndex==1){
                CCLOG(@"cc_blockGroup 1 %@",[NSThread currentThread]);
                [ccs delay:2 block:^{
                    [ccs threadBlockFinish:sema];
                }];
            }
            if (finish) {
                CCLOG(@"cc_blockGroup finish %@",[NSThread currentThread]);
            }
        }];
    }
    
    // 顺序执行一组有异步回调的函数后执行下一个函数
    if ((0)) {
        CCLOG(@"cc_blockSequence %@",[NSThread currentThread]);
        [ccs threadBlockSequence:2 block:^(NSUInteger taskIndex, BOOL finish, id  _Nonnull sema) {
            if (taskIndex==0) {
                CCLOG(@"cc_blockSequence 0 %@",[NSThread currentThread]);
                [ccs delay:5 block:^{
                    [ccs threadBlockFinish:sema];;
                }];
            } else if (taskIndex==1) {
                CCLOG(@"cc_blockSequence 1 %@",[NSThread currentThread]);
                [ccs delay:2 block:^{
                    [ccs threadBlockFinish:sema];;
                }];
            }
            if (finish) {
                CCLOG(@"cc_blockSequence finish %@",[NSThread currentThread]);
            }
        }];

    }
    
}

@end
