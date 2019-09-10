//
//  CC_LibDate.m
//  testbenchios
//
//  Created by gwh on 2019/8/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Date.h"

@implementation CC_Date

+ (NSTimeInterval)cc_compareDate:(id)date1 cut:(id)date2{
    if ([date1 isKindOfClass:[NSString class]]) {
        date1 = [date1 cc_convertToDate];
    }
    if ([date2 isKindOfClass:[NSString class]]) {
        date2 = [date2 cc_convertToDate];
    }
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    return timeInterval;
}

@end
