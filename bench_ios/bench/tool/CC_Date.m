//
//  CC_Date.m
//  bench_ios
//
//  Created by gwh on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Date.h"

@implementation CC_Date

+ (NSDate *)ccgetDate:(NSString *)dateStr formatter:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    NSDate *resDate = [formatter dateFromString:dateStr];
    return resDate;
}

+ (NSString *)ccgetDateStr:(NSDate *)date formatter:(NSString *)formatterStr{
    NSDate *currentDate = date;
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:formatterStr];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}

+ (NSTimeInterval)compareDate:(NSDate *)date1 cut:(NSDate *)date2{
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    return timeInterval;
}

@end
