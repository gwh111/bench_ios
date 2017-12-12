//
//  CC_CodeClass.m
//  bench_ios
//
//  Created by gwh on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_CodeClass.h"

@implementation CC_CodeClass

+ (void)setBoundsWithRadius:(float)radius view:(UIView *)view{
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:radius];
}

+ (void)setLineColorR:(float)r andG:(float)g andB:(float)b andA:(float)alpha width:(float)width view:(UIView *)view{
    [view.layer setBorderWidth:width]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ r, g, b, alpha});
    [view.layer setBorderColor:colorref];//边框颜色
    CGColorRelease(colorref);
}

@end
