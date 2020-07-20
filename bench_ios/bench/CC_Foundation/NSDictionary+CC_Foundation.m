//
//  NSMutableDictionary+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NSDictionary+CC_Foundation.h"

@implementation NSDictionary (CC_Foundation)

- (void)cc_propertyCode {
    NSMutableString *codes = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop){
        NSString *code;
        if ([value isKindOfClass:[NSString class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@",key];
        }else if ([value isKindOfClass:[NSNumber class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@",key];
        }else if ([value isKindOfClass:[NSArray class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@",key];
        }else if ([value isKindOfClass:[NSDictionary class]]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@",key];
        }
        [codes appendFormat:@"\n%@;\n",code];
    }];
    CCLOG(@"%@",codes);
}

@end

@implementation NSMutableDictionary(CC_Foundation)

- (void)safeSetObject:(id)obj forKey:(NSString *)aKey {
    if (!aKey) {
        return;
    }
    if (!obj) {
        [self removeObjectForKey:aKey];
        return;
    }
    [self setObject:obj forKey:aKey];
}

- (void)cc_setKey:(NSString *)aKey {
    if (!aKey) {
        return;
    }
    [self setObject:@"" forKey:aKey];
}

- (void)cc_setKey:(NSString *)aKey value:(id)value {
    if (!aKey) {
        return;
    }
    if (!value) {
        [self removeObjectForKey:aKey];
        return;
    }
    if ([value isKindOfClass:NSString.class]) {
        NSString *s = value;
        if (s.length <= 0) {
            [self removeObjectForKey:aKey];
            return;
        }
    }
    [self setObject:value forKey:aKey];
}

- (void)cc_removeKey:(NSString *)aKey {
    if (!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
}

- (NSData *)cc_convertToData {

    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

- (NSMutableString *)cc_formatToString {
    NSMutableString *formatString = [[NSMutableString alloc]init];
    
    NSArray *keysArray = [self allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSString *categoryId in resultArray) {
        [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,[self objectForKey:categoryId]]];
    }
    NSRange range = NSMakeRange (formatString.length-1, 1);
    [formatString deleteCharactersInRange:range];
    return formatString;
}

#pragma mark correct decimal number
- (NSMutableDictionary *)cc_correctDecimalLoss:(NSMutableDictionary *)dic {
    if (dic) {
        return [self parseDic:dic];
    }
    return nil;
}

- (NSDecimalNumber *)reviseNum:(NSNumber *)num{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [num doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return decNumber;
}

- (NSMutableDictionary *)parseDic:(NSMutableDictionary *)dic {
    NSArray *allKeys = [dic allKeys];
    for (int i=0; i<allKeys.count; i++) {
        NSString *key = allKeys[i];
        id v = dic[key];
        if ([v isKindOfClass:[NSDictionary class]]){
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:v];
            [dic setObject:[self parseDic:mutDic] forKey:key];
        }else if ([v isKindOfClass:[NSArray class]]){
            NSMutableArray *mutArr = [NSMutableArray arrayWithArray:v];
            [dic setObject:[self parseArr:mutArr] forKey:key];
        }else if ([v isKindOfClass:[NSNumber class]]){
            [dic setObject:[self parseNumber:v] forKey:key];
        }
    }
    return dic;
}

- (NSMutableArray *)parseArr:(NSMutableArray *)arr {
    for (int i=0; i<arr.count; i++) {
        id v = arr[i];
        if ([v isKindOfClass:[NSDictionary class]]){
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:v];
            [arr replaceObjectAtIndex:i withObject:[self parseDic:mutDic]];
        }else if ([v isKindOfClass:[NSArray class]]){
            NSMutableArray *mutArr = [NSMutableArray arrayWithArray:v];
            [arr replaceObjectAtIndex:i withObject:[self parseArr:mutArr]];
        }else if ([v isKindOfClass:[NSNumber class]]){
            [arr replaceObjectAtIndex:i withObject:[self parseNumber:v]];
        }
    }
    return arr;
}

- (NSDecimalNumber *)parseNumber:(NSNumber *)number {
    return [self reviseNum:number];
}

@end
