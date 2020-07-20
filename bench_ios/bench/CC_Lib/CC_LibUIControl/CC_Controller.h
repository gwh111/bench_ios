//
//  CC_Controller.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_ViewController.h"

@class CC_View, CC_ScrollView, CC_ViewController;

@interface CC_Controller : CC_Object

@property (nonatomic, retain) NSString *cc_name;
@property (nonatomic, retain) CC_Delegate *cc_delegate;
@property (nonatomic, retain) CC_ScrollView *cc_displayView;
@property (strong) void (^cc_actionBlock)(NSDictionary *data);

+ (instancetype)cc_controllerInVC:(CC_ViewController *)vc;

// 配置 注册就会主动调用
- (void)cc_setup;

// 配置回调，如重写需要自己调用block(self)
- (void)cc_setup:(void(^)(id c))block;

// 不借助其他属性就能初始化的配置 注册就会主动调用
- (void)cc_willInit;

@end
