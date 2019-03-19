//
//  NSString+_CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/8/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCCat)

/**
 *  把string拆分成单个字
 */
- (NSArray *)ccWords:(NSString *)cStr;

/**
 *  修正小数如8.369999999999999问题
 */
- (NSString *)correctDecimalLoss;

/**
 *  处理小数位数问题
    roundingMode进位模式
    NSRoundPlain 四舍五入
    NSRoundDown 舍去
    NSRoundUp 进位
    NSRoundBankers 四舍六入五成双
    scale 保留小数位数
    exp:
         NSString *str1=@"1.254";
         str1=[str1 getDecimalStrWithMode:NSRoundPlain scale:1];
 */
- (NSString *)getDecimalStrWithMode:(NSRoundingMode)roundingMode scale:(short)scale;

/**
 *  根据宽度和字体计算高度(不准 不好用)
    对于\n只当一个字符串
 */
- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  根据高度和字体计算宽度
    对于\n只当一个字符串
 */
- (CGFloat)widthForHeight:(CGFloat)height font:(UIFont *)font;

@end
