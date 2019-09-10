//
//  CCUIViewController.h
//  bench_ios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Controller.h"

@class CC_View,CC_Controller;

@interface CC_ViewController : UIViewController

@property (nonatomic,retain) CC_View *cc_baseView;
@property (nonatomic,retain) NSMutableArray *cc_controllers;

// Configuration function, adds configuration to this function
// 配置函数 在此函数中添加配置
- (void)cc_viewWillLoad;
- (void)cc_registerController:(CC_Controller *)controller;

// Function used in controller
// 功能函数 在控制器使用
- (void)cc_addSubview:(id)view;
- (CC_View *)cc_viewWithName:(NSString *)name;
- (void)cc_removeViewWithName:(NSString *)name;
- (CC_Controller *)cc_controllerWithName:(NSString *)name;

// Trigger function, triggering after the condition of trigger function is reached
// 触发函数 条件达到后触发
- (void)cc_viewDidLoad;
- (void)cc_viewWillAppear;
- (void)cc_viewWillDisappear;
- (void)cc_didReceiveMemoryWarning;
- (void)cc_dealloc;

@end
