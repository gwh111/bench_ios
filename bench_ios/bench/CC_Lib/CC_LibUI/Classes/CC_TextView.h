//
//  CC_TextView.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Lib+UITextView.h"

@interface CC_TextView : UITextView

- (__kindof CC_TextView *(^)(NSString *))cc_text;
- (__kindof CC_TextView *(^)(UIFont *))cc_font;
- (__kindof CC_TextView *(^)(UIColor *))cc_textColor;
- (__kindof CC_TextView *(^)(NSRange))cc_selectedRange;
- (__kindof CC_TextView *(^)(BOOL))cc_editable;
- (__kindof CC_TextView *(^)(BOOL))cc_selectable;
- (__kindof CC_TextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes;
- (__kindof CC_TextView *(^)(NSTextAlignment))cc_textAlignment;

@end

@interface CC_TextView (CCActions)

- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end

@interface CC_TextView (Deprecated)

- (CC_TextView *(^)(id<UITextViewDelegate>))cc_delegate;

- (CC_TextView *(^)(NSString *))cc_bindText;
- (CC_TextView *(^)(NSAttributedString *))cc_bindAttText;

- (CC_TextView *(^)(NSString *))cc_name;
- (CC_TextView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_TextView *(^)(CGFloat,CGFloat))cc_size;
- (CC_TextView *(^)(CGFloat))cc_width;
- (CC_TextView *(^)(CGFloat))cc_height;

- (CC_TextView *(^)(CGFloat,CGFloat))cc_center;
- (CC_TextView *(^)(CGFloat))cc_centerX;
- (CC_TextView *(^)(CGFloat))cc_centerY;
- (CC_TextView *(^)(CGFloat))cc_top;
- (CC_TextView *(^)(CGFloat))cc_bottom;
- (CC_TextView *(^)(CGFloat))cc_left;
- (CC_TextView *(^)(CGFloat))cc_right;
- (CC_TextView *(^)(UIColor *))cc_backgroundColor;
- (CC_TextView *(^)(CGFloat))cc_cornerRadius;
- (CC_TextView *(^)(CGFloat))cc_borderWidth;
- (CC_TextView *(^)(UIColor *))cc_borderColor;
- (CC_TextView *(^)(BOOL))cc_userInteractionEnabled;
- (CC_TextView *(^)(id))cc_addToView;

@end
