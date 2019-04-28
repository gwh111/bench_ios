//
//  AppFormatDic.m
//  AppleToolProj
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_FormatDic.h"
#import "CC_MD5Object.h"

@implementation CC_FormatDic

+ (NSMutableString *)getFormatStringWithDic: (NSMutableDictionary *)dic{
    NSMutableString *formatString=[[NSMutableString alloc]init];
    
    NSArray *keysArray = [dic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    for (NSString *categoryId in resultArray) {
        [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,[dic objectForKey:categoryId]]];
    }
    
    NSRange range = NSMakeRange (formatString.length-1, 1);
    [formatString deleteCharactersInRange:range];
    
    return formatString;
}

+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:NO];
}

+ (NSMutableString *)getSignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:YES];
}

+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString onlySign:(BOOL)onlySign{
    NSMutableString *formatString=[[NSMutableString alloc]init];
    NSMutableString *urlFormatString=[[NSMutableString alloc]init];
    
    NSMutableDictionary *newDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    
    NSArray *keysArray = [newDic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    
    for (NSString *categoryId in resultArray) {
        NSString *valueStr=[NSString stringWithFormat:@"%@",[newDic objectForKey:categoryId]];
        //替换服务端不能识别的空格
        //微信里的空格 处理
        valueStr=[valueStr stringByReplacingOccurrencesOfString:@" " withString:@" "];
        NSString *tempString=( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL, /* allocator */
                                                                                                    (CFStringRef)[NSString stringWithFormat:@"%@",valueStr],
                                                                                                    NULL, /* charactersToLeaveUnescaped */
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]<>&\\",kCFStringEncodingUTF8)) ;
        
        
        if (tempString.length>0) {//参数为空不放入
            [urlFormatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,tempString]];
            
            [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,valueStr]];
        }
        
    }
    
    if (formatString.length>0) {
        NSRange range = NSMakeRange (formatString.length-1, 1);
        [formatString deleteCharactersInRange:range];
    }
    
    if (onlySign) {
        return [[NSMutableString alloc]initWithString:[CC_MD5Object signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]];
    }
    
    if (MD5KeyString) {
        [urlFormatString appendString:[NSString stringWithFormat:@"sign=%@",[CC_MD5Object signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]]];
    }else{
        
        if (urlFormatString.length>0) {
            NSRange range = NSMakeRange (urlFormatString.length-1, 1);
            [urlFormatString deleteCharactersInRange:range];
        }
    }
    
    return urlFormatString;
}

@end
