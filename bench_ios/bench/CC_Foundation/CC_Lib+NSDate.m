//
//  NSDate+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/11/9.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CC_Lib+NSDate.h"

@implementation NSDate(CC_Lib)

- (NSCalendarUnit)get_dateComponents{
    return NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekOfYear|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekdayOrdinal;
}

- (NSInteger)cc_second{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.second;
}

- (NSInteger)cc_minute{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.minute;
}

- (NSInteger)cc_hour{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.hour;
}

- (NSInteger)cc_day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.day;
}

- (NSInteger)cc_month{
    NSDateComponents * components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.month;
}

- (NSInteger)cc_year{
    NSDateComponents * components = [[NSCalendar currentCalendar] components:[self get_dateComponents] fromDate:self];
    return components.year;
}

- (NSString *)cc_weekday{
    NSArray *weeks = @[[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:self];
    return [weeks objectAtIndex:components.weekday];
}

- (NSString *)cc_convertToStringWithformatter:(NSString *)formatterStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (formatterStr) {
        [dateFormatter setDateFormat:formatterStr];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    NSString *currentDateString = [dateFormatter stringFromDate:self];
    return currentDateString;
}

- (NSString *)cc_convertToString{
    return [self cc_convertToStringWithformatter:nil];
}

@end
