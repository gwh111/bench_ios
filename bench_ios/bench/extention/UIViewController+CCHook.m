//
//  UIViewController+CCHook.m
//  bench_ios
//
//  Created by gwh on 2018/7/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+CCHook.h"

@implementation UIViewController(CCHook)

+ (void)hookUIViewController{
    Method appearMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_ViewDidAppear:));
    method_exchangeImplementations(appearMethod, hookMethod);
}


- (void)hook_ViewDidAppear:(BOOL)animated{
//    NSString *appearDetailInfo = [NSString stringWithFormat:@" %@ - %@", NSStringFromClass([self class]), @"didAppear"];
//    NSLog(@"%@", appearDetailInfo);
    [self hook_ViewDidAppear:animated];
}

@end
