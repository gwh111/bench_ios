//
//  AppFormatDic.h
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_FormatDic : NSObject

/** 字典转换成xx=xx&xx=xx……的字符串*/
+ (NSMutableString *)getFormatStringWithDic:(NSMutableDictionary *)dic;

/** 字典转换成带有md5签名的xx=xx&xx=xx……的字符串*/
+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

@end
