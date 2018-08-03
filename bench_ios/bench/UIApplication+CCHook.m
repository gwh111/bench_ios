//
//  UIApplication+CCHook.m
//  bench_ios
//
//  Created by gwh on 2018/7/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIApplication+CCHook.h"
#import <objc/runtime.h>

@implementation UIApplication(CCHook)

+ (void)hookUIApplication{
    Method controlMethod = class_getInstanceMethod([UIApplication class], @selector(sendAction:to:from:forEvent:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_sendAction:to:from:forEvent:));
    method_exchangeImplementations(controlMethod, hookMethod);
}

- (BOOL)hook_sendAction:(SEL)action to:(nullable id)target from:(nullable id)sender forEvent:(nullable UIEvent *)event;{
//    NSString *actionDetailInfo = [NSString stringWithFormat:@" %@ - %@ - %@", NSStringFromClass([target class]), NSStringFromClass([sender class]), NSStringFromSelector(action)];
//    NSLog(@"%@", actionDetailInfo);
    return [self hook_sendAction:action to:target from:sender forEvent:event];
}

@end
