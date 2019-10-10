//
//  CC_Dictionary.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Dictionary : NSObject

/**
 *  字典转换成xx=xx&xx=xx……的字符串
 */
+ (NSMutableString *)getFormatStringWithDic:(NSMutableDictionary *)dic;

/**
 *  字典转换成带有md5签名的xx=xx&xx=xx……的字符串
 */
+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

/**
 *  获得签名
 */
+ (NSMutableString *)getSignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

@end

NS_ASSUME_NONNULL_END
