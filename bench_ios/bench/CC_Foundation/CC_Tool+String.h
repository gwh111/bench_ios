//
//  CC_Tool+String.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (String)

- (CGFloat)getStringHeightWithText:(NSString *)text font:(UIFont *)font viewWidth:(CGFloat)width;

// replace html label <aaa> to <bbb>
- (NSString *)replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace;

// 字典转换成带有md5签名的xx=xx&xx=xx...的字符串
- (NSMutableString *)MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(nullable NSString *)MD5KeyString;

// 获得签名
- (NSMutableString *)MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(nullable NSString *)MD5KeyString;

// 转换html
- (NSAttributedString *)convertToHTMLString:(NSString *)htmlString;

@end

NS_ASSUME_NONNULL_END
