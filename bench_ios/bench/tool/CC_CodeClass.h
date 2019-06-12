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

/**
 *  获取根控制器
 */
+ (UINavigationController *)getRootNav;

/**
 *  获取当前控制器
 */
+ (UIViewController *)getCurrentVC;

/**
 *  获取最上层window
 */
+ (UIWindow *)getLastWindow;

/**
 *  获取当前可以展示的view
    先取CurrentVC.view 如果没有 取LastWindow
 */
+ (UIView *)getAView;

/**
 *  设置圆角
 */
+ (void)setRadius:(float)radius view:(UIView *)view;

/**
 *  设置阴影
 */
+ (void)setShadow:(UIColor *)color view:(UIView *)view;
+ (void)setShadow:(UIColor *)color view:(UIView *)view offset:(CGSize)size opacity:(float)opacity;

/**
 *  设置描边
 */
+ (void)setLineColor:(UIColor *)color width:(float)width view:(UIView *)view;

/**
 *  设置底部渐变消失
 */
+ (void)setFade:(UIView *)view;

@end

@interface CC_Convert : NSObject

/**
 *  度和弧度的转化
 */
+ (float)huDuTodu:(float)du;
+ (float)duToHuDu:(float)huDu;

/**
 *  URL编码 转换!*'();:@&=+$,/?%#[]
 */
+ (NSString *)encodeUrlParameter:(NSString *)originalPara;

/**
 *  string to data, utf8编码
 */
+ (NSData *)strToData_utf8:(NSString *)str;

/**
 *  string to data, base64
 */
+ (NSData *)strToData_base64:(NSString *)str;

/**
 *  data to string, utf8编码
 */
+ (NSString *)dataToStr_utf8:(NSData *)data;

/**
 *  data to string, base64
 */
+ (NSString *)dataToStr_base64:(NSData *)data;

/**
 *  int转data
 */
+ (NSData *)intToData:(int)i;

/**
 *  JSON转NSString
 */
+ (NSString *)convertToJSONData:(id)object;

/**
 *  NSString转NSDictionary、NSArray(JSON)
 */
+ (id)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  颜色的16进制NSString转成UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;

+ (NSString *)parseLabel:(NSString *)str start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd;

/**
 *  根据两点坐标计算距离
 */
+ (float)getRPoint1:(CGPoint)point1 point2:(CGPoint)point2;

/**
 *  根据两点坐标计算连线和x轴角度
 */
+ (float)getDuPoint1:(CGPoint)point1 point2:(CGPoint)point2;

/**
 *  根据角度和长度获得新坐标位置。相对于(0,0)点
 */
+ (CGPoint)getPointR:(float)r du:(float)du;

@end
