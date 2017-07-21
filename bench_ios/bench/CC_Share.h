//
//  CC_Share.h
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_GHttpSessionTask.h"

#define NOTIFICATION_LOGIN_EXPIRED @"NOTIFICATION_LOGIN_EXPIRED"
#define NOTIFICATION_USER_LOGIN_FORBID @"NOTIFICATION_USER_LOGIN_FORBID"
#define NOTIFICATION_jumpLogin @"NOTIFICATION_jumpLogin"

@interface CC_Share : NSObject

@property (nonatomic,retain) NSMutableURLRequest *httpRequest;///>http

@property (nonatomic,retain) NSString *user_signKey;///>md5 key

+ (instancetype)shareInstance;

/** 
 * set HTTPHeaderField
 * 常规配置
 * appName app名称
 * HTTPMethod GET or POST
 * timeOut 超时时间
 */
- (void)setHttpRequestWithAppName:(NSString *)appName andHTTPMethod:(NSString *)HTTPMethod andTimeoutInterval:(NSTimeInterval)timeOut;
/** 
 * set HTTPHeaderField
 * 自定义配置
 */
- (void)setHttpRequest:(NSMutableURLRequest *)request;

@end
