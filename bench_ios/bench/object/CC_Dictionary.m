//
//  CC_Dictionary.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Dictionary.h"

@implementation CC_Dictionary

+ (void)ccsetObject:(id)object forKey:(id)key dic:(NSMutableDictionary *)dic{
    if (!object) {
        return;
    }
    if (!key) {
        return;
    }
    [dic setObject:object forKey:key];
}

@end
