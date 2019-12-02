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

@interface CC_NavigationController (){
    
}

@end

@implementation CC_NavigationController
@synthesize cc_UINav, cc_UINavList;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        CC_NavigationController.shared.cc_UINavList = NSMutableArray.new;
        CC_NavigationBarConfig *config = CC_NavigationBarConfig.new;
        config.cc_navigationBarTitleFont = [CC_CoreUI.shared relativeFont:@"Helvetica-Bold" fontSize:19];
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

- (void)cc_push:(Class)aClass {
    [self cc_pushViewController:[CC_Base.shared cc_init:aClass]];
}

- (void)cc_pushViewController:(CC_ViewController *)viewController {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.firstObject;
        [navC pushViewController:viewController animated:YES];
        return;
    }
    [cc_UINav pushViewController:viewController animated:YES];
}

- (void)cc_presentViewController:(CC_ViewController *)viewController {
    [cc_UINav presentViewController:viewController animated:YES completion:nil];
}

- (void)cc_presentViewController:(CC_ViewController *)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style {
    
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navC.navigationBarHidden = YES;
    navC.modalPresentationStyle = style;
    
    [cc_UINavList addObject:navC];
    
    [cc_UINav presentViewController:navC animated:YES completion:nil];
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
        [controllers removeObjectAtIndex:controllers.count - 2];
        cc_UINav.viewControllers = controllers;
    }
}

- (CC_ViewController *)cc_popViewController {
    return [self cc_popViewControllerAnimated:YES];
}

- (CC_ViewController *)cc_popViewControllerFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    CC_ViewController *pop = [self cc_popViewControllerAnimated:YES];
    CC_ViewController *last = cc_UINav.viewControllers.lastObject;
    [last cc_viewDidPopFrom:pop userInfo:userInfo];
    return pop;
}

- (void)cc_dismissViewController {
    if (cc_UINavList.count > 0) {
        UINavigationController *navC = cc_UINavList.firstObject;
        [navC dismissViewControllerAnimated:YES completion:^{
        }];
        [cc_UINavList removeLastObject];
        return;
    }
    [cc_UINav dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)cc_popToViewController:(Class)aClass {
    for (CC_ViewController *viewController in cc_UINav.viewControllers) {
        if ([viewController isKindOfClass:aClass]) {
            [cc_UINav popToViewController:viewController animated:YES];
            return;
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
