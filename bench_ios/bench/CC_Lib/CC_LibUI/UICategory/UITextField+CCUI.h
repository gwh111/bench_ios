//
//  UITextField+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CCUI)

- (__kindof UITextField *(^)(NSString *))cc_text;

- (__kindof UITextField *(^)(NSAttributedString *))cc_attributedText;

- (__kindof UITextField *(^)(UIColor *))cc_textColor;

- (__kindof UITextField *(^)(UIFont *))cc_font;

- (__kindof UITextField *(^)(NSTextAlignment))cc_textAlignment;

- (__kindof UITextField *(^)(UITextBorderStyle))cc_borderStyle;

- (__kindof UITextField *(^)(NSString *))cc_placeholder;

- (__kindof UITextField *(^)(NSAttributedString *))cc_attributedPlaceholder;

- (__kindof UITextField *(^)(BOOL))cc_clearsOnBeginEditing;

- (__kindof UITextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth;

- (__kindof UITextField *(^)(UIImage *))cc_background;

- (__kindof UITextField *(^)(id<UITextFieldDelegate>))cc_delegate;

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (__kindof UITextField *(^)(BOOL))cc_allowsEditingTextAttributes;

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_clearButtonMode;

/// e.g. magnifying glass
- (__kindof UITextField *(^)(UIView *))cc_leftView;

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_leftViewMode;

/// e.g. bookmarks button
- (__kindof UITextField *(^)(UIView *))cc_rightView;

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (__kindof UITextField *(^)(UITextFieldViewMode))cc_rightViewMode;

@end

@interface UITextField (CCActions)

/** 检查textField.text的最大长度 (超出截掉)*/
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
