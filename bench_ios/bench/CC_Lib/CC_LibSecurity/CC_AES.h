//
//  AESEncrypt.h
//  testaes
//
//  Created by gwh on 2018/6/4.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_AES : NSObject

@property (nonatomic,retain) NSString *cc_AESKey;

+ (instancetype)shared;

// CBC模式使用偏移量
// https://www.jianshu.com/p/2e68a91d4681
+ (NSData *)cc_encryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;
+ (NSData *)cc_decryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;

// 没有偏移量 
+ (NSData *)cc_encryptData:(NSData *)data key:(NSData *)key;
+ (NSData *)cc_decryptData:(NSData *)data key:(NSData *)key;

@end
