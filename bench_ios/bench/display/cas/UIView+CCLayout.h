//
//  UIView+CCLayout.h
//  bench_ios
//
//  Created by gwh on 2018/7/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ClassyCat.h"

@interface UIView (CCLayout)

/**
 *  更新动态布局
 *  在接口请求结果返回后更新布局约束效果
 */
- (void)updateLayout;
/**
 *  设备上读取的刷新方法
 */
- (void)updateLayout_device;
/**
 *  模拟器上读取的刷新方法
 */
- (void)updateLayout_simulator;

@end
