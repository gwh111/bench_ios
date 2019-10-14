//
//  CC_String.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_String.h"
#import "CC_MD5Object.h"

@implementation CC_String

+ (NSString *)cc_replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace{
    NSScanner *theScanner = [NSScanner scannerWithString:htmlStr];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:[NSString stringWithFormat:@"<%@",labelName] intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]withString:toLabelName];
    }
    return trimSpace ? [htmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : htmlStr;
}

+ (NSArray *)cc_getHtmlLabel:(NSString *)str start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd{
    NSScanner *theScanner;
    NSString *head = nil;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:str];
    NSMutableArray *mutText = [[NSMutableArray alloc]init];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:startStr intoString:&head];
        // find end of tag
        [theScanner scanUpToString:endStr intoString:&text];
        
        if (![text containsString:endStr]) {
            if (includeStartEnd) {
                text=[text stringByAppendingString:endStr];
            }else{
                text=[text stringByReplacingOccurrencesOfString:startStr withString:@""];
            }
            [mutText addObject:text];
        }
    }
    return mutText.copy;
}

+ (NSMutableString *)cc_MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:NO];
}

+ (NSMutableString *)cc_MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:YES];
}

+ (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString onlySign:(BOOL)onlySign{
    NSMutableString *formatString = [[NSMutableString alloc]init];
    NSMutableString *urlFormatString = [[NSMutableString alloc]init];
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    
    NSArray *keysArray = [newDic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for (NSString *categoryId in resultArray) {
        NSString *valueStr=[NSString stringWithFormat:@"%@",[newDic objectForKey:categoryId]];
        //替换服务端不能识别的空格
        //微信里的空格 处理
        valueStr=[valueStr stringByReplacingOccurrencesOfString:@" " withString:@" "];
        
        NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
        [allowed addCharactersInString:@"!*'();:@&=+$,/?%#[]<>&\\"];
        
        NSString *tempString = [valueStr stringByAddingPercentEncodingWithAllowedCharacters:allowed];
        
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
        return [[NSMutableString alloc]initWithString:[CC_MD5Object cc_signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]];
    }
    if (MD5KeyString) {
        [urlFormatString appendString:[NSString stringWithFormat:@"sign=%@",[CC_MD5Object cc_signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]]];
    }else{
        if (urlFormatString.length>0) {
            NSRange range = NSMakeRange (urlFormatString.length-1, 1);
            [urlFormatString deleteCharactersInRange:range];
        }
    }
    return urlFormatString;
}

@end

