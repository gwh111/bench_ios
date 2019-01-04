//
//  AESEncrypt.h
//  testaes
//
//  Created by gwh on 2018/6/4.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_AES : NSObject

/**
 *  CBC模式使用偏移量
    https://www.jianshu.com/p/2e68a91d4681
 */
+ (NSData *)encryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;
+ (NSData *)decryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;
/**
 *  没有偏移量
 */
+ (NSData *)encryptData:(NSData *)data key:(NSData *)key;
+ (NSData *)decryptData:(NSData *)data key:(NSData *)key;

@end
