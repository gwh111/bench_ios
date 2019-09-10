//
//  CCWKCookieManager.h
//  002---HTTPCookie
//
//  Created by yichen on 2019/6/6.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import "CC_Foundation.h"
#import <WebKit/WebKit.h>

@class WKProcessPool;

@interface CC_WKCookieTool : NSObject

+ (instancetype)shared;

/**
 拼接同步到 NSHTTPCookieStorage 中的 Cookie
 @return 拼接了 Cookie 字段后的请求
 */
- (NSURLRequest *)cookieAppendRequestWithURL:(NSString *)urlStr
                                 sessionName:(NSString *)name
                                sessionValue:(NSString *)value
                                 expiresDate:(NSDate *)date;

/**
 解决新的跳转 Cookie 丢失问题
 @param originalRequest 拦截的请求
 @return 带上 Cookie 的请求
 */
- (NSURLRequest *)fixNewRequestCookieWithRequest:(NSURLRequest *)originalRequest;

@end

