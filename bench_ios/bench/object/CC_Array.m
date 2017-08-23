//
//  CC_Array.m
//  bench_ios
//
//  Created by gwh on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Array.h"

@implementation CC_Array

+ (NSArray *)arrayAscending:(NSArray *)arr{
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    arr=[arr sortedArrayUsingComparator:cmptr];
    return arr;
}

+ (NSArray *)arrayDescending:(NSArray *)arr{
    NSComparator cmptr = ^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    arr=[arr sortedArrayUsingComparator:cmptr];
    return arr;
}

@end
