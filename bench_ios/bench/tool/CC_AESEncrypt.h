//
//  AESEncrypt.h
//  testaes
//
//  Created by gwh on 2018/6/4.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_AESEncrypt : NSObject

+ (NSData *)encryptData:(NSData *)data key:(NSData *)key;
+ (NSData *)decryptData:(NSData *)data key:(NSData *)key;

@end
