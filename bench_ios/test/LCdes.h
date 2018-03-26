//
//  LCdes.h
//  DESDemo
//
//  Created by LuochuanAD on 16/4/29.
//  Copyright © 2016年 LuochuanAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
@interface LCdes : NSObject
//加密
+ (NSString *)lcEncryUseDES:(NSString *)string;
//解密
+ (NSString *)lcDecryUseDES:(NSString *)string;
//url编码
+ (NSString *)UrlValueEncode:(NSString *)str;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
@end
