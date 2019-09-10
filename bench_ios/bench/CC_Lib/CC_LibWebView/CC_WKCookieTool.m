//
//  CCWKCookieManager.m
//  002---HTTPCookie
//
//  Created by yichen on 2019/6/6.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "CC_WKCookieTool.h"

@interface CC_WKCookieTool ()

@property (strong, nonatomic) WKProcessPool *processPool;

@end

@implementation CC_WKCookieTool
@synthesize processPool;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_WKCookieTool shared].processPool = [CC_Base.shared cc_init:WKProcessPool.class];
    }];
}

- (NSURLRequest *)cookieAppendRequestWithURL:(NSString *)urlStr
                                 sessionName:(NSString *)name
                                sessionValue:(NSString *)value
                                 expiresDate:(NSDate *)date{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *domain = [url host];
    
    //创建字典存储cookie的属性值
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    //设置cookie过期时间
    if (date) {
        [cookieProperties setObject:date forKey:NSHTTPCookieExpires];
    }else{
        [cookieProperties setObject:[NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970]+365*24*3600)] forKey:NSHTTPCookieExpires];
    }
    [[NSUserDefaults standardUserDefaults] setObject:cookieProperties forKey:@"app_cookies"];
    
    //删除原cookie, 如果存在的话
    NSArray *arrayCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie * cookice in arrayCookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookice];
    }
    
    //使用字典初始化新的cookie
    NSHTTPCookie *newcookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    //使用cookie管理器 存储cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newcookie];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    //Cookies数组转换为requestHeaderFields
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    //设置请求头
    request.allHTTPHeaderFields = requestHeaderFields;
    return request;
}

- (NSURLRequest *)fixNewRequestCookieWithRequest:(NSURLRequest *)originalRequest{
    NSMutableURLRequest *fixedRequest;
    if ([originalRequest isKindOfClass:[NSMutableURLRequest class]]) {
        fixedRequest = (NSMutableURLRequest *)originalRequest;
    } else {
        fixedRequest = originalRequest.mutableCopy;
    }
    
    //防止Cookie丢失
    NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    if (dict.count) {
        NSMutableDictionary *mDict = originalRequest.allHTTPHeaderFields.mutableCopy;
        [mDict setValuesForKeysWithDictionary:dict];
        fixedRequest.allHTTPHeaderFields = mDict;
    }
    
    return fixedRequest;
}

@end
