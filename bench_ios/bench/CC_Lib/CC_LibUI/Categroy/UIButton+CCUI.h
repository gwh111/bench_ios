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

- (UIButton *(^)(UIControlState state,UIColor *color))cc_BtnBackgroundColor;
- (UIButton *(^)(UIControlState state,NSString *text))cc_BtnText;
- (UIButton *(^)(UIControlState state,UIColor *color))cc_BtnTextColor;
- (UIButton *(^)(UIControlState state,UIImage *image))cc_BtnImage;
- (UIButton *(^)(UIControlState state,UIImage *image))cc_BtnBackgroundImage;
- (UIButton *(^)(NSAttributedString *, UIControlState))cc_BtnAttributedTitle;


@end

NS_ASSUME_NONNULL_END
