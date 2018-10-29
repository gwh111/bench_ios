//
//  NSPredicate+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/10/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import "NSPredicate+CCExtention.h"

@implementation NSPredicate(CCExtention)

+ (BOOL)isMatchNumberWordChinese:(NSString *)str{
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if(isMatch==0){
        return NO;
    }
    return YES;
}

@end
