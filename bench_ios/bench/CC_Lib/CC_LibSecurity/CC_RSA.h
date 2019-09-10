//
//  CC_RSA.h
//  RSAUtil
//
//  Created by gwh on 2019/3/28.
//  Copyright © 2019 ideawu. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_RSA : NSObject

/** RSA第三方警告 已修改
 - WARN  | [iOS] xcodebuild:  RSA.m:275:49: warning: values of type 'OSStatus' should not be used as format arguments; add an explicit cast to 'int' instead [-Wformat]
 - WARN  | [iOS] xcodebuild:  RSA.m:331:49: warning: values of type 'OSStatus' should not be used as format arguments; add an explicit cast to 'int' instead [-Wformat] */

// 公钥加密
// NSString格式
+ (NSString *)cc_encryptStr:(NSString *)str publicKey:(NSString *)pubKey;

// 公钥加密
// NSData格式
+ (NSData *)cc_encryptData:(NSData *)data publicKey:(NSString *)pubKey;

// 私钥加密
// NSString格式
+ (NSString *)cc_encryptStr:(NSString *)str privateKey:(NSString *)privKey;

// 私钥加密
// NSData格式
+ (NSData *)cc_encryptData:(NSData *)data privateKey:(NSString *)privKey;

// 公钥解密
// NSString格式
+ (NSString *)cc_decryptStr:(NSString *)str publicKey:(NSString *)pubKey;

// 公钥解密
// NSData格式
+ (NSData *)cc_decryptData:(NSData *)data publicKey:(NSString *)pubKey;

// 私钥解密
// NSString格式
+ (NSString *)cc_decryptStr:(NSString *)str privateKey:(NSString *)privKey;

// 私钥解密
// NSData格式
+ (NSData *)cc_decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
