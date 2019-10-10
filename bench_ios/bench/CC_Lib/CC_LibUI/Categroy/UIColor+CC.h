//
//  UIColor+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define HEXA(COLOR,A) ({ \
char *color = #COLOR;\
NSString *colorString = [NSString stringWithUTF8String:color]; \
[UIColor cc_hexA:colorString alpha:A]; \
})
#define HEX(COLOR) HEXA(COLOR,1.0)
#define RGBA(r,g,b,a) [UIColor cc_rgbA:r green:g blue:b alpha:a]
#define RGB(r,g,b) [UIColor cc_rgbA:r green:g blue:b alpha:1]

@interface UIColor (CC)

+ (UIColor *)cc_hexA:(NSString *)hex alpha:(float)alpha;
+ (UIColor *)cc_rgbA:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

+ (UIImage *)cc_imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
