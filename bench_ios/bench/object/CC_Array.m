//
//  CC_Array.m
//  bench_ios
//
//  Created by gwh on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Array.h"

@implementation CC_Array

+ (NSString *)getDepthStr:(id)value depthArr:(NSArray *)depthArr index:(int)index{
    if (index>=depthArr.count) {
        return value;
    }
    value=value[depthArr[index]];
    index++;
    return [self getDepthStr:value depthArr:depthArr index:index];
}

+ (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr{
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]init];
    NSMutableArray *englishMutArr=[[NSMutableArray alloc]init];
    for (int i=0; i<sortMutArr.count; i++) {
        NSMutableString *ms;
        if (depthArr.count==0) {
            ms = [[NSMutableString alloc]initWithString:sortMutArr[i]];
        }else{
            ms = [[NSMutableString alloc]initWithString:[self getDepthStr:sortMutArr[i] depthArr:depthArr index:0]];
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformMandarinLatin, NO)) {
            //            NSLog(@"pinyin: ---- %@", ms);
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO)) {
            NSString *bigStr = [ms uppercaseString];
            [englishMutArr addObject:bigStr];
            [mutDic setObject:sortMutArr[i] forKey:bigStr];
        }
    }
    
    NSArray *resultkArrSort = [englishMutArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *newArr=[[NSMutableArray alloc]init];
    for (int i=0; i<resultkArrSort.count; i++) {
        [newArr addObject:mutDic[resultkArrSort[i]]];
    }
    return newArr;
}

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
