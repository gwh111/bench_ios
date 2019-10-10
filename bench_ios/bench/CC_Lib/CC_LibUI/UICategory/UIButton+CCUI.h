//
//  UIButton+CCUI.h
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CCUI)

/// Sets the title to use for the specified state.
- (__kindof UIButton *(^)(NSString *text,UIControlState state))cc_setTitleForState;

/// Sets the color of the title to use for the specified state.
- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleColorForState;

/// Sets the color of the title shadow to use for the specified state.
- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleShadowColorForState;

/// Sets the image to use for the specified
- (__kindof UIButton *(^)(UIImage *image,UIControlState state))cc_setImageForState;

/// Sets the background image to use for the specified button state.
- (__kindof UIButton *(^)(UIImage *image,UIControlState state))cc_setBackgroundImageForState;

/// Sets the styled title to use for the specified state.
- (__kindof UIButton *(^)(NSAttributedString *attributed,UIControlState state))cc_setAttributedTitleForState;

/// Sets the backgroundColor to use for the specified state
- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setBackgroundColorForState;

- (__kindof UIButton *(^)(UIFont  *))cc_font;

@end

@interface UIButton (CCDeprecated)

- (void)cc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state DEPRECATED_MSG_ATTRIBUTE("Using cc_setBackgroundColorForState instead");

@end

NS_ASSUME_NONNULL_END
