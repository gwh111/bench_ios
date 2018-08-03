//
//  UINavigationController+CCHook.m
//  bench_ios
//
//  Created by gwh on 2018/7/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UINavigationController+CCHook.h"
#import "CC_HookTrack.h"
#import "CC_Share.h"

@implementation UINavigationController(CCHook)

+ (void)hookUINavigationController_push{
    Method pushMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_pushViewController:animated:));
    method_exchangeImplementations(pushMethod, hookMethod);
}

- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSString *pushToVC=NSStringFromClass([viewController class]);
    NSString *pushFromVC=[self updateLastPushVCs:pushToVC];
    
    NSString *popDetailInfo = [NSString stringWithFormat: @"%@-%@-%@", pushFromVC, @"pushTo", pushToVC];
    [CC_HookTrack getInstance].currentVCStr=pushToVC;
    [CC_HookTrack getInstance].pushPopActionStr=popDetailInfo;
    if ([CC_HookTrack getInstance].debug) {
        CCLOG(@"###%@###", popDetailInfo);
    }
    [self hook_pushViewController:viewController animated:animated];
}

+ (void)hookUINavigationController_pop{
    Method popMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_popViewControllerAnimated:));
    method_exchangeImplementations(popMethod, hookMethod);
    {
        Method popMethod2 = class_getInstanceMethod([self class], @selector(popToViewController:animated:));
        Method hookMethod2 = class_getInstanceMethod([self class], @selector(hook_popToViewController:animated:));
        method_exchangeImplementations(popMethod2, hookMethod2);
    }
}

- (UIViewController *)hook_popViewControllerAnimated:(BOOL)animated{
    
    NSUInteger count=self.viewControllers.count;
    if (count<2) {
        return [self hook_popViewControllerAnimated:animated];
    }
    NSString *popToVC=[self updateLastPopVCs];
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@-%@-%@",[CC_HookTrack getInstance].currentVCStr,@"popTo",popToVC];
    if ([CC_HookTrack getInstance].debug) {
        CCLOG(@"###%@###", popDetailInfo);
    }
    [CC_HookTrack getInstance].pushPopActionStr=popDetailInfo;
    popDetailInfo=nil;
    [CC_HookTrack getInstance].currentVCStr=popToVC;
    return [self hook_popViewControllerAnimated:animated];
}

- (NSArray *)hook_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSString *popToVC=[self updateLastPopVCs];
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@-%@-%@",[CC_HookTrack getInstance].currentVCStr,@"popTo",NSStringFromClass([viewController class])];
    if ([CC_HookTrack getInstance].debug) {
        CCLOG(@"###%@###", popDetailInfo);
    }
    [CC_HookTrack getInstance].pushPopActionStr=popDetailInfo;
    popDetailInfo=nil;
    [CC_HookTrack getInstance].currentVCStr=popToVC;
    return [self hook_popToViewController:viewController animated:animated];
}

- (NSString *)updateLastPushVCs:(NSString *)toVC{
    NSArray *vcs=self.viewControllers;
    if (vcs.count<1) {
        return nil;
    }
    NSMutableArray *vcNames=[[NSMutableArray alloc]init];
    for (int i=0; i<vcs.count; i++) {
        NSString *lastVC=NSStringFromClass([self.viewControllers[i] class]);
        [vcNames addObject:lastVC];
    }
    [vcNames addObject:toVC];
    [CC_HookTrack getInstance].lastVCs=vcNames;
    return vcNames[vcNames.count-1];
}

- (NSString *)updateLastPopVCs{
    NSArray *vcs=self.viewControllers;
    if (vcs.count<2) {
        return nil;
    }
    NSMutableArray *vcNames=[[NSMutableArray alloc]init];
    for (int i=0; i<vcs.count; i++) {
        NSString *lastVC=NSStringFromClass([self.viewControllers[i] class]);
        [vcNames addObject:lastVC];
    }
    [CC_HookTrack getInstance].lastVCs=vcNames;
    return vcNames[vcNames.count-2];
}

@end
