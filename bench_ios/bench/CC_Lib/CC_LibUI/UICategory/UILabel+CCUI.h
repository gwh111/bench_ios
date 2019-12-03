//
//  UILabel+CCUI.h
//  bench_ios
//
//  Created by Shepherd on 2019/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CC_Label;

@interface UILabel (CCUI)

/// 设置内容 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (UILabel *(^)(NSString *))cc_text;

/// 设置字体
- (UILabel *(^)(UIFont *))cc_font;

/// 设置字体颜色
- (UILabel *(^)(UIColor *))cc_textColor;

/// 设置阴影色
- (UILabel *(^)(UIColor *))cc_shadowColor;

/// 设置阴影偏移值
- (UILabel *(^)(CGFloat, CGFloat))cc_shadowOffset;

/// 设置对齐方式
- (UILabel *(^)(NSTextAlignment))cc_textAlignment;

/// 设置换行 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (UILabel *(^)(NSLineBreakMode))cc_lineBreakMode;

/// 设置富文本
- (UILabel *(^)(NSAttributedString *))cc_attributedText;

/// 设置行数
- (UILabel *(^)(NSInteger))cc_numberOfLines;

@end

// MARK: - UILabel的属性链式协议 -

@protocol CC_LabelChainExtProtocol <NSObject>

/// 设置内容 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(NSString *))cc_text;

/// 设置字体
- (__kindof CC_Label *(^)(UIFont *))cc_font;

/// 设置字体颜色
- (__kindof CC_Label *(^)(UIColor *))cc_textColor;

/// 设置阴影色
- (__kindof CC_Label *(^)(UIColor *))cc_shadowColor;

/// 设置阴影偏移值
- (__kindof CC_Label *(^)(CGFloat, CGFloat))cc_shadowOffset;

/// 设置对齐方式
- (__kindof CC_Label *(^)(NSTextAlignment))cc_textAlignment;

/// 设置换行 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(NSLineBreakMode))cc_lineBreakMode;

/// 设置富文本
- (__kindof CC_Label *(^)(NSAttributedString *))cc_attributedText;

/// 设置行数
- (__kindof CC_Label *(^)(NSInteger))cc_numberOfLines;

@end

NS_ASSUME_NONNULL_END
