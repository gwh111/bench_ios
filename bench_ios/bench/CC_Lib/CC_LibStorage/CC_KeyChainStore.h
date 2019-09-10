//
//  KeyChainStore.h
//  HHSLive
//
//  Created by 杜文杰 on 2017/9/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_KeyChainStore : NSObject

+ (void)cc_saveKeychainWithName:(NSString *)key str:(NSString *)str;
+ (NSString *)cc_keychainWithName:(NSString *)name;

// 生成一个用户UUID保存到keychain，即使app删除再安装只要bid不变就存在
+ (NSString *)cc_keychainUUID;

@end
