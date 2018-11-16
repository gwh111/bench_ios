//
//  CC_Date.h
//  bench_ios
//
//  Created by gwh on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Date : NSObject

/**
 *  NSString转NSDate
 */
+ (NSDate *)ccgetDate:(NSString *)dateStr formatter:(NSString *)formatterStr;

/**
 *  NSDate转NSString
 */
+ (NSString *)ccgetDateStr:(NSDate *)date formatter:(NSString *)formatterStr;

/**
 *  比较时间间隔
    <0 date1 在date2 之前
    >0 date1 在date2 之后
 */
+ (NSTimeInterval)compareDate:(NSDate *)date1 cut:(NSDate *)date2;

/**
 *  获取当前时间戳
 */
+ (NSString *)getNowTimeTimestamp;

/**
 *  获取唯一当前时间戳
    如同一时间并发，会在时间节点上带上_n，n表示次数
 */
+ (NSString *)getUniqueNowTimeTimestamp;

/**
 *  根据date获取星期
    北京时间
 */
+ (NSString *)getWeekFromDate:(NSDate *)date;

/**
 *  格式化时间距离现在
    yyyy-MM-dd
    MM-dd
    一周以内显示星期
    昨天
    HH:mm
 */
+ (NSString *)getFormatDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr;

/**
 *  格式化时间距离现在
    yyyy-MM-dd HH:mm
    MM-dd HH:mm
    一周以内显示星期
    昨天 HH:mm
    HH:mm
 */
+ (NSString *)getFormatMinuteDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr;

/**
 *  格式化时间距离现在
    yyyy-MM-dd
    MM-dd
    昨天
    HH:mm
    x分钟前
    x秒前
 */
+ (NSString *)getFormatBeforeDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr;

@end
