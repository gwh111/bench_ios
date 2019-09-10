//
//  UIColor+CC.h
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

#define HEXA(hex,a) [UIColor cc_hexA:hex alpha:a]
#define RGBA(r,g,b,a) [UIColor cc_rgbA:r green:g blue:b alpha:a]

@interface UIColor (CC_Lib)

+ (UIColor *)cc_hexA:(NSString *)hex alpha:(float)alpha;
+ (UIColor *)cc_rgbA:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

+ (UIImage *)cc_imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
