//
//  UITextView+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CCUI)

- (__kindof UITextView *(^)(NSString *))cc_text;

- (__kindof UITextView *(^)(UIFont   *))cc_font;

- (__kindof UITextView *(^)(UIColor  *))cc_textColor;

- (__kindof UITextView *(^)(NSRange ))cc_selectedRange;

- (__kindof UITextView *(^)(BOOL))cc_editable;

- (__kindof UITextView *(^)(BOOL))cc_selectable;

- (__kindof UITextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes;

- (__kindof UITextView *(^)(NSTextAlignment))cc_textAlignment;

- (__kindof UITextView *(^)(id<UITextViewDelegate>))cc_delegate;

@end

@interface UITextView (CCActions)

/** 检查textView.text的最大长度 (超出截掉) */
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

/** get textView height after set width&text */
- (float)cc_heightForWidth:(float)width;

/** get textView width after set height&text */
- (float)cc_widthForHeight:(float)height;

@end

NS_ASSUME_NONNULL_END
