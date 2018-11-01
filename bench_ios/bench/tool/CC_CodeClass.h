//
//  CC_CodeClass.h
//  bench_ios
//
//  Created by gwh on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_Code : NSObject

+ (UIWindow *)lastWindow;

+ (void)setRadius:(float)radius view:(UIView *)view;

+ (void)setShadow:(UIColor *)color view:(UIView *)view;

+ (void)setShadow:(UIColor *)color view:(UIView *)view offset:(CGSize)size opacity:(float)opacity;

+ (void)setLineColor:(UIColor *)color width:(float)width view:(UIView *)view;

+ (void)setFade:(UIView *)view;

#pragma mark 不再建议使用 保留是为了兼容之前版本
+ (void)setLineColor:(UIColor *)color andA:(float)alpha width:(float)width view:(UIView *)view;

@end

@interface convert : NSObject

+ (NSString*)convertToJSONData:(id)infoDict;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/**
 *  服务端颜色的16进制NSString转成UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;
+ (NSString*)parseLabel:(NSString*)str start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd;

@end



//弃用 请使用CC_Code
@interface CC_CodeClass : NSObject

#pragma mark code for view

+ (UIViewController *)topViewController;
/**
 * 设置view圆角
 */
//弃用 请使用CC_Code
+ (void)setBoundsWithRadius:(float)radius view:(UIView *)view;

/**
 * 设置view边框颜色
 * r g b a 取值范围0-1
 * with 边框宽度
 */
//弃用 请使用CC_Code
+ (void)setLineColorR:(float)r andG:(float)g andB:(float)b andA:(float)alpha width:(float)width view:(UIView *)view;

@end
