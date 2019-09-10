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
+ (NSString *)cc_encryptStr:(NSString *)str publicKey:(NSString *)pubKey{
    return [RSA encryptString:str publicKey:pubKey];
}

+ (NSData *)cc_encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    return [RSA encryptData:data publicKey:pubKey];
}

+ (NSString *)cc_encryptStr:(NSString *)str privateKey:(NSString *)privKey{
    return [RSA encryptString:str privateKey:privKey];
}

+ (NSData *)cc_encryptData:(NSData *)data privateKey:(NSString *)privKey{
    return [RSA encryptData:data privateKey:privKey];
}

#pragma mark 解密
+ (NSString *)cc_decryptStr:(NSString *)str publicKey:(NSString *)pubKey{
    return [RSA decryptString:str publicKey:pubKey];
}

+ (NSData *)cc_decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    return [RSA decryptData:data publicKey:pubKey];
}

+ (NSString *)cc_decryptStr:(NSString *)str privateKey:(NSString *)privKey{
    return [RSA decryptString:str privateKey:privKey];
}

+ (NSData *)cc_decryptData:(NSData *)data privateKey:(NSString *)privKey{
    return [RSA decryptData:data privateKey:privKey];
}

@end
