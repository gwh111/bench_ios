//
//  CC_Color.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "UIColor+CC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Color : UIColor

// 制定图片 特定位置获取颜色
+ (UIColor *)cc_pixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;

// 获得图片中除白色最可能的特征色
// 当找不到颜色时返回白色
+ (UIColor *)cc_colorOfImage:(UIImage *)image;

// 获得图片中除白色最可能的特征色2 验证后留1种或合并
+ (UIColor *)cc_colorOfImage2:(UIImage *)image;

// 判断两个颜色是否相近
// 区间0-1  0 完全相同 1 完全不同 自定义阈值
+ (float)cc_compareColorA:(UIColor *)colorA andColorB:(UIColor *)colorB;

@end

NS_ASSUME_NONNULL_END
