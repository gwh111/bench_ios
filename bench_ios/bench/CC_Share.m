//
//  CC_Share.m
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Share.h"

@implementation CC_Share

static CC_Share *userManager=nil;
static dispatch_once_t onceToken;

+ (instancetype)shareInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[CC_Share alloc]init];
    });
    return userManager;
}

- (void)setUserSignKey:(NSString *)signKey{
    _user_signKey=signKey;
}

- (void)setHttpRequestWithAppName:(NSString *)appName andHTTPMethod:(NSString *)HTTPMethod andTimeoutInterval:(NSTimeInterval)timeOut{
    if (!_httpRequest) {
        _httpRequest=[[NSMutableURLRequest alloc]init];
    }
    [_httpRequest setHTTPMethod:HTTPMethod];
    [_httpRequest setTimeoutInterval:timeOut];
    //设置请求头
    [_httpRequest setValue:@"live-iphone" forHTTPHeaderField:appName];
    [_httpRequest setValue:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"appVersion"];
}

- (void)setHttpRequest:(NSMutableURLRequest *)request{
    if (!_httpRequest) {
        _httpRequest=[[NSMutableURLRequest alloc]init];
    }
    _httpRequest=request;
}

@end
