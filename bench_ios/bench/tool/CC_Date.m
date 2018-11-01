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

+(NSString *)getUniqueNowTimeTimestamp{
    NSString *timestamp=[self getNowTimeTimestamp];
    NSString *current=[CC_Share getInstance].currentUniqueTimeStamp;
    if (current) {
        if ([current isEqualToString:timestamp]) {
            //如果相等 即是出现并发
            [CC_Share getInstance].currentUniqueTimeStampCount++;
            return [NSString stringWithFormat:@"%@_%d",current,[CC_Share getInstance].currentUniqueTimeStampCount];
        }else{
            //不等，表示过了并发
            [CC_Share getInstance].currentUniqueTimeStampCount=0;
            [CC_Share getInstance].currentUniqueTimeStamp=timestamp;
            return timestamp;
        }
    }
    
    //首次
    [CC_Share getInstance].currentUniqueTimeStampCount=0;
    [CC_Share getInstance].currentUniqueTimeStamp=timestamp;
    
    return timestamp;
}

+(NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

@end
