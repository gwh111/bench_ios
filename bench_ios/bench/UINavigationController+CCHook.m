//
//  UINavigationController+CCHook.m
//  bench_ios
//
//  Created by gwh on 2018/7/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UINavigationController+CCHook.h"

@implementation UINavigationController(CCHook)

+ (void)hookUINavigationController_push
{
    Method pushMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_pushViewController:animated:));
    method_exchangeImplementations(pushMethod, hookMethod);
}

- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    NSString *popDetailInfo = [NSString stringWithFormat: @"%@ - %@ - %@", NSStringFromClass([self class]), @"push", NSStringFromClass([viewController class])];
//    NSLog(@"%@", popDetailInfo);
    [self hook_pushViewController:viewController animated:animated];
}

+ (void)hookUINavigationController_pop
{
    Method popMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_popViewControllerAnimated:));
    method_exchangeImplementations(popMethod, hookMethod);
}

- (void)hook_popViewControllerAnimated:(BOOL)animated
{
//    NSString *popDetailInfo = [NSString stringWithFormat:@"%@ - %@", NSStringFromClass([self class]), @"pop"];
//    NSLog(@"%@", popDetailInfo);
    [self hook_popViewControllerAnimated:animated];
}

@end
