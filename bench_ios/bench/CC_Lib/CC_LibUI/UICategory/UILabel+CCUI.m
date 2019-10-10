//
//  UILabel+CCUI.m
//  bench_ios
//
//  Created by Shepherd on 2019/9/22.
//

#import "UILabel+CCUI.h"

@implementation UILabel (CCUI)

- (__kindof UILabel *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof UILabel *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof UILabel *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof UILabel *(^)(UIColor *))cc_shadowColor{
    return ^(UIColor *shadowColor){
        self.shadowColor = shadowColor;
        return self;
    };
}

- (__kindof UILabel *(^)(CGFloat, CGFloat))cc_shadowOffset{
    return ^(CGFloat w, CGFloat h){
        self.shadowOffset = CGSizeMake(w, h);
        return self;
    };
}

- (__kindof UILabel *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (__kindof UILabel *(^)(NSLineBreakMode))cc_lineBreakMode{
    return ^(NSLineBreakMode lineBreakMode){
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (__kindof UILabel *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (__kindof UILabel *(^)(NSInteger))cc_numberOfLines{
    return ^(NSInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}

@end
