//
//  CC_Share.h
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifdef DEBUG
#   define CCLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CCLOG(...)
#endif

#define COLOR_BLACK [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]
#define COLOR_WHITE [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define COLOR_CLEAR [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0]

#define ccRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ccRGBHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ccRGBHexA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import <Foundation/Foundation.h>

#import "CC_Valiation.h"
#import "CC_Image.h"
#import "CC_Button.h"
#import "CC_Label.h"
#import "CC_AttributedStr.h"
#import "CC_DESTool.h"
#import "CC_UIViewExt.h"
#import "CC_UIHelper.h"
#import "CC_CodeClass.h"
#import "CC_Array.h"
#import "CC_GCoreDataManager.h"
#import "CC_GColor.h"
#import "CC_Envirnment.h"
#import "PlatformConfig.h"
#import "CC_HttpResponseModel.h"
#import "CC_GHttpSessionTask.h"
#import "CC_Note.h"
#import "CC_View.h"
#import "CC_TextField.h"
#import "CC_TextView.h"
#import "CC_LogicClass.h"

#define NOTIFICATION_LOGIN_EXPIRED @"NOTIFICATION_LOGIN_EXPIRED"
#define NOTIFICATION_USER_LOGIN_FORBID @"NOTIFICATION_USER_LOGIN_FORBID"
#define NOTIFICATION_jumpLogin @"NOTIFICATION_jumpLogin"

@interface CC_Share : NSObject

@property (nonatomic,assign) BOOL ccDebug;

+ (instancetype)shareInstance;

@end

#pragma mark
@interface s : NSObject

+ (NSDictionary *)getPlistDic:(NSString *)name;
+ (NSMutableDictionary *)getLocalPlistNamed:(NSString *)name;
+ (void)saveLocalPlistNamed:(NSString *)name;
+ (id)getLocalKeyNamed:(NSString *)name andKey:(NSString *)key;
+ (void)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value;

NSString *ccstr(NSString *format, ...);

@end

