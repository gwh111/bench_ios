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
#import "ccs.h"

@interface CC_NavigationController (){
    
}

@end

@implementation CC_NavigationController
@synthesize cc_UINav, cc_UINavList;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        CC_NavigationController.shared.cc_UINavList = NSMutableArray.new;
        CC_NavigationBarConfig *config = CC_NavigationBarConfig.new;
        config.cc_navigationBarTitleFont = RF(19);
        config.cc_navigationBarTitleColor = HEX(#000000);
        config.cc_navigationBarBackgroundColor = UIColor.whiteColor;
        CC_NavigationController.shared.cc_navigationBarConfig = config;
    }];
}

- (void)cc_willInit {
    
}

- (void)cc_initNavigationBarWithTitleFont:(UIFont *)font
                               titleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                          backgroundImage:(UIImage *)backgroundImage {
    _cc_navigationBarConfig.cc_navigationBarTitleFont = font;
    _cc_navigationBarConfig.cc_navigationBarTitleColor = titleColor;
    _cc_navigationBarConfig.cc_navigationBarBackgroundColor = backgroundColor;
    _cc_navigationBarConfig.cc_navigationBarBackgroundImage = backgroundImage;
}

- (CC_ViewController *)currentVC {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        return navC.viewControllers.lastObject;
    }
    return cc_UINav.viewControllers.lastObject;
}

- (CC_TabBarController *)currentTabBarC {
    for (UINavigationController *navC in cc_UINavList) {
        NSArray *vcs = navC.viewControllers;
        for (id vc in vcs) {
            if ([vc isKindOfClass:CC_TabBarController.class]) {
                return vc;
            }
        }
    }
    NSArray *vcs = cc_UINav.viewControllers;
    for (id vc in vcs) {
        if ([vc isKindOfClass:CC_TabBarController.class]) {
            return vc;
        }
    }
    return nil;
}

- (void)cc_pushViewController:(id)viewController animated:(BOOL)animated {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        [navC pushViewController:viewController animated:animated];
        return;
    }
    [cc_UINav pushViewController:viewController animated:animated];
}

- (void)cc_pushViewController:(id)viewController {
    [self cc_pushViewController:viewController animated:YES];
}

- (void)cc_presentViewController:(id)viewController {
    [self cc_presentViewController:viewController withNavigationControllerStyle:UIModalPresentationFullScreen];
}

- (void)cc_presentViewController:(id)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style {
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navC.navigationBarHidden = YES;
    navC.modalPresentationStyle = style;
    
    [cc_UINavList addObject:navC];
    
    [cc_UINav presentViewController:navC animated:YES completion:nil];
}

- (void)cc_pushViewController:(id)viewController withDismissVisible:(BOOL)visible {
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
        [controllers removeObjectAtIndex:controllers.count - 2];
        cc_UINav.viewControllers = controllers;
    }
}

- (CC_ViewController *)cc_popViewController {
    return [self cc_popViewControllerAnimated:YES];
}

- (CC_ViewController *)cc_popViewControllerFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    CC_ViewController *pop = [self cc_popViewControllerAnimated:YES];
    if ([pop isKindOfClass:CC_ViewController.class]) {
        pop.cc_controllers = nil;
    }
    CC_ViewController *last = cc_UINav.viewControllers.lastObject;
    [last cc_viewDidPopFrom:pop userInfo:userInfo];
    return pop;
}

- (void)cc_dismissViewController {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        [navC dismissViewControllerAnimated:YES completion:^{
        }];
        [cc_UINavList removeLastObject];
        return;
    }
    [cc_UINav dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)cc_popToViewController:(Class)aClass {
    NSUInteger count = cc_UINav.viewControllers.count;
    for (int i = 0; i < count; i++) {
        CC_ViewController *vc = cc_UINav.viewControllers[count - i - 1];
        if ([vc isKindOfClass:aClass]) {
            [cc_UINav popToViewController:vc animated:YES];
            return;
        }
        if ([vc isKindOfClass:CC_ViewController.class]) {
            vc.cc_controllers = nil;
        }
    }
}

- (void)cc_popToRootViewControllerAnimated:(BOOL)animated {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        for (int i = 0; i < navC.viewControllers.count; i++) {
            if (i > 0) {
                CC_ViewController *vc = navC.viewControllers[i];
                if ([vc isKindOfClass:CC_ViewController.class]) {
                    vc.cc_controllers = nil;
                }
            }
        }
        [navC popToRootViewControllerAnimated:animated];
        return;
    }
    for (int i = 0; i < cc_UINav.viewControllers.count; i++) {
        if (i > 0) {
            CC_ViewController *vc = cc_UINav.viewControllers[i];
            if ([vc isKindOfClass:CC_ViewController.class]) {
                vc.cc_controllers = nil;
            }
        }
    }
    [cc_UINav popToRootViewControllerAnimated:YES];
}

- (CC_ViewController *)cc_popViewControllerAnimated:(BOOL)animated {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        CC_ViewController *last = navC.viewControllers.lastObject;
        if ([last isKindOfClass:CC_ViewController.class]) {
            last.cc_controllers = nil;
        }
        [navC popViewControllerAnimated:animated];
        return last;
    }
    CC_ViewController *last = cc_UINav.viewControllers.lastObject;
    if ([last isKindOfClass:CC_ViewController.class]) {
        last.cc_controllers = nil;
    }
    [cc_UINav popViewControllerAnimated:animated];
    return last;
}

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr {
    CC_WebViewController *web = [[CC_WebViewController alloc]init];
    web.urlStr = urlStr;
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.lastObject;
        [navC pushViewController:web animated:YES];
        return;
    }
    [cc_UINav pushViewController:web animated:YES];
}

@end
