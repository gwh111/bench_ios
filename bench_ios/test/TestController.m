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

@end
