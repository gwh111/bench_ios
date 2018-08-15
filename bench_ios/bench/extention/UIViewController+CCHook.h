//
//  UIViewController+CCHook.h
//  bench_ios
//
//  Created by gwh on 2018/7/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIViewController(CCHook)

+ (void)hookUIViewController;

@end
