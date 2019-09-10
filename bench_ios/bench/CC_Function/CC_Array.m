//
//  CC_Array.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Array.h"

@implementation CC_Array

//private
+ (NSString *)getDepthStr:(id)value depthArr:(NSArray *)depthArr index:(int)index{
    if (index >= depthArr.count) {
        return value;
    }
    value = value[depthArr[index]];
    index++;
    return [self getDepthStr:value depthArr:depthArr index:index];
}

+ (NSMutableArray *)cc_sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr{
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *englishMutArr = [[NSMutableArray alloc]init];
    for (int i=0; i<sortMutArr.count; i++) {
        NSMutableString *ms;
        if (depthArr.count == 0) {
            ms = [[NSMutableString alloc]initWithString:sortMutArr[i]];
        }else{
            ms = [[NSMutableString alloc]initWithString:[self getDepthStr:sortMutArr[i] depthArr:depthArr index:0]];
        }
        CFStringTransform((CFMutableStringRef)ms, NULL, kCFStringTransformToLatin, NO);
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0,kCFStringTransformStripDiacritics, NO))
        {
            NSString *bigStr = [ms uppercaseString];
            [englishMutArr addObject:bigStr];
            [mutDic setObject:sortMutArr[i] forKey:bigStr];
        }
    }
    NSArray *resultkArrSort = [englishMutArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *newArr = [[NSMutableArray alloc]init];
    for (int i=0; i<resultkArrSort.count; i++) {
        [newArr addObject:mutDic[resultkArrSort[i]]];
    }
    return newArr;
}


+ (NSMutableArray *)cc_sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc{
    if (desc) {
        //降序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i; j++) {
                if (key) {
                    if ([mutArr[j][key] intValue] < [mutArr[j + 1][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j] intValue] < [mutArr[j + 1] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    }else{
        //升序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i;j++) {
                if (key) {
                    if ([mutArr[j+1][key]intValue] < [mutArr[j][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j+1]intValue] < [mutArr[j] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    }
    
    return mutArr;
}

+ (NSMutableArray *)cc_addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap{
    for (int i=0; i<pathArr.count;i++) {
        NSMutableDictionary *itemDic = [[NSMutableDictionary alloc]initWithDictionary:pathArr[i]];
        if (!itemDic[idKey]) {
            CCLOG(@"%@ not found in arr",idKey);
            continue ;
        }
        NSString *idV = [NSString stringWithFormat:@"%@",itemDic[idKey]];
        if (!getMap[idV]) {
            CCLOG(@"%@ not found in map",idV);
            continue ;
        }
        id mapV = getMap[idV];
        if (keepKey) {
            [itemDic setObject:mapV forKey:[NSString stringWithFormat:@"%@_map",idKey]];
        }else{
            [itemDic setObject:mapV forKey:idKey];
        }
        [pathArr replaceObjectAtIndex:i withObject:itemDic];
    }
    return pathArr;
}

+ (NSMutableArray *)cc_mapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap{
    NSMutableArray *mutArr;
    NSDictionary *getMap;
    
    mutArr = [[NSMutableArray alloc]initWithArray:pathArr];
    getMap = pathMap;
    for (int i=0; i<mutArr.count; i++) {
        NSMutableDictionary *itemDic = [[NSMutableDictionary alloc]initWithDictionary:mutArr[i]];
        if (!itemDic[idKey]) {
            CCLOG(@"%@ not found in arr",idKey);
            continue ;
        }
        NSString *idV = [NSString stringWithFormat:@"%@",itemDic[idKey]];
        if (!getMap[idV]) {
            CCLOG(@"%@ not found in map",idV);
            continue ;
        }
        id mapV = getMap[idV];
        if (keepKey) {
            [itemDic setObject:mapV forKey:[NSString stringWithFormat:@"%@_map",idKey]];
        }else{
            [itemDic setObject:mapV forKey:idKey];
        }
        [mutArr replaceObjectAtIndex:i withObject:itemDic];
    }
    return mutArr;
}

@end
