//
//  AppButton.h
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Lib+UIButton.h"

@interface CC_Button : UIButton

#pragma mark clase "CC_Button" property extention
// UIView property
- (CC_Button *(^)(NSString *))cc_name;
- (CC_Button *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_Button *(^)(CGFloat,CGFloat))cc_size;
- (CC_Button *(^)(CGFloat))cc_width;
- (CC_Button *(^)(CGFloat))cc_height;

- (CC_Button *(^)(CGFloat,CGFloat))cc_center;
- (CC_Button *(^)(CGFloat))cc_centerX;
- (CC_Button *(^)(CGFloat))cc_centerY;
- (CC_Button *(^)(CGFloat))cc_top;
- (CC_Button *(^)(CGFloat))cc_bottom;
- (CC_Button *(^)(CGFloat))cc_left;
- (CC_Button *(^)(CGFloat))cc_right;
- (CC_Button *(^)(UIColor *))cc_backgroundColor;
- (CC_Button *(^)(CGFloat))cc_cornerRadius;
- (CC_Button *(^)(CGFloat))cc_borderWidth;
- (CC_Button *(^)(UIColor *))cc_borderColor;
- (CC_Button *(^)(BOOL))cc_userInteractionEnabled;
- (CC_Button *(^)(id))cc_addToView;

// UIButton property
- (CC_Button *(^)(NSString *, UIControlState))cc_setTitleForState;
- (CC_Button *(^)(UIColor *, UIControlState))cc_setTitleColorForState;
- (CC_Button *(^)(UIColor *, UIControlState))cc_setTitleShadowColorForState;
- (CC_Button *(^)(UIImage *, UIControlState))cc_setImageForState;
- (CC_Button *(^)(UIImage *, UIControlState))cc_setBackgroundImageForState;
- (CC_Button *(^)(NSAttributedString *, UIControlState))cc_setAttributedTitleForState;

- (CC_Button *(^)(UIFont *))cc_font;
- (CC_Button *(^)(UIColor *))cc_textColor;
- (CC_Button *(^)(NSString *, UIControlState))cc_bindText;
- (CC_Button *(^)(NSAttributedString *, UIControlState))cc_bindAttText;

#pragma mark function
- (void)bindText:(NSString *)text state:(UIControlState)state;
- (void)bindAttText:(NSAttributedString *)attText state:(UIControlState)state;

/** default button will enlarge tap frame
    默认会扩大按钮的点击范围 */
@property(nonatomic,assign) int forbiddenEnlargeTapFrame;

@end
