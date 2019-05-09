//
//  CC_Valiation.m
//  bench_ios
//
//  Created by gwh on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Validate.h"
#import <sys/stat.h>

@implementation CC_Validate

+ (BOOL)isPureInt:(NSString *)str{
    
    NSScanner *scan = [NSScanner scannerWithString:str];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureLetter:(NSString *)str{
    if (str.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:str];
}

+ (BOOL)isMatchNumberWordChinese:(NSString *)str{
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if(isMatch==0){
        return NO;
    }
    return YES;
}

+ (BOOL)hasChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isJailBreak{
#if TARGET_IPHONE_SIMULATOR
    return false;
#elif TARGET_OS_IPHONE
#endif
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
    //判断这些文件是否存在，只要有存在的，就可以认为手机已经越狱了。
    NSArray *jailbreak_tool_paths = @[
                                      @"/Applications/Cydia.app",
                                      @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                                      @"/bin/bash",
                                      @"/usr/sbin/sshd",
                                      @"/etc/apt"
                                      ];
    for (int i=0; i<jailbreak_tool_paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:jailbreak_tool_paths[i]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    
    //根据是否能打开cydia判断
    //    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
    //        NSLog(@"The device is jail broken!");
    //        return YES;
    //    }
    
    //根据是否能获取所有应用的名称判断
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
        NSLog(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
        NSLog(@"appList = %@", appList);
        return YES;
    }
    
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        exit(0);
    }
    
    return NO;
#pragma clang diagnostic pop
}

+ (BOOL)isInstallFromAppStore{
    //只要判断embedded.mobileprovision文件存在 AppStore下载的是不包含的
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (mobileProvisionPath) {
        return NO;
    }
    return YES;
}

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
