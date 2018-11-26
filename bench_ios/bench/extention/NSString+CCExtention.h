//
//  NSString+_CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/8/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CCExtention)

/**
 *  把string拆分成单个字
 */
- (NSArray *)ccWords:(NSString *)cStr;

/**
 *  修正小数如8.369999999999999问题
 */
- (NSString *)correctDecimalLoss;

/**
 *  根据宽度和字体计算高度
 */
- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  根据高度和字体计算宽度
 */
- (CGFloat)widthForHeight:(CGFloat)height font:(UIFont *)font;

@end
