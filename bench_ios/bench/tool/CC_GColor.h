//
//  CC_GColor.h
//  bench_ios
//
//  Created by gwh on 2017/8/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_GColor : NSObject

/**
 *  制定图片 特定位置获取颜色
 */
+ (UIColor* )getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;

/**
 * 获得图片中churc除白色最可能的特征色
 * 当找不到颜色时返回白色
 */
+ (UIColor* )getImageMayColor:(UIImage *)image;

/**
 * 判断两个颜色是否相近
 * 区间0-1  0 完全相同 1 完全不同 自定义阈值
 */
+ (float)judgeColorA:(UIColor *)colorA andColorB:(UIColor *)colorB;

@end
