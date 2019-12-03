//
//  UIView+Extension.m
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import "UIView+CC.h"

@implementation UIView (CC)

- (void)cc_addCorner:(CGFloat)radius {
    [self cc_addCorner:radius borderWidth:1 borderColor:[UIColor blackColor] backGroundColor:[UIColor clearColor]];
}

- (void)cc_addCorner:(CGFloat)radius
         borderWidth:(CGFloat)borderWidth
         borderColor:(UIColor *)borderColor
     backGroundColor:(UIColor*)bgColor {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self cc_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backGroundColor:bgColor]];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)cc_drawRectWithRoundedCorner:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
                          backGroundColor:(UIColor*)bgColor {
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
