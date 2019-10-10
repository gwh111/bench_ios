//
//  UILabel+CCUI.h
//  bench_ios
//
//  Created by Shepherd on 2019/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CCUI)

- (__kindof UILabel *(^)(NSString *))cc_text;

- (__kindof UILabel *(^)(UIFont *))cc_font;

- (__kindof UILabel *(^)(UIColor *))cc_textColor;

- (__kindof UILabel *(^)(UIColor *))cc_shadowColor;

- (__kindof UILabel *(^)(CGFloat, CGFloat))cc_shadowOffset;

- (__kindof UILabel *(^)(NSTextAlignment))cc_textAlignment;

- (__kindof UILabel *(^)(NSLineBreakMode))cc_lineBreakMode;

- (__kindof UILabel *(^)(NSAttributedString *))cc_attributedText;

- (__kindof UILabel *(^)(NSInteger))cc_numberOfLines;

@end

NS_ASSUME_NONNULL_END
