//
//  CC_Share.h
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//



#define COLOR_BLACK [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]
#define COLOR_WHITE [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define COLOR_CLEAR [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0]

#import <Foundation/Foundation.h>

#import "CC_GHttpSessionTask.h"
#import "CC_Valiation.h"
#import "CC_Image.h"
#import "CC_Button.h"
#import "CC_Label.h"
#import "CC_AttributedStr.h"
#import "CC_DESTool.h"
#import "CC_UIViewExt.h"
#import "CC_UiHelper.h"
#import "CC_CodeClass.h"
#import "CC_Array.h"
#import "CC_GCoreDataManager.h"
#import "CC_GColor.h"
#import "CC_Envirnment.h"
#import "PlatformConfig.h"

#define NOTIFICATION_LOGIN_EXPIRED @"NOTIFICATION_LOGIN_EXPIRED"
#define NOTIFICATION_USER_LOGIN_FORBID @"NOTIFICATION_USER_LOGIN_FORBID"
#define NOTIFICATION_jumpLogin @"NOTIFICATION_jumpLogin"

@interface CC_Share : NSObject

@property (nonatomic,retain) NSMutableURLRequest *httpRequest;///>http

@property (nonatomic,retain) NSString *user_signKey;///>md5 key

+ (instancetype)shareInstance;

#pragma mark http connection
/** 
 * 设置 登陆后的 md5 key
 */
- (void)setUserSignKey:(NSString *)signKey;

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
