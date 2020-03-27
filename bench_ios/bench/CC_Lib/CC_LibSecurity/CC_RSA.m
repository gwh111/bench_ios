//
//  CC_RSA.m
//  RSAUtil
//
//  Created by gwh on 2019/3/28.
//  Copyright © 2019 ideawu. All rights reserved.
//

#import "CC_RSA.h"
#import "RSA.h"

@implementation CC_RSA

#pragma mark 加密
+ (NSString *)encryptStr:(NSString *)str publicKey:(NSString *)pubKey {
    return [RSA encryptString:str publicKey:pubKey];
}

+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey {
    return [RSA encryptData:data publicKey:pubKey];
}

+ (NSString *)encryptStr:(NSString *)str privateKey:(NSString *)privKey {
    return [RSA encryptString:str privateKey:privKey];
}

+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey {
    return [RSA encryptData:data privateKey:privKey];
}

#pragma mark 解密
+ (NSString *)decryptStr:(NSString *)str publicKey:(NSString *)pubKey {
    return [RSA decryptString:str publicKey:pubKey];
}

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey {
    return [RSA decryptData:data publicKey:pubKey];
}

+ (NSString *)decryptStr:(NSString *)str privateKey:(NSString *)privKey {
    return [RSA decryptString:str privateKey:privKey];
}

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey {
    return [RSA decryptData:data privateKey:privKey];
}

@end
