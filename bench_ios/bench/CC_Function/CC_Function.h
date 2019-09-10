//
//  CC_Libhandler.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_CoreFoundation.h"

#import "CC_Object.h"
#import "CC_String.h"
#import "CC_Array.h"
#import "CC_Date.h"
#import "CC_Data.h"

@interface CC_Function : NSObject

#pragma mark data convert
+ (id)cc_jsonWithString:(NSString *)jsonString;

+ (NSString *)cc_stringWithJson:(id)object;

+ (NSData *)cc_dataWithInt:(int)i;

#pragma mark validate
+ (BOOL)cc_isEmpty:(id)obj;

// 是否从appstore下载的
+ (BOOL)cc_isInstallFromAppStore;

// 是否越狱
+ (BOOL)cc_isJailBreak;

#pragma mark compare
//  版本号对比 如1.3.2 比 1.4.1版本低 返回-1
//  1 v1>v2
//  0 v1=v2
// -1 v1<v2
+ (int)cc_compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;

#pragma mark date
// Default: formatArr = @[@"yyyy-MM-dd",@"MM-dd",@"昨天",@"HH:mm"]
+ (NSString *)cc_formatDate:(NSString *)date nowDate:(NSString *)nowDate;
+ (NSString *)cc_formatDate:(NSString *)date nowDate:(NSString *)nowDate formatArr:(NSArray *)formatArr;

#pragma mark math
// 度和弧度的转化
+ (float)cc_duWithHudu:(float)hudu;
+ (float)cc_huduWithDu:(float)du;

// 根据两点坐标计算距离
+ (float)cc_rPoint1:(CGPoint)point1 point2:(CGPoint)point2;
// 根据两点坐标计算连线和x轴角度
+ (float)cc_duPoint1:(CGPoint)point1 point2:(CGPoint)point2;
// 根据角度和长度获得新坐标位置。相对于(0,0)点
+ (CGPoint)cc_pointR:(float)r du:(float)du;

@end
