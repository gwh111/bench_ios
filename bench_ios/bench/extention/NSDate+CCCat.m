//
//  NSDate+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/11/9.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NSDate+CCCat.h"

#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)

@implementation NSDate(CCCat)

- (int)dp_second
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.second;
}
- (int)dp_minute
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.minute;
}
- (int)dp_hour
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.hour;
}
- (int)dp_day
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.day;
}

- (int)dp_month
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.month;
}
-(int)dp_year
{
    NSDateComponents * components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return (int)components.year;
}

@end
