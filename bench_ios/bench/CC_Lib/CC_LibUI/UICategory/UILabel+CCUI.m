//
//  UILabel+CCUI.m
//  bench_ios
//
//  Created by Shepherd on 2019/9/22.
//

#import "UILabel+CCUI.h"

@implementation UILabel (CCUI)

- (UILabel *(^)(NSString *))cc_text{
    return ^(NSString *_) {
        if (_) {
            self.text = _;
        }
        return self;
    };
}

- (UILabel *(^)(UIFont *))cc_font{
    return ^(UIFont *_) { self.font = _; return self; };
}

- (UILabel *(^)(UIColor *))cc_textColor{
    return ^(UIColor *_) { self.textColor = _; return self; };
}

- (UILabel *(^)(UIColor *))cc_shadowColor{
    return ^(UIColor *_) { self.shadowColor = _; return self; };
}

- (UILabel *(^)(CGFloat, CGFloat))cc_shadowOffset{
    return ^(CGFloat w, CGFloat h){
        self.shadowOffset = CGSizeMake(w, h);
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment _) { self.textAlignment = _; return self; };
}

- (UILabel *(^)(NSLineBreakMode))cc_lineBreakMode{
    return ^(NSLineBreakMode _) { self.lineBreakMode = _; return self; };
}

- (UILabel *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *_) { self.attributedText = _; return self; };
}

- (UILabel *(^)(NSInteger))cc_numberOfLines{
    return ^(NSInteger _) { self.numberOfLines = _; return self;};
}

@end
