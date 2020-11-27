//
//  CC_Tool+Date.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool+Date.h"
#import "NSString+CC_Foundation.h"
#import "NSDate+CC_Foundation.h"
#import "ccs.h"

@implementation CC_Tool (Date)

- (BOOL)checkNeedUpdateWithKey:(NSString *)key second:(NSUInteger)second {
    BOOL needUpdate = NO;
    NSDate *date = [ccs getShared:key];
    if (date) {
        NSDate *now = NSDate.cc_localDate;
        NSTimeInterval inter = [ccs.tool compareDate:now cut:date];
        if (inter > second) {
            [ccs resetShared:key value:now];
            needUpdate = YES;
        }
    } else {
        NSDate *now = NSDate.cc_localDate;
        [ccs resetShared:key value:now];
        needUpdate = YES;
    }
    return needUpdate;
}

- (NSTimeInterval)compareDate:(id)date1 cut:(id)date2 {
    if (!date1 || !date2) {
        return 0;
    }
    if ([date1 isKindOfClass:[NSString class]]) {
        date1 = [date1 cc_convertToDate];
    }
    if ([date2 isKindOfClass:[NSString class]]) {
        date2 = [date2 cc_convertToDate];
    }
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    return timeInterval;
}

- (NSString *)weekFromDate:(id)date {
    if ([date isKindOfClass:[NSString class]]) {
        date = [date cc_convertToDate];
    }
    NSArray *weeks = @[[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:date];
    return [weeks objectAtIndex:components.weekday];
}

- (NSString *)formatDate:(NSString *)date nowDate:(NSString *)nowDate {
    return [self formatDate:date nowDate:nowDate formatArr:@[@"yyyy-MM-dd",@"MM-dd",@"昨天",@"HH:mm"]];
}

- (NSString *)formatDate:(NSString *)cc_date nowDate:(NSString *)cc_nowDate formatArr:(NSArray *)formatArr {
    NSString *originTimeStr = cc_date;
    NSString *originNowDateStr = cc_nowDate;
    NSDateFormatter *originDateFormatter = [[NSDateFormatter alloc] init];
    [originDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *originTimeDate = [originDateFormatter dateFromString:originTimeStr];
    NSDate *originNowDate = [originDateFormatter dateFromString:originNowDateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:originTimeDate];
    NSString *nowDateStr = [dateFormatter stringFromDate:originNowDate];
    
    NSDate *nowDate = [dateFormatter dateFromString:nowDateStr];
    NSDate *timeDate = [dateFormatter dateFromString:dateStr];
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
    
    if ([timeDate cc_year]<[nowDate cc_year]) {
        NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
        yearFormatter.dateFormat = formatArr[0];
        NSString *yearStr = [yearFormatter stringFromDate:originTimeDate];
        return yearStr;
    } else if ([weekDate earlierDate:nowDate] == weekDate) {
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
        monthFormatter.dateFormat = formatArr[1];
        NSString *monthStr = [monthFormatter stringFromDate:originTimeDate];
        return monthStr;
    } else if ([weekDate earlierDate:nowDate] == nowDate) {
        // less than a week
        if (yesterdayDate.cc_day == nowDate.cc_day) {
            // yesterday
            NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
            dayFormatter.dateFormat = formatArr[2];
            NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
            return dayStr;
        } else if (timeDate.cc_day == nowDate.cc_day) {
            // today
            NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
            dayFormatter.dateFormat = formatArr[3];
            NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
            return dayStr;
        }
        return [self weekFromDate:timeDate];
    }
    return originTimeStr;
}

@end
