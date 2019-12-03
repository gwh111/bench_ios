//
//  UITextView+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CC_TextView;

@interface UITextView (CCUI)

- (UITextView *(^)(NSString *))cc_text;

- (UITextView *(^)(UIFont   *))cc_font;

- (UITextView *(^)(UIColor  *))cc_textColor;

- (UITextView *(^)(NSRange ))cc_selectedRange;

- (UITextView *(^)(BOOL))cc_editable;

- (UITextView *(^)(BOOL))cc_selectable;

- (UITextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes;

- (UITextView *(^)(NSTextAlignment))cc_textAlignment;

- (UITextView *(^)(id<UITextViewDelegate>))cc_delegate;

@end

@interface UITextView (CCActions)

/** 检查textView.text的最大长度 (超出截掉) */
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

/** get textView height after set width&text */
- (float)cc_heightForWidth:(float)width;

/** get textView width after set height&text */
- (float)cc_widthForHeight:(float)height;

@end


@protocol CC_TextViewChainSelfExtProtocol <NSObject>

- (__kindof CC_TextView *(^)(NSString *))cc_text;

- (__kindof CC_TextView *(^)(UIFont *))cc_font;

- (__kindof CC_TextView *(^)(UIColor *))cc_textColor;

- (__kindof CC_TextView *(^)(NSRange))cc_selectedRange;

- (__kindof CC_TextView *(^)(BOOL))cc_editable;

- (__kindof CC_TextView *(^)(BOOL))cc_selectable;

- (__kindof CC_TextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes;

- (__kindof CC_TextView *(^)(NSTextAlignment))cc_textAlignment;

- (__kindof CC_TextView *(^)(id<UITextViewDelegate>))cc_delegate;

@end

NS_ASSUME_NONNULL_END
