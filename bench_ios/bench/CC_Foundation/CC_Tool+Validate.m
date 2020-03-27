//
//  CC_Tool+Validate.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool+Validate.h"
#import <sys/stat.h>

@implementation CC_Tool (Validate)

- (BOOL)isSimuLator {
    // TARGET_OS_IPHONE == 1
    if (TARGET_IPHONE_SIMULATOR == 1) {
        //模拟器
        return YES;
    }else{
        //真机
        return NO;
    }
}

- (BOOL)isEmpty:(id)obj {
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        
        NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimStr isEqualToString:@""] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"<nil>"]) {
            return YES;
        }
    } else if ([obj respondsToSelector:@selector(length)] && [(NSData *)obj length] == 0) {
        return YES;
    } else if ([obj respondsToSelector:@selector(count)] && [(NSArray *)obj count] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isJailBreak {
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
            CCLOG(@"The device is jail broken!");
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
        CCLOG(@"The device is jail broken!");
        NSArray *appList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil];
        CCLOG(@"appList = %@", appList);
        if (appList.count > 0) {
            return YES;
        }
        return YES;
    }
    
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        exit(0);
    }
    
    return NO;
#pragma clang diagnostic pop
}

- (BOOL)isInstallFromAppStore {
    //只要判断embedded.mobileprovision文件存在 AppStore下载的是不包含的
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    if (mobileProvisionPath) {
        return NO;
    }
    return YES;
}

@end
