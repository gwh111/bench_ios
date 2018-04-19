//
//  CC_Date.h
//  bench_ios
//
//  Created by gwh on 2018/4/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Date : NSObject

+ (NSDate *)ccgetDate:(NSString *)dateStr formatter:(NSString *)formatterStr;

+ (NSString *)ccgetDateStr:(NSDate *)date formatter:(NSString *)formatterStr;

+ (NSTimeInterval)compareDate:(NSDate *)date1 cut:(NSDate *)date2;

@end
