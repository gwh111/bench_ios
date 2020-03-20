//
//  testController.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestController.h"

@implementation TestController

- (void)cc_willInit {
    // 初始化配置
    self.cc_name = @"test1";
    
    [ccs delay:2 block:^{
        // 初始化配置完成
        [self.cc_delegate cc_performSelector:@selector(methd2withA:b:) params:@"",@""];
    }];
}

- (void)cc_setup:(void (^)(TestController *c))block {
    
    @autoreleasepool {
        
        
    }
    
    [ccs delay:2 block:^{
       
        block(self);
    }];
    
}

@end

@implementation ExtensionClass

- (void)m1 {
    // 发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mytest:) name:@"mytest" object:self];
    // 接收通知
    [NSNotificationCenter.defaultCenter postNotificationName:@"mytest" object:self];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mytest:) name:@"mytest" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mytest" object:nil];
}

- (void)mytest:(NSNotification *)notification {
    
}

@end
