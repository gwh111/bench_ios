//
//  CC_TextField.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Lib+UITextField.h"

@interface CC_TextField : UITextField

#pragma mark clase "CC_TextField" property extention
// UIView property
- (CC_TextField *(^)(NSString *))cc_name;
- (CC_TextField *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_TextField *(^)(CGFloat,CGFloat))cc_size;
- (CC_TextField *(^)(CGFloat))cc_width;
- (CC_TextField *(^)(CGFloat))cc_height;

- (CC_TextField *(^)(CGFloat,CGFloat))cc_center;
- (CC_TextField *(^)(CGFloat))cc_centerX;
- (CC_TextField *(^)(CGFloat))cc_centerY;
- (CC_TextField *(^)(CGFloat))cc_top;
- (CC_TextField *(^)(CGFloat))cc_bottom;
- (CC_TextField *(^)(CGFloat))cc_left;
- (CC_TextField *(^)(CGFloat))cc_right;
- (CC_TextField *(^)(UIColor *))cc_backgroundColor;
- (CC_TextField *(^)(CGFloat))cc_cornerRadius;
- (CC_TextField *(^)(CGFloat))cc_borderWidth;
- (CC_TextField *(^)(UIColor *))cc_borderColor;
- (CC_TextField *(^)(BOOL))cc_userInteractionEnabled;
- (CC_TextField *(^)(id))cc_addToView;

// UITextField property
- (CC_TextField *(^)(NSString *))cc_text;
- (CC_TextField *(^)(NSAttributedString *))cc_attributedText;
- (CC_TextField *(^)(UIColor *))cc_textColor;
- (CC_TextField *(^)(UIFont *))cc_font;
- (CC_TextField *(^)(NSTextAlignment))cc_textAlignment;
- (CC_TextField *(^)(UITextBorderStyle))cc_borderStyle;
- (CC_TextField *(^)(NSString *))cc_placeholder;
- (CC_TextField *(^)(NSAttributedString *))cc_attributedPlaceholder;
- (CC_TextField *(^)(BOOL))cc_clearsOnBeginEditing;
- (CC_TextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth;
- (CC_TextField *(^)(UIImage *))cc_background;
- (CC_TextField *(^)(id<UITextFieldDelegate>))cc_delegate;

- (CC_TextField *(^)(NSString *))cc_bindText;
- (CC_TextField *(^)(NSAttributedString *))cc_bindAttText;

#pragma mark function
- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end
