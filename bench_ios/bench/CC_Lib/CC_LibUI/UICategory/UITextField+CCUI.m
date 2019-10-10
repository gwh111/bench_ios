//
//  UITextField+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UITextField+CCUI.h"

@implementation UITextField (CCUI)

- (__kindof UITextField *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof UITextField *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (__kindof UITextField *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof UITextField *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof UITextField *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (__kindof UITextField *(^)(UITextBorderStyle))cc_borderStyle{
    return ^(UITextBorderStyle borderStyle){
        self.borderStyle = borderStyle;
        return self;
    };
}

- (__kindof UITextField *(^)(NSString *))cc_placeholder{
    return ^(NSString *placeholder){
        self.placeholder = placeholder;
        return self;
    };
}

- (__kindof UITextField *(^)(NSAttributedString *))cc_attributedPlaceholder{
    return ^(NSAttributedString *attributedPlaceholder){
        self.attributedPlaceholder = attributedPlaceholder;
        return self;
    };
}

- (__kindof UITextField *(^)(BOOL))cc_clearsOnBeginEditing{
    return ^(BOOL clearsOnBeginEditing){
        self.clearsOnBeginEditing = clearsOnBeginEditing;
        return self;
    };
}

- (__kindof UITextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth{
    return ^(BOOL adjustsFontSizeToFitWidth){
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
        return self;
    };
}

- (__kindof UITextField *(^)(UIImage *))cc_background{
    return ^(UIImage *background){
        self.background = background;
        return self;
    };
}

- (__kindof UITextField *(^)(id<UITextFieldDelegate>))cc_delegate{
    return ^(id<UITextFieldDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (__kindof UITextField *(^)(BOOL))cc_allowsEditingTextAttributes {
    return ^(BOOL allowEditing) {
        self.allowsEditingTextAttributes = allowEditing;
        return self;
    };
}

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_clearButtonMode {
    return ^(UITextFieldViewMode viewMode) {
        self.clearButtonMode = viewMode;
        return self;
    };
}

/// e.g. magnifying glass
- (__kindof UITextField *(^)(UIView *))cc_leftView {
    return ^(UIView *leftView) {
        self.leftView = leftView;
        return self;
    };
}

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_leftViewMode {
    return ^(UITextFieldViewMode viewMode) {
        self.leftViewMode = viewMode;
        return self;
    };
}

/// e.g. bookmarks button
- (__kindof UITextField *(^)(UIView *))cc_rightView {
    return ^(UIView *rightView) {
        self.rightView = rightView;
        return self;
    };
}

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_rightViewMode {
    return ^(UITextFieldViewMode viewMode) {
        self.rightViewMode = viewMode;
        return self;
    };
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
