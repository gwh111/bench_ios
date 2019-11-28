//
//  NSMutableDictionary+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_CoreFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary(CCCat)

// 创建属性代码
- (void)cc_propertyCode;

@end

@interface NSMutableDictionary(CC_Lib)

- (void)safeSetObject:(id)obj forKey:(NSString *)aKey;

- (void)cc_setKey:(NSString *)aKey;
// Do nothing when key==nil
- (void)cc_setKey:(NSString *)aKey value:(id)value;

- (void)cc_removeKey:(NSString *)aKey;

// 字典转换成xx=xx&xx=xx...的字符串
- (NSMutableString *)cc_formatToString;

// 修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题，例子:
// NSString *html = @"{\"71.40\":71.40,\"8.37\":8.37,\"80.40\":80.40,\"188.40\":188.40}";此段html转换成NSMutableDictionary后使用correctNumberLoss处理耗时0.000379秒
- (NSMutableDictionary *)cc_correctDecimalLoss:(NSMutableDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
