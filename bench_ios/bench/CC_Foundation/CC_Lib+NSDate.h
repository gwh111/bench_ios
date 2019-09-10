//
//  NSDate+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/11/9.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(CC_Lib)

@property(nonatomic, assign, readonly) NSInteger cc_second;
@property(nonatomic, assign, readonly) NSInteger cc_minute;
@property(nonatomic, assign, readonly) NSInteger cc_hour;
@property(nonatomic, assign, readonly) NSInteger cc_day;
@property(nonatomic, assign, readonly) NSInteger cc_month;
@property(nonatomic, assign, readonly) NSInteger cc_year;

// 根据日期获得星期几
- (NSString *)cc_weekday;

- (NSString *)cc_convertToString;

- (NSString *)cc_convertToStringWithformatter:(NSString *)formatterStr;

@end

