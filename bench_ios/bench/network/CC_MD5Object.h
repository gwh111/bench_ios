//
//  AppMD5Object.h
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_MD5Object : NSObject

/** 字符串转为md5*/
+ (NSString *)signString:(NSString*)origString;

@end
