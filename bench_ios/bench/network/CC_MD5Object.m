//
//  AppMD5Object.m
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_MD5Object.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CC_MD5Object

+ (NSString *)signString:(NSString*)origString
{//CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
    //    char *char_content = [origString cStringUsingEncoding:NSASCIIStringEncoding];
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
}

@end
