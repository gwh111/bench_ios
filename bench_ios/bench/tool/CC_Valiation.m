//
//  CC_Valiation.m
//  bench_ios
//
//  Created by gwh on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Valiation.h"

@implementation CC_Valiation

// 手机号码验证
+ (BOOL)validateMobile:(NSString *)mobileStr{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((12[0-9])|(13[0,0-9])|(14[0,0-9])|(15[0,0-9])|(16[0,0-9])|(17[0,0-9])|(18[0,0-9])|(19[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileStr];
}

//邮箱
+ (BOOL)validateEmail:(NSString *)emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}


@end
