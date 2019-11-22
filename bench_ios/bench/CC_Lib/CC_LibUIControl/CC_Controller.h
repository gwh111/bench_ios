//
//  CC_Controller.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_ViewController.h"

@class CC_View, CC_ScrollView;

NS_ASSUME_NONNULL_BEGIN

@interface CC_Controller : NSObject

@property (nonatomic, retain) NSString *cc_name;
@property (nonatomic, retain) CC_Delegate *cc_delegate;
@property (nonatomic, retain) CC_ScrollView *cc_displayView;

// 不借助其他属性就能初始化的配置 注册就会主动调用
- (void)cc_willInit;
// 自定义属性赋值后再操作 被动 需要自己调用
- (void)cc_init;

@end

NS_ASSUME_NONNULL_END
