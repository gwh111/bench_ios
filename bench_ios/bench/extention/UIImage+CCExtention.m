//
//  UIImage+QRScale.m
//  Pods
//
//  Created by xulihua on 15/12/9.
//
//

#import "UIImage+CCExtention.h"

@implementation UIImage (CCExtention)

-(UIImage *)transformToSize:(CGSize)newSize
{
    // 创建一个bitmap的context
    UIGraphicsBeginImageContext(newSize);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *transformedImg=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return transformedImg;
}


@end
