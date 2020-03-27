//
//  CC_Tool+Color.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Color)

#pragma mark instance

- (NSString *)changeUIColorToRGB:(UIColor *)color;

- (BOOL)isSameColor:(UIColor *)color1 andColor:(UIColor *)color2;

// 制定图片 特定位置获取颜色
- (UIColor *)pixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;

// 获得图片中除白色最可能的特征色
// 当找不到颜色时返回白色
- (UIColor *)colorOfImage:(UIImage *)image;

// 获得图片中除白色最可能的特征色2 验证后留1种或合并
- (UIColor *)colorOfImage2:(UIImage *)image;

// 判断两个颜色是否相近
// 区间0-1  0 完全相同 1 完全不同 自定义阈值
- (float)compareColorA:(UIColor *)colorA andColorB:(UIColor *)colorB;

@end

NS_ASSUME_NONNULL_END
