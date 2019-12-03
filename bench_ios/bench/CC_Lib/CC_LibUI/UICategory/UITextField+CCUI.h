//
//  UITextField+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_TextField;

@interface UITextField (CCUI)

- (UITextField *(^)(NSString *))cc_text;

- (UITextField *(^)(NSAttributedString *))cc_attributedText;

- (UITextField *(^)(UIColor *))cc_textColor;

- (UITextField *(^)(UIFont *))cc_font;

- (UITextField *(^)(NSTextAlignment))cc_textAlignment;

- (UITextField *(^)(UITextBorderStyle))cc_borderStyle;

- (UITextField *(^)(NSString *))cc_placeholder;

- (UITextField *(^)(NSAttributedString *))cc_attributedPlaceholder;

- (UITextField *(^)(BOOL))cc_clearsOnBeginEditing;

- (UITextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth;

- (UITextField *(^)(UIImage *))cc_background;

- (UITextField *(^)(id<UITextFieldDelegate>))cc_delegate;

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (UITextField *(^)(BOOL))cc_allowsEditingTextAttributes;

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_clearButtonMode;

/// e.g. magnifying glass
- (UITextField *(^)(UIView *))cc_leftView;

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_leftViewMode;

/// e.g. bookmarks button
- (UITextField *(^)(UIView *))cc_rightView;

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (UITextField *(^)(UITextFieldViewMode))cc_rightViewMode;

@end

@interface UITextField (CCActions)

/** 检查textField.text的最大长度 (超出截掉)*/
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

@end

@protocol CC_TextFieldChainExtProtocol <NSObject>

- (__kindof CC_TextField *(^)(NSString *))cc_text;
- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedText;
- (__kindof CC_TextField *(^)(UIColor *))cc_textColor;
- (__kindof CC_TextField *(^)(UIFont *))cc_font;
- (__kindof CC_TextField *(^)(NSTextAlignment))cc_textAlignment;
- (__kindof CC_TextField *(^)(UITextBorderStyle))cc_borderStyle;
- (__kindof CC_TextField *(^)(NSString *))cc_placeholder;
- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedPlaceholder;
- (__kindof CC_TextField *(^)(BOOL))cc_clearsOnBeginEditing;
- (__kindof CC_TextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth;
- (__kindof CC_TextField *(^)(UIImage *))cc_background;

- (__kindof CC_TextField *(^)(id<UITextFieldDelegate>))cc_delegate;

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (__kindof CC_TextField *(^)(BOOL))cc_allowsEditingTextAttributes;

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_clearButtonMode;

/// e.g. magnifying glass
- (__kindof CC_TextField *(^)(UIView *))cc_leftView;

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_leftViewMode;

/// e.g. bookmarks button
- (__kindof CC_TextField *(^)(UIView *))cc_rightView;

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_rightViewMode;


@end

NS_ASSUME_NONNULL_END
