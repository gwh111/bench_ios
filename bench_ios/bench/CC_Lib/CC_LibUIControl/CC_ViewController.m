//
//  CCUIViewController.m
//  bench_ios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_ViewController.h"
#import "CC_View.h"

@interface CC_ViewController (){
}

@end

@implementation CC_ViewController
@synthesize cc_baseView,cc_controllers;
// Auto property synthesis will not synthesize property 'view'; it will be implemented by its superclass, use @dynamic to acknowledge intention
// 添加 @dynamic告诉编译器这个属性是动态的,动态的意思是等你编译的时候就知道了它只在本类合成;
//@dynamic view;

- (void)cc_registerController:(CC_Controller *)controller {
    controller.cc_delegate = [CC_Base.shared cc_init:CC_Delegate.class];
    controller.cc_delegate.delegate = self;
    [controller cc_willInit];
    [cc_controllers cc_addObject:controller];
}

- (CC_Controller *)cc_controllerWithName:(NSString *)name {
    for (CC_Controller *controller in cc_controllers) {
        if ([controller.cc_name isEqualToString:name]) {
            return controller;
        }
    }
    return nil;
}

- (void)cc_addSubview:(id)view {
    [cc_baseView addSubview:view];
}

- (void)cc_removeViewWithName:(NSString *)name {
    UIView *view = [cc_baseView cc_viewWithName:name];
    if (view) {
        [view removeFromSuperview];
    }
}

- (CC_View *)cc_viewWithName:(NSString *)name {
    return [cc_baseView cc_viewWithName:name];
}

- (void)cc_viewWillLoad {}

- (void)super_cc_viewWillLoad {
    cc_baseView = [CC_Base.shared cc_init:CC_View.class];
    cc_baseView.frame = self.view.frame;
    [self.view addSubview:cc_baseView];
    
    cc_controllers = [CC_Base.shared cc_init:NSMutableArray.class];
}

- (void)cc_viewDidLoad {}

- (void)cc_viewWillAppear {}

- (void)cc_viewWillDisappear {}

- (void)cc_didReceiveMemoryWarning {}

- (void)cc_dealloc {}

#pragma mark kit function

- (void)viewDidLoad {
    [super viewDidLoad];
    [self super_cc_viewWillLoad];
    [self cc_viewWillLoad];
    [self cc_viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self cc_viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self cc_viewWillDisappear];
}

- (void)didReceiveMemoryWarning {
    [self cc_didReceiveMemoryWarning];
}

- (void)dealloc {
    [cc_controllers removeAllObjects];
    [self cc_dealloc];
}

@end
