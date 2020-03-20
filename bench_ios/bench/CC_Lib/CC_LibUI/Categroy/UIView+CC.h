//
//  UIView+Extension.h
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CC)

// 添加圆角 避免离屏渲染
- (void)cc_addCornerRadius:(CGFloat)radius;

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor*)bgColor;

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)bgColor
               drawTopLeft:(BOOL)topLeft
              drawTopRight:(BOOL)topRight
            drawBottomLeft:(BOOL)bottomLeft
           drawBottomRight:(BOOL)bottomRight;
    
@end
