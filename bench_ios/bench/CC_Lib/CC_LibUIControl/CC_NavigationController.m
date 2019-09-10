//
//  CC_NavigationController.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_NavigationController.h"
#import "CC_WebViewController.h"
#import "CC_Base.h"

@implementation CC_NavigationController
@synthesize cc_UINav;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (void)cc_willInit {
//    cc_controllers = [CC_Base cc_init:[NSMutableArray class]];
}

//- (void)cc_initWithRootController:(CC_Controller *)controller{
//    [cc_controllers addObject:controller];
//    cc_UINav = [[UINavigationController alloc] initWithRootViewController:controller.cc_viewController];
//}

- (void)cc_push:(Class)class {
    [self cc_pushViewController:[CC_Base.shared cc_init:class]];
}

- (void)cc_pushViewController:(CC_ViewController *)viewController {
    [cc_UINav pushViewController:viewController animated:YES];
}

- (void)cc_pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)visible {
    if (visible) {
        [self cc_popViewControllerAnimated:NO];
        [cc_UINav pushViewController:viewController animated:YES];
    } else {
        [cc_UINav pushViewController:viewController animated:YES];
        NSMutableArray *controllers = cc_UINav.viewControllers.mutableCopy;
        if (controllers.count <= 2) {
            // 首页controller不能移除
            return;
        }
        [controllers removeObjectAtIndex:controllers.count-2];
        cc_UINav.viewControllers = controllers;
    }
}

- (CC_ViewController *)cc_popViewController {
    return [self cc_popViewControllerAnimated:YES];
}

- (void)cc_popToViewController:(Class)class {
    for (CC_ViewController *viewController in cc_UINav.viewControllers) {
        if ([viewController isKindOfClass:class]) {
            [cc_UINav popToViewController:viewController animated:YES];
        }
    }
}

- (void)cc_popToRootViewControllerAnimated:(BOOL)animated {
    [cc_UINav popToRootViewControllerAnimated:YES];
}

- (CC_ViewController *)cc_popViewControllerAnimated:(BOOL)animated {
    CC_ViewController *last = cc_UINav.viewControllers.lastObject;
    [cc_UINav popViewControllerAnimated:animated];
    return last;
}

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr {
    CC_WebViewController *web = [[CC_WebViewController alloc]init];
    web.urlStr = urlStr;
    [cc_UINav pushViewController:web animated:YES];
}

@end
