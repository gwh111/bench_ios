//
//  CC_Libhandler.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Function.h"
#import <sys/stat.h>

@implementation CC_Function

+ (id)cc_jsonWithString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        CCLOG(@"json解析失败：%@",error);
        return nil;
    }
    return object;
}

+ (NSString *)cc_stringWithJson:(id)object{
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    NSError *error;
    // Pass 0 if you don't care about the readability of the generated string
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonStr=@"";
    if (!jsonData){
        CCLOG(@"error: %@",error);
    }else{
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonStr;
}

+ (NSData *)cc_dataWithInt:(int)i{
    int j=ntohl(i);
    NSData *data = [NSData dataWithBytes: &j length: sizeof(i)];
    return data;
}

+ (int)cc_compareVersion:(NSString *)v1 cutVersion:(NSString *)v2{
    if (!v1||!v2) {
        CCLOG("不能为空");
        return -100;
    }
    if (v1.length < v2.length) {
        for (int i=0; i<(v2.length-v1.length)/2; i++) {
            v1=[NSString stringWithFormat:@"%@.0",v1];
        }
    }else if (v2.length < v1.length){
        for (int i=0; i<(v1.length-v2.length)/2; i++) {
            v2=[NSString stringWithFormat:@"%@.0",v2];
        }
    }
    NSArray  *arr1 = [v1 componentsSeparatedByString:@"."];
    NSArray  *arr2 = [v2 componentsSeparatedByString:@"."];
    NSInteger c1 = arr1.count;
    NSInteger c2 = arr2.count;
    if (c1 == 0 || c2 == 0) {
        CCLOG("分割错误");
        return -100;
    }
    for (int i=0; i<arr1.count; i++) {
        int item1 = [arr1[i] intValue];
        int item2 = [arr2[i] intValue];
        if (item1 > item2) {
            return 1;
        }else if (item1 < item2){
            return -1;
        }
    }
    
    if (c1 > c2) {
        return 1;
    }else if (c1 < c2){
        return -1;
    }else{
        return 0;
    }
    
    return 999;
}

#pragma mark validate
+ (BOOL)cc_isEmpty:(id)obj{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        
        NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimStr isEqualToString:@""] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"<nil>"]) {
            return YES;
        }
    } else if ([obj respondsToSelector:@selector(length)] && [(NSData *)obj length] == 0) {
        return YES;
    } else if ([obj respondsToSelector:@selector(count)] && [(NSArray *)obj count] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)cc_isJailBreak{
#if TARGET_IPHONE_SIMULATOR
    return false;
#elif TARGET_OS_IPHONE
#endif
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    //判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
    NSArray *jailbreak_tool_paths = @[
                                      @"/Applications/Cydia.app",
                                      @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                      @"/bin/bash",
                                      @"/usr/sbin/sshd",
                                      @"/etc/apt"
                                      ];
    for (int i=0; i<jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            CCLOG(@"The device is jail broken!");
            return YES;
        }
    }
    
    //根据是否能打开cydia判断
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
    //        NSLog(@"The device is jail broken!");
    //        return YES;
    //    }
    
    //根据是否能获取所有应用的名称判断
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        CCLOG(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
        CCLOG(@"appList = %@", appList);
        if (appList.count > 0) {
            return YES;
        }
        return YES;
    }
    
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        exit(0);
    }
    
    return NO;
#pragma clang diagnostic pop
}

+ (BOOL)cc_isInstallFromAppStore{
    //只要判断embedded.mobileprovision文件存在 AppStore下载的是不包含的
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (mobileProvisionPath) {
        return NO;
    }
    return YES;
}

#pragma mark date

+ (NSString *)cc_weekFromDate:(id)date{
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

+ (NSString *)cc_formatDate:(NSString *)date nowDate:(NSString *)nowDate{
    return [self cc_formatDate:date nowDate:nowDate formatArr:@[@"yyyy-MM-dd",@"MM-dd",@"昨天",@"HH:mm"]];
}

+ (NSString *)cc_formatDate:(NSString *)cc_date nowDate:(NSString *)cc_nowDate formatArr:(NSArray *)formatArr{
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
    }else if ([weekDate earlierDate:nowDate] == weekDate){
        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
        monthFormatter.dateFormat = formatArr[1];
        NSString *monthStr = [monthFormatter stringFromDate:originTimeDate];
        return monthStr;
    }else if ([weekDate earlierDate:nowDate] == nowDate){
        // less than a week
        if(yesterdayDate.cc_day == nowDate.cc_day){
            // yesterday
            NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
            dayFormatter.dateFormat = formatArr[2];
            NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
            return dayStr;
        }else if(timeDate.cc_day == nowDate.cc_day){
            // today
            NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
            dayFormatter.dateFormat = formatArr[3];
            NSString *dayStr = [dayFormatter stringFromDate:originTimeDate];
            return dayStr;
        }
        return [self cc_weekFromDate:timeDate];
    }
    return originTimeStr;
}

#pragma mark math
+ (float)cc_huduWithDu:(float)du{
    if (du == 0) {
        return 0;
    }
    return M_PI/(180/du);
}

+ (float)cc_duWithHudu:(float)huDu{
    return huDu*180/M_PI;
}

+ (float)cc_rPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    float p = sqrt(pow((point1.x-point2.x), 2) + pow((point1.y-point2.y), 2));
    return p;
}

+ (float)cc_duPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    point1 = CGPointMake(point1.x, -point1.y);
    point2 = CGPointMake(point2.x, -point2.y);
    if (point1.x - point2.x == 0) {
        if (point1.y - point2.y > 0) {
            return 90;
        }
        return 270;
    }
    if (point1.y - point2.y == 0) {
        if (point1.x - point2.x > 0) {
            return 0;
        }
        return 180;
    }
    float dy = (point1.y - point2.y);
    float dx = (point1.x - point2.x);
    if (dy > 0 && dx > 0) {
        float p_ang = atan(dy/dx);
        return [self cc_duWithHudu:p_ang];
    }else if (dy > 0 && dx < 0){
        float p_ang = atan(dy/-dx);
        return 180 - [self cc_duWithHudu:p_ang];
    }else if (dy < 0 && dx < 0){
        float p_ang = atan(dy/dx);
        return [self cc_duWithHudu:p_ang] + 180;
    }else{
        float p_ang = atan(-dy/dx);
        return 360 - [self cc_duWithHudu:p_ang];
    }
    
}

+ (CGPoint)cc_pointR:(float)r du:(float)du{
    float cos = cosf([self cc_huduWithDu:du+1]);
    float sin = sinf([self cc_huduWithDu:du+1]);
    float x = r*cos;
    float y = r*sin;
    CGPoint p = CGPointMake(x, -y);
    return p;
}

@end
