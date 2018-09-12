//
//  CC_Valiation.h
//  bench_ios
//
//  Created by gwh on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Valiation : NSObject

+ (BOOL)isOnlyNumerAndLetter:(NSString *)textStr;
+ (BOOL)isOnlyChinese:(NSString *)textStr;

/** 手机号码验证*/
+ (BOOL)validateMobile:(NSString *)mobileStr;
/** 邮箱*/
+ (BOOL)validateEmail:(NSString *)emailStr;

@end
