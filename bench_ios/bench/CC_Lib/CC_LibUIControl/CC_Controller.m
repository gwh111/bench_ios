//
//  CC_Controller.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Controller.h"

@interface CC_Controller ()

@end

@implementation CC_Controller
@synthesize cc_delegate;

+ (instancetype)cc_controllerInVC:(CC_ViewController *)vc {
    return [vc cc_controllerWithName:NSStringFromClass(self.class)];
}

- (void)cc_setup {
    self.cc_name = NSStringFromClass(self.class);
}

- (void)cc_setup:(void(^)(id c))block {
    
    [self cc_setup];
    if (block) {
        block(self);
    }
}

// 不借助其他属性就能初始化的配置 注册就会主动调用
- (void)cc_willInit {
    
}

@end
