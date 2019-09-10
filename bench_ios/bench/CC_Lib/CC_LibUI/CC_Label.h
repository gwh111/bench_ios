//
//  CC_Label.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Lib+UILabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Label : UILabel 

#pragma mark clase "CC_Label" property extention
// UIView property
- (CC_Label *(^)(NSString *))cc_name;
- (CC_Label *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_Label *(^)(CGFloat,CGFloat))cc_size;
- (CC_Label *(^)(CGFloat))cc_width;
- (CC_Label *(^)(CGFloat))cc_height;

- (CC_Label *(^)(CGFloat,CGFloat))cc_center;
- (CC_Label *(^)(CGFloat))cc_centerX;
- (CC_Label *(^)(CGFloat))cc_centerY;
- (CC_Label *(^)(CGFloat))cc_top;
- (CC_Label *(^)(CGFloat))cc_bottom;
- (CC_Label *(^)(CGFloat))cc_left;
- (CC_Label *(^)(CGFloat))cc_right;
- (CC_Label *(^)(UIColor *))cc_backgroundColor;
- (CC_Label *(^)(CGFloat))cc_cornerRadius;
- (CC_Label *(^)(CGFloat))cc_borderWidth;
- (CC_Label *(^)(UIColor *))cc_borderColor;
- (CC_Label *(^)(BOOL))cc_userInteractionEnabled;
- (CC_Label *(^)(id))cc_addToView;

// UILabel property
- (CC_Label *(^)(NSString *))cc_text;
- (CC_Label *(^)(UIFont *))cc_font;
- (CC_Label *(^)(UIColor *))cc_textColor;
- (CC_Label *(^)(UIColor *))cc_shadowColor;
- (CC_Label *(^)(CGFloat, CGFloat))cc_shadowOffset;
- (CC_Label *(^)(NSTextAlignment))cc_textAlignment;
- (CC_Label *(^)(NSLineBreakMode))cc_lineBreakMode;
- (CC_Label *(^)(NSAttributedString *))cc_attributedText;
- (CC_Label *(^)(NSInteger))cc_numberOfLines;

- (CC_Label *(^)(NSString *))cc_bindText;
- (CC_Label *(^)(NSAttributedString *))cc_bindAttText;

#pragma mark function
- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end

NS_ASSUME_NONNULL_END
