//
//  CC_Date.m
//  bench_ios
//
//  Created by gwh on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Date.h"
#import "CC_Share.h"

@implementation CC_Date

+ (NSDate *)ccgetDate:(NSString *)dateStr formatter:(NSString *)formatterStr{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if (formatterStr) {
        [dateFormatter setDateFormat:formatterStr];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    //NSString转NSDate
    NSDate *resDate = [dateFormatter dateFromString:dateStr];
    return resDate;
}

+ (NSString *)ccgetDateStr:(NSDate *)date formatter:(NSString *)formatterStr{
    NSDate *currentDate = date;
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (formatterStr) {
        [dateFormatter setDateFormat:formatterStr];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    return currentDateString;
}

+ (NSTimeInterval)compareDate:(NSDate *)date1 cut:(NSDate *)date2{
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    return timeInterval;
}

+ (NSString *)getUniqueNowTimeTimestamp{
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

+ (NSString *)getNowTimeTimestamp{
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

#pragma mark dateFormat
+ (NSString *)getWeekFromDate:(NSDate *)date
{
    NSArray *weeks = @[[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"] ;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:date] ;
    
    return [weeks objectAtIndex:components.weekday] ;
}

+ (NSString *)getFormatDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr{
    return [self getFormatDateFromNow:nowDateStr andTime:timeStr list:@[@"yyyy-MM-dd",@"MM-dd",@"昨天",@"HH:mm"]];
}

+ (NSString *)getFormatMinuteDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr{
    return [self getFormatDateFromNow:nowDateStr andTime:timeStr list:@[@"yyyy-MM-dd HH:mm",@"MM-dd HH:mm",@"昨天 HH:mm",@"HH:mm"]];
}

+ (NSString *)getFormatDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr list:(NSArray *)list{
    NSString *originTimeStr = timeStr;
    NSString *originNowDateStr = nowDateStr;
    NSDateFormatter *originDateFormatter = [[NSDateFormatter alloc] init];
    [originDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *originTimeDate = [originDateFormatter dateFromString:originTimeStr];
    NSDate *originNowDate = [originDateFormatter dateFromString:originNowDateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    timeStr = [dateFormatter stringFromDate:originTimeDate];
    nowDateStr = [dateFormatter stringFromDate:originNowDate];
    
    NSDate *nowDate = [dateFormatter dateFromString:nowDateStr];
    NSDate *timeDate = [dateFormatter dateFromString:timeStr];
    if (!nowDate) {
        nowDate = [NSDate date];
    }
    if (!timeDate) {
        timeDate = [NSDate date];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *yesterdayComps = [[NSDateComponents alloc] init];
    [yesterdayComps setDay:1];
    NSDate *yesterdayDate = [calendar dateByAddingComponents:yesterdayComps toDate:timeDate options:0];
    
    NSDateComponents *weekComps = [[NSDateComponents alloc] init];
    [weekComps setDay:7];
    NSDate *weekDate = [calendar dateByAddingComponents:weekComps toDate:timeDate options:0];
    
    
    if ([timeDate dp_year] < [nowDate dp_year]) {
        NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
//        yearFormatter.dateFormat = @"yyyy年MM月dd日";
//        yearFormatter.dateFormat = @"yyyy-MM-dd";
        yearFormatter.dateFormat = list[0];
        NSString *yearStr = [yearFormatter stringFromDate:originTimeDate];
        return yearStr;//(-无穷，今年) 年月日时分
    }else if ([weekDate earlierDate:nowDate]==weekDate)
    {
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
//        monthFormatter.dateFormat = @"MM月dd日";
//        monthFormatter.dateFormat = @"MM-dd";
        monthFormatter.dateFormat = list[1];
        NSString *monthStr = [monthFormatter stringFromDate:originTimeDate];
        return monthStr;//[今年,7天]，月日时分秒
    }else if(yesterdayDate.dp_day == nowDate.dp_day)
    {
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
//        dayFormatter.dateFormat = @"昨天";
        dayFormatter.dateFormat = list[2];
        NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
        return dayStr;
    }else if(timeDate.dp_day == nowDate.dp_day )
    {
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
//        dayFormatter.dateFormat = @"HH:mm";
        dayFormatter.dateFormat = list[3];
        NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
        return dayStr;
    }else if ([weekDate earlierDate:nowDate]==nowDate)
    {    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:timeDate];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        weekFormatter.dateFormat = [NSString stringWithFormat:@"%@",[weekdays objectAtIndex:theComponents.weekday]];
        NSString *weekStr = [weekFormatter stringFromDate:originTimeDate];
        return weekStr;//[今年,7天]，月日时分秒
    }
    return originTimeStr;
    
}

+ (NSString *)getFormatBeforeDateFromNow:(NSString *)nowDateStr andTime:(NSString *)timeStr
{
    if (timeStr.length < 10) {
        return @" ";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    NSDate *nowDate = [dateFormatter dateFromString:nowDateStr];
    NSDate *oldDate = [dateFormatter dateFromString:timeStr];
    
    NSString *cutOldDateStr = [timeStr substringWithRange:NSMakeRange(11, 5)];
    
    if (!nowDate) {
        nowDate = [NSDate date];
    }
    
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSTimeInterval old = [oldDate timeIntervalSince1970];
    
    //    NSString *yearStr = [oldDateStr substringWithRange:NSMakeRange(0, 4)];
    //    int year = [yearStr intValue];
    //    int yearDay = ((year % 4 == 0 && year % 400 != 0) || year % 400 == 0)?366:365;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *nowComps ;
    nowComps = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *oldComps ;
    oldComps = [calendar components:unitFlags fromDate:oldDate];
    
    NSString *returnStr ;
    
    if ( !(nowComps.year==oldComps.year) )
    {
        if (nowComps.year == oldComps.year + 1)
        {
            if (nowComps.month == 1 && oldComps.month == 12)
            {
                if (nowComps.day == 1 && oldComps.day == 31)
                {
                    if (now - old > 60 *60) {
                        //                        returnStr = @"昨天 ";
                        returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
                    }
                    else if (now - old > 60)
                    {
                        returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
                    }
                    else if (now - old >= 0)
                    {
                        returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
                    }
                    else returnStr = [NSString stringWithFormat:@"%d秒前",0];
                }
                else
                {
                    returnStr = [timeStr substringWithRange:NSMakeRange(0, 10)];//xxxx-xx-xx
                }
            }
            else
            {
                returnStr = [timeStr substringWithRange:NSMakeRange(0, 10)];//xxxx-xx-xx
            }
        }
        else
        {
            returnStr = [timeStr substringWithRange:NSMakeRange(0, 10)];//xxxx-xx-xx
        }
    }
    else if (nowComps.month != oldComps.month)
    {
        if (nowComps.month == oldComps.month + 1)
        {
            if (oldComps.month == 1 || oldComps.month == 3 || oldComps.month == 5 || oldComps.month == 7 || oldComps.month == 8 || oldComps.month == 10 || oldComps.month == 12 )
            {
                if (nowComps.day == 1 && oldComps.day == 31)
                {
                    if (now - old > 60 *60) {
                        //                        returnStr = @"昨天";
                        returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
                    }
                    else if (now - old > 60)
                    {
                        returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
                    }
                    else if (now - old >= 0)
                    {
                        returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
                    }
                    else returnStr = [NSString stringWithFormat:@"%d秒前",0];
                }
                //                else returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
                else returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
            }
            else if (oldComps.month == 2)
            {
                if ((oldComps.year % 4 == 0 && oldComps.year % 100 != 0) ||oldComps.year % 400 == 0)
                {
                    if (nowComps.day == 1 && oldComps.day == 29)
                    {
                        if (now - old > 60 *60) {
                            //                            returnStr = @"昨天";
                            returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
                        }
                        else if (now - old > 60)
                        {
                            returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
                        }
                        else if (now - old >= 0)
                        {
                            returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
                        }
                        else returnStr = [NSString stringWithFormat:@"%d秒前",0];
                    }
                    //                    else returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
                    else returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
                }
                else
                {
                    if (nowComps.day == 1 && oldComps.day == 28)
                    {
                        if (now - old > 60 *60) {
                            //                            returnStr = @"昨天";
                            returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
                        }
                        else if (now - old > 60)
                        {
                            returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
                        }
                        else if (now - old >= 0)
                        {
                            returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
                        }
                        else returnStr = [NSString stringWithFormat:@"%d秒前",0];
                    }
                    
                    //                   else returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
                    else returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
                }
            }
            else
            {
                if (nowComps.day == 1 && oldComps.day == 30)
                {
                    if (now - old > 60 *60) {
                        //                        returnStr = @"昨天";
                        returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
                    }
                    else if (now - old > 60)
                    {
                        returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
                    }
                    else if (now - old >= 0)
                    {
                        returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
                    }
                    else returnStr = [NSString stringWithFormat:@"%d秒前",0];
                }
                
                //                else returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
                else returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
                
            }
        }
        else
        {
            //            returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
            returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
        }
    }
    else if (nowComps.day != oldComps.day)
    {
        if (nowComps.day == oldComps.day + 1)
        {
            if (now - old > 60 *60) {
                //                returnStr = @"昨天";
                returnStr = [NSString stringWithFormat:@"昨天 %@",cutOldDateStr];
            }
            else if (now - old > 60)
            {
                returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];
            }
            else if (now - old >= 0)
            {
                returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];
            }
            else returnStr = [NSString stringWithFormat:@"%d秒前",0];
        }
        else
        {
            //            returnStr = [oldDateStr substringWithRange:NSMakeRange(5, 5)];//xx-xx
            returnStr = [timeStr substringWithRange:NSMakeRange(5, 11)];
        }
    }
    else if ( now - old>= 60*60) {
        //        returnStr = [oldDateStr substringWithRange:NSMakeRange(11, 5)];//xx:xx
        returnStr = [NSString stringWithFormat:@"今天 %@",[timeStr substringWithRange:NSMakeRange(11, 5)]];
    }
    else if ( now - old >= 60)
        returnStr = [NSString stringWithFormat:@"%d分钟前",(int)(now - old)/60];//xx分钟前
    else if (now -old >= 0){
        returnStr = [NSString stringWithFormat:@"%d秒前",(int)(now - old)];//xx秒前
    }
    else{
        returnStr = [NSString stringWithFormat:@"%d秒前",0];
    }
    //    else return 0;
    
    return returnStr;
}

@end
