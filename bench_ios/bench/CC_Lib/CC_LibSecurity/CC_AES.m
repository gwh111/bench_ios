//
//  AESEncrypt.m
//  testaes
//
//  Created by gwh on 2018/6/4.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "CC_AES.h"
#import <CommonCrypto/CommonCrypto.h>

//NSData* xmlData = [@"testdata" dataUsingEncoding:NSUTF8StringEncoding];
//NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
@implementation CC_AES

+ (instancetype)shared{
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        CC_AES.shared.cc_AESKey = @"apple";
    }];
}

//加密
+ (NSData *)cc_encryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data{
    if (!data) {
        return nil;
    }
    return [self AES128operation:kCCEncrypt key:key iv:iv data:data];
}

//解密
+ (NSData *)cc_decryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data{
    if (!data) {
        return nil;
    }
    return [self AES128operation:kCCDecrypt key:key iv:iv data:data];
}

+ (NSData *)AES128operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv data:(NSData *)data{
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        CCLOG(@"error:%d",cryptorStatus);
    }
    
    free(buffer);
    return nil;
}

//需要导入：#import <CommonCrypto/CommonCrypto.h>库才能使用
/**
 *  AES128 + ECB + PKCS7
 *  @param data 要加密的原始数据
 *  @param key  加密 key
 *  @return  加密后数据
 */
+ (NSData *)cc_encryptData:(NSData *)data key:(NSData *)key{
    //判断解密的流数据是否存在
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([data length] <= 0) {
        return nil;
    }
    
    //判断解密的Key是否存在
    if ((key == nil) || (key == NULL)) {
        return nil;
    } else if (![key isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([key length] <= 0) {
        return nil;
    }
    
    //setup key
    NSData *result = nil;
    unsigned char cKey[kCCKeySizeAES128];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:kCCKeySizeAES128];
    
    //setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    //do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES128,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
    }
    return result;
}

/**
 *  AES128 + ECB + PKCS7
 *  @param data 要解密的原始数据
 *  @param key  解密 key
 *  @return  解密后数据
 */
+ (NSData *)cc_decryptData:(NSData *)data key:(NSData *)key{
    //判断解密的流数据是否存在
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([data length] <= 0) {
        return nil;
    }
    
    //判断解密的Key是否存在
    if ((key == nil) || (key == NULL)) {
        return nil;
    } else if (![key isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([key length] <= 0) {
        return nil;
    }
    
    //setup key
    NSData *result = nil;
    unsigned char cKey[kCCKeySizeAES128];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:kCCKeySizeAES128];
    
    //setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    //do decrypt
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES128,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
    }
    return result;
}

@end
