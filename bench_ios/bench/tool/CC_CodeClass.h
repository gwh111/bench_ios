//
//  CC_CodeClass.h
//  bench_ios
//
//  Created by gwh on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_CodeClass : NSObject

#pragma mark code for view

+ (UIViewController *)topViewController;
/**
 * 设置view圆角
 */
+ (void)setBoundsWithRadius:(float)radius view:(UIView *)view;

/**
 * 设置view边框颜色
 * r g b a 取值范围0-1
 * with 边框宽度
 */
+ (void)setLineColorR:(float)r andG:(float)g andB:(float)b andA:(float)alpha width:(float)width view:(UIView *)view;

@end

@interface CC_Code : NSObject

+ (void)setRadius:(float)radius view:(UIView *)view;

+ (void)setShadow:(UIColor *)color view:(UIView *)view;

+ (void)setLineColor:(UIColor *)color andA:(float)alpha width:(float)width view:(UIView *)view;

+ (void)setFade:(UIView *)view;

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
