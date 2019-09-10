//
//  CC_String.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_String : NSObject

// replace html label <aaa> to <bbb>
+ (NSString *)cc_replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace;

+ (NSArray *)cc_getHtmlLabel:(NSString *)htmlStr start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd;

// 字典转换成带有md5签名的xx=xx&xx=xx...的字符串
+ (NSMutableString *)cc_MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

// 获得签名
+ (NSMutableString *)cc_MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

@end
