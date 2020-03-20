//
//  UIView+Extension.m
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import "UIView+CC.h"

@implementation UIView (CC)

- (void)cc_addCornerRadius:(CGFloat)radius {
    [self cc_addCornerRadius:radius borderWidth:1 borderColor:[UIColor clearColor] backgroundColor:[UIColor clearColor]];
}

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)bgColor {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self cc_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:bgColor drawTopLeft:YES drawTopRight:YES drawBottomLeft:YES drawBottomRight:YES]];
    [self insertSubview:imageView atIndex:0];
}

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)bgColor
               drawTopLeft:(BOOL)topLeft
              drawTopRight:(BOOL)topRight
            drawBottomLeft:(BOOL)bottomLeft
           drawBottomRight:(BOOL)bottomRight {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self cc_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:bgColor drawTopLeft:topLeft drawTopRight:topRight drawBottomLeft:bottomLeft drawBottomRight:bottomRight]];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)cc_drawRectWithRoundedCorner:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
                          backgroundColor:(UIColor *)bgColor
                              drawTopLeft:(BOOL)topLeft
                             drawTopRight:(BOOL)topRight
                           drawBottomLeft:(BOOL)bottomLeft
                          drawBottomRight:(BOOL)bottomRight {
    
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if (topRight) {
        CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
    } else {
        CGContextMoveToPoint(contextRef, width - halfBorderWidth, 0);
    }
    if (bottomRight) {
        CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    } else {
        CGContextAddLineToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth);
    }
    if (bottomLeft) {
        CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    } else {
        CGContextAddLineToPoint(contextRef, halfBorderWidth, height - halfBorderWidth);
    }
    if (topLeft) {
        CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    } else {
        CGContextAddLineToPoint(contextRef, halfBorderWidth, halfBorderWidth);
    }
    if (topRight) {
        CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    } else {
        CGContextAddLineToPoint(contextRef, width - halfBorderWidth, halfBorderWidth);
    }
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 添加shadowpath避免离屏渲染
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
//    byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    return image;
}


@end
