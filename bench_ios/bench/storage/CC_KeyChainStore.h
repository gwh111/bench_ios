//
//  KeyChainStore.h
//  HHSLive
//
//  Created by 杜文杰 on 2017/9/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#define KEY_USERNAME_PASSWORD @"com.gwh.mine.MyWord.usernamepassword"
#define KEY_USERNAME @"com.gwh.mine.MyWord.username"
#define KEY_PASSWORD @"com.gwh.mine.MyWord.password"

#import <Foundation/Foundation.h>

@interface CC_KeyChainStore : NSObject
+ (void)save:(NSString*)service data:(id)data;
+ (id)load:(NSString*)service;
+ (void)deleteKeyData:(NSString*)service;
@end
