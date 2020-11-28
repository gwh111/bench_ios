//
//  CC_Tool+String.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool+String.h"
#import "CC_MD5Object.h"

@implementation CC_Tool (String)

- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width {
    // 设置文字属性 要和label的一致
    NSDictionary *attrs = @{NSFontAttributeName :font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);

    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    // 计算文字占据的宽高
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;

   // 当你是把获得的高度来布局控件的View的高度的时候.size转化为ceilf(size.height)。
    return  ceilf(size.height);
}

- (NSAttributedString *)convertToHTMLString:(NSString *)htmlString {
    NSData *data = [htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *att = [[NSAttributedString alloc]initWithData:data
                                                               options:options
                                                    documentAttributes:nil
                                                                 error:nil];
    return att;
}

- (NSString *)replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace {
    NSScanner *theScanner = [NSScanner scannerWithString:htmlStr];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:[NSString stringWithFormat:@"<%@",labelName] intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]withString:toLabelName];
    }
    return trimSpace ? [htmlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : htmlStr;
}

- (NSMutableString *)MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString {
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:NO];
}

- (NSMutableString *)MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString {
    return [self getSignFormatStringWithDic:dic andMD5Key:MD5KeyString onlySign:YES];
}

- (NSMutableString *)getSignFormatStringWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString onlySign:(BOOL)onlySign {
    NSMutableString *formatString = [[NSMutableString alloc]init];
    NSMutableString *urlFormatString = [[NSMutableString alloc]init];
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    
    NSArray *keysArray = [newDic allKeys];
    NSArray *resultArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for (NSString *categoryId in resultArray) {
        NSString *valueStr = [NSString stringWithFormat:@"%@",[newDic objectForKey:categoryId]];
        //替换服务端不能识别的空格
        //微信里的空格 处理
        valueStr=[valueStr stringByReplacingOccurrencesOfString:@" " withString:@" "];
        
        NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
//        [allowed addCharactersInString:@"!*'();:@&=+$,/?%#[]<>&\\"];
        
        NSString *tempString = [valueStr stringByAddingPercentEncodingWithAllowedCharacters:allowed];
        
//        if (tempString.length > 0) {//参数为空不放入
//        }
        [urlFormatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,tempString]];
        [formatString appendString:[NSString stringWithFormat:@"%@=%@&",categoryId,valueStr]];
    }
    if (formatString.length > 0) {
        NSRange range = NSMakeRange (formatString.length-1, 1);
        [formatString deleteCharactersInRange:range];
    }
    if (onlySign) {
        return [[NSMutableString alloc]initWithString:[CC_MD5Object signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]];
    }
    if (MD5KeyString) {
        [urlFormatString appendString:[NSString stringWithFormat:@"sign=%@",[CC_MD5Object signString:[NSString stringWithFormat:@"%@%@",MD5KeyString,formatString]]]];
    } else {
        if (urlFormatString.length > 0) {
            NSRange range = NSMakeRange (urlFormatString.length-1, 1);
            [urlFormatString deleteCharactersInRange:range];
        }
    }
    return urlFormatString;
}

@end
