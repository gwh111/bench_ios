//
//  CCUIViewController.m
//  bench_ios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_ViewController.h"
#import "CC_View.h"
#import "CC_NavigationController.h"

@interface CC_ViewController (){
}

@end

@implementation CC_ViewController
@synthesize cc_displayView,cc_controllers,cc_navigationBar,parent,cc_navigationBarHidden;
// Auto property synthesis will not synthesize property 'view'; it will be implemented by its superclass, use @dynamic to acknowledge intention
// 添加 @dynamic告诉编译器这个属性是动态的,动态的意思是等你编译的时候就知道了它只在本类合成;
//@dynamic view;

// Function used in controller
- (void)cc_viewWillLoad {}

- (void)super_cc_viewWillLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    
    cc_displayView = [CC_Base.shared cc_init:CC_ScrollView.class];
    cc_displayView.frame = self.view.frame;
    [self.view addSubview:cc_displayView];
    
    cc_controllers = [CC_Base.shared cc_init:NSMutableArray.class];
    
    cc_navigationBar = [CC_Base.shared cc_init:CC_NavigationBar.class];
    [cc_navigationBar cc_updateConfig:CC_NavigationController.shared.cc_navigationBarConfig];
    [self.view addSubview:cc_navigationBar];
    
    [cc_navigationBar.backButton cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
        [CC_NavigationController.shared cc_popViewController];

    }];
    
    if (CC_NavigationController.shared.cc_UINav.viewControllers.count <= 1) {
        cc_navigationBar.backButton.hidden = YES;
    }
    
    cc_navigationBar.hidden = cc_navigationBarHidden;
    
    cc_displayView.top = cc_navigationBarHidden? Y():cc_navigationBar.bottom;
    cc_displayView.height = cc_displayView.height - cc_navigationBar.bottom  - CC_CoreUI.shared.safeBottom;
    
    if (CC_NavigationController.shared.cc_UINav.viewControllers.count <= 1) {
        cc_navigationBar.backButton.hidden = YES;
    }
    
    if ([parent isKindOfClass:UITabBarController.class]) {
        cc_displayView.height = cc_displayView.height - CC_CoreUI.shared.uiTabBarHeight;
    }
    
    if (_cc_title) {
        cc_navigationBar.titleLabel.text = _cc_title;
    }
}

- (void)setCc_navigationBarHidden:(BOOL)hidden {
    cc_navigationBarHidden = hidden;
    cc_navigationBar.hidden = cc_navigationBarHidden;
    if (cc_displayView) {
        cc_displayView.top = cc_navigationBarHidden? Y():cc_navigationBar.bottom;
        cc_displayView.height = cc_displayView.height + CC_CoreUI.shared.uiNavBarHeight;
    }
}

- (void)cc_registerController:(CC_Controller *)controller {
    controller.cc_delegate = [CC_Base.shared cc_init:CC_Delegate.class];
    controller.cc_delegate.delegate = self;
    controller.cc_displayView = cc_displayView;
    [controller cc_willInit];
    [cc_controllers cc_addObject:controller];
}

- (void)setCc_title:(NSString *)title {
    _cc_title = title;
    cc_navigationBar.titleLabel.text = title;
}

// Function used in controller
- (void)cc_addSubview:(id)view {
    [cc_displayView addSubview:view];
}

- (void)cc_removeViewWithName:(NSString *)name {
    UIView *view = [cc_displayView cc_viewWithName:name];
    if (view) {
        [view removeFromSuperview];
    }
}

- (CC_View *)cc_viewWithName:(NSString *)name {
    return [cc_displayView cc_viewWithName:name];
}

- (CC_Controller *)cc_controllerWithName:(NSString *)name {
    for (CC_Controller *controller in cc_controllers) {
        if ([controller.cc_name isEqualToString:name]) {
            return controller;
        }
    }
    return nil;
}

- (void)cc_adaptUI {
    for (UIView *view in cc_displayView.subviews) {
        if (view.bottom > cc_displayView.contentSize.height) {
            cc_displayView.contentSize = CGSizeMake(cc_displayView.width, view.bottom);
        }
    }
}

// Trigger function, triggering after the condition of trigger function is reached
- (void)cc_viewDidPopFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {}

- (void)cc_viewDidLoad {}

- (void)cc_viewWillAppear {}

- (void)cc_viewWillDisappear {}

- (void)cc_didReceiveMemoryWarning {}

- (void)cc_dealloc {}

#pragma mark kit function

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
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
