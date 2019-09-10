//
//  CC_Envirnment.m
//  bench_ios
//
//  Created by gwh on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Envirnment.h"

@implementation CC_Envirnment

+ (BOOL)cc_isProxyStatus{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //检测到抓包
        if ([self fetchHttpProxy]) {
            //二次确认
            return YES;
        }
        return NO;
    }
    return NO;
}

+ (id)fetchHttpProxy{
    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
    const CFStringRef proxyCFstr = (const CFStringRef)CFDictionaryGetValue(dicRef,
                                                                           (const void*)kCFNetworkProxiesHTTPProxy);
    NSString *proxy = (__bridge NSString *)proxyCFstr;
    return proxy;
}

@end
