//
//  testVC.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestViewController2.h"
#import "CC_Date.h"

#import "TestController.h"
#import "ccs.h"

#import "HomeVC.h"

@interface TestViewController2 () {
    UILabel *label;
}

@end

@implementation TestViewController2

- (void)methd2withA:(NSString *)a b:(NSArray *)b{
    // TestController里的协议
    CCLOG(@"callback methd2withA");
}

- (void)cc_viewWillLoad {
    self.cc_title = @"asdb";
    
    
    TestController *controller = [ccs anObject:TestController.class];
    //  注册完可直接实现TestController里的协议'methd2withA:b:'
    [self cc_registerController:controller];
}

- (void)cc_viewDidLoad {
    IMAGE(@"asd");
    // 方法一 不再使用 使用方法三
    UILabel *label = [[UILabel alloc]init];
    label.name = @"label1";
    label.frame=CGRectMake(0, 0, 0, 0);
    label.backgroundColor = HEXA(@"FFD700", 1);
    label.textColor = HEXA(@"9B30FF", 1);
    [label cc_tappedInterval:0.1 withBlock:^(id view) {
        CCLOG(@"abc");
    }];
    [self.view addSubview:label];
    
    // 方法二
//    [ccui get_label:^(UILabel *label) {
//        label.cc_name(@"mylabel")
//            .cc_frame(RH(10),RH(100),RH(100),RH(100))
//        .cc_backgroundColor(HEXA(@"FFD700", 1))
//        .cc_textColor(HEXA(@"9B30FF", 1))
//        .cc_bindText(str)
//        .cc_tappedInterval(3,^(id view) {
//            CCLOG(@"abc");
//        });
//        [self addSubview:label];
//        CCLOG(@"%@",label.name);
//    }];
    
    // 绑定string
    NSString *str = [ccs string:@"abc%@%d",@"a",34];
    // 方法三
    
    CC_Label *l = ccs.Label
    .cc_textColor(HEXA(@"9B30FF", 1))
    .cc_name(@"mylabel")
    .cc_frame(RH(10),RH(100),RH(100),RH(100))
    .cc_backgroundColor(HEXA(@"FFD700", 1))
    .cc_addToView(self.view);
        
    [l bindText:str];
    [l cc_tappedInterval:0.1 withBlock:^(id view) {
        // 改变labele内的富文本
        NSMutableAttributedString *att = ccs.mutableAttributedString;
        [att cc_appendAttStr:@"abc" color:COLOR_LIGHT_ORANGE];
        [att cc_appendAttStr:@"123" color:[UIColor greenColor] font:RF(22)];
        CC_Label *v = view;
        v.attributedText = att;
        // 延时5秒后退出控制器并进入一个新控制器
        [ccs delay:5 block:^{
            [ccs pushViewController:[ccs anObject:self.class] withDismissVisible:NO];
            // [ccs popToViewController:HomeVC.class];
        }];
    }];
    
    // 3秒后更新string view跟踪变化
    [ccs delay:3 block:^{
        // 无需获取控件，更新数据源自动更新视图控件
        [str cc_update:@"cvb"];
    }];
    
    [ccs textAttachment]
    .cc_emojiTag(@"a")
    .cc_emojiName(@"b");
    
    [ccs delay:1 block:^{
        [self funtionB];
    }];

}

- (void)funtionB {
    [self cc_controllerWithName:@""];
    [self cc_viewWithName:@"abc"];
//    [ccs view:self];
//    [ccs getView:self withName:@"mylabel"]
//    .cc_backgroundColor(HEXA(@"54FF9F", 1));
}

- (void)dealloc
{
    CCLOG(@"vc dealloc");
}

@end
