//
//  NSString+CC.h
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CC_CoreFoundation.h"

@interface NSString (CC_Lib)

/** update bind text, use with cc_bindText()
    更新绑定的UI控件，和cc_bindText()结合使用 */
- (void)cc_update:(NSString *)str;

/** cut string to char
    把string拆分成单个字 */
- (NSArray *)cc_convertToWord;

// URL编码 转换!*'();:@&=+$,/?%#[]
- (NSString *)cc_convertToUrlString;

// string to data, utf8编码
- (NSData *)cc_convertToUTF8data;

// string to data, base64
- (NSData *)cc_convertToBase64data;

// string to date
- (NSDate *)cc_convertToDate;

// string to date with formatter
- (NSDate *)cc_convertToDateWithformatter:(NSString *)formatterStr;

/** fix number problem such as: 8.369999999999999
    修正小数如8.369999999999999问题 */
- (NSString *)cc_convertToDecimalLosslessString;

/** decimal function
    处理小数位数问题
    @param roundingMode 进位模式
        NSRoundPlain 四舍五入
        NSRoundDown 舍去
        NSRoundUp 进位
        NSRoundBankers 四舍六入五成双
    @param scale 保留小数位数
    exp:
    NSString *str1=@"1.254";
    str1=[str1 getDecimalStrWithMode:NSRoundPlain scale:1]; */
- (NSString *)cc_convertToDecimalStr:(NSRoundingMode)roundingMode scale:(short)scale;

- (NSString *)cc_removeSuffixZero:(NSString *)numberStr;

#pragma mark is
- (BOOL)cc_isPureInt;

// 纯字母
- (BOOL)cc_isPureLetter;

// 纯中文
- (BOOL)cc_isPureChinese;

// 只有数字字母和中文
- (BOOL)cc_isNumberWordChinese;

// 有中文
- (BOOL)cc_hasChinese;

// 手机号码验证
- (BOOL)cc_isMobileCell;

// 邮箱
- (BOOL)cc_isEmail;

@end

@interface NSMutableAttributedString (CC_Lib)

- (void)cc_appendAttStr:(NSString *)appendStr color:(UIColor *)color;

- (void)cc_appendAttStr:(NSString *)appendStr color:(UIColor *)color font:(UIFont *)font;

@end
