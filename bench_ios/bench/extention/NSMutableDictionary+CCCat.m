//
//  NSMutableDictionary+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NSMutableDictionary+CCCat.h"

@implementation NSMutableDictionary(CCCat)

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (!aKey) {
        return;
    }
    if (!anObject) {
        [self removeObjectForKey:aKey];
        return;
    }
    [self setObject:anObject forKey:aKey];
}

#pragma mark correct decimal number
- (NSMutableDictionary *)correctDecimalLoss:(NSMutableDictionary *)dic{
    if (dic) {
        return [self parseDic:dic];
    }
    return nil;
}

- (NSDecimalNumber *)reviseNum:(NSNumber *)num
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [num doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber;
}

- (NSMutableDictionary *)parseDic:(NSMutableDictionary *)dic{
    NSArray *allKeys=[dic allKeys];
    for (int i=0; i<allKeys.count; i++) {
        NSString *key=allKeys[i];
        id v=dic[key];
        if ([v isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:v];
            [dic setObject:[self parseDic:mutDic] forKey:key];
        }else
        if ([v isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mutArr=[NSMutableArray arrayWithArray:v];
            [dic setObject:[self parseArr:mutArr] forKey:key];
        }else
        if ([v isKindOfClass:[NSNumber class]])
        {
            [dic setObject:[self parseNumber:v] forKey:key];
        }
    }
    return dic;
}

- (NSMutableArray *)parseArr:(NSMutableArray *)arr{
    for (int i=0; i<arr.count; i++) {
        id v=arr[i];
        if ([v isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:v];
            [arr replaceObjectAtIndex:i withObject:[self parseDic:mutDic]];
        }else
        if ([v isKindOfClass:[NSArray class]])
        {
            NSMutableArray *mutArr=[NSMutableArray arrayWithArray:v];
            [arr replaceObjectAtIndex:i withObject:[self parseArr:mutArr]];
        }else
        if ([v isKindOfClass:[NSNumber class]])
        {
            [arr replaceObjectAtIndex:i withObject:[self parseNumber:v]];
        }
    }
    return arr;
}

- (NSDecimalNumber *)parseNumber:(NSNumber *)number{
    return [self reviseNum:number];
}


@end
