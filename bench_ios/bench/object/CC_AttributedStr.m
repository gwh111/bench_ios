//
//  AppAttributedStr.m
//  JCZJ
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_AttributedStr.h"

@implementation CC_AttributedStr

+ (NSMutableAttributedString *)getOrigAttStr:(NSMutableAttributedString *)origAttStr appendStr:(NSString *)appendStr withColor:(UIColor *)color{
    if (!appendStr||appendStr.length==0) {
        return origAttStr;
    }
    NSMutableAttributedString *appendAttStr=[[NSMutableAttributedString alloc]initWithString:appendStr];
    [appendAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,appendAttStr.length)];
    [origAttStr appendAttributedString:appendAttStr];
    
    return origAttStr;
}

+ (NSMutableAttributedString *)getOrigAttStr:(NSMutableAttributedString *)origAttStr appendStr:(NSString *)appendStr withColor:(UIColor *)color andFont:(UIFont *)font{
    if (!appendStr||appendStr.length==0) {
        return origAttStr;
    }
    NSMutableAttributedString *appendAttStr=[[NSMutableAttributedString alloc]initWithString:appendStr];
    [appendAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,appendAttStr.length)];
    [appendAttStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,appendAttStr.length)];
    [origAttStr appendAttributedString:appendAttStr];
    
    return origAttStr;
}

- (NSString *)cutHtmlTagFromStr:(NSString *)htmlStr withTagName:(NSString *)tagNameStr toStr:(NSString *)replaceStr trimSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:htmlStr];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:[NSString stringWithFormat:@"<%@",tagNameStr] intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:
                   [ NSString stringWithFormat:@"%@>", text]
                                                     withString:replaceStr];
    }
    
    return trim ? [htmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : htmlStr;
}

@end
