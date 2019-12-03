//
//  UITextField+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UITextField+CCUI.h"

@implementation UITextField (CCUI)

- (UITextField *(^)(NSString *))cc_text{
    return ^(NSString *_) {
        if (_) {
            self.text = _;
        }
        return self;
    };
}

- (UITextField *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *_) { self.attributedText = _; return self; };
}

- (UITextField *(^)(UIColor *))cc_textColor{
    return ^(UIColor *_) { self.textColor = _; return self; };
}

- (UITextField *(^)(UIFont *))cc_font{
    return ^(UIFont *_) { self.font = _; return self; };
}

- (UITextField *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment _) { self.textAlignment = _; return self; };
}

- (UITextField *(^)(UITextBorderStyle))cc_borderStyle{
    return ^(UITextBorderStyle _) { self.borderStyle = _; return self; };
}

- (UITextField *(^)(NSString *))cc_placeholder{
    return ^(NSString *_) { self.placeholder = _; return self; };
}

- (UITextField *(^)(NSAttributedString *))cc_attributedPlaceholder{
    return ^(NSAttributedString *_) { self.attributedPlaceholder = _; return self; };
}

- (UITextField *(^)(BOOL))cc_clearsOnBeginEditing{
    return ^(BOOL _) { self.clearsOnBeginEditing = _; return self; };
}

- (UITextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth{
    return ^(BOOL _) { self.adjustsFontSizeToFitWidth = _; return self; };
}

- (UITextField *(^)(UIImage *))cc_background{
    return ^(UIImage *_) { self.background = _; return self; };
}

- (UITextField *(^)(id<UITextFieldDelegate>))cc_delegate{
    return ^(id<UITextFieldDelegate> _) { self.delegate = _; return self; };
}

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (UITextField *(^)(BOOL))cc_allowsEditingTextAttributes {
    return ^(BOOL _) { self.allowsEditingTextAttributes = _; return self; };
}

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_clearButtonMode {
    return ^(UITextFieldViewMode _) { self.clearButtonMode = _; return self; };
}

/// e.g. magnifying glass
- (UITextField *(^)(UIView *))cc_leftView {
    return ^(UIView *_) { self.leftView = _; return self; };
}

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_leftViewMode {
    return ^(UITextFieldViewMode _) { self.leftViewMode = _; return self; };
}

/// e.g. bookmarks button
- (UITextField *(^)(UIView *))cc_rightView {
    return ^(UIView *_) { self.rightView = _; return self; };
}

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_rightViewMode {
    return ^(UITextFieldViewMode _) { self.rightViewMode = _; return self; };
}

@end

@implementation UITextField (CCActions)

- (void)cc_cutWithMaxLength:(NSUInteger)maxLength {
    //1.获取标记的占位textRange(待确认输入的textRange)
    UITextRange *selectedRange = [self markedTextRange];
    
    //2.获取标记区域的字符串
    NSString *newText = [self textInRange:selectedRange];
    
    //3.如果nextText为空, 且self.text的字数超了 ==> 进行截取
    if (newText.length<1 && self.text.length>maxLength) {
        self.text = [self.text substringToIndex:maxLength];
    }
}

@end
