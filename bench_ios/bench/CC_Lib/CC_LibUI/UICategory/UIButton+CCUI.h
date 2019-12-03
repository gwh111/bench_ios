//
//  UIButton+CCUI.h
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_Button;

@interface UIButton (CCUI)

// MARK: - Title

/// Sets the title to use for the normal state.
- (UIButton *(^)(NSString *))cc_setNormalTitle;

/// Sets the title to use for the Highlighted state.
- (UIButton *(^)(NSString *))cc_setHighlightedTitle;

/// Sets the title to use for the Disabled state.
- (UIButton *(^)(NSString *))cc_setDisabledTitle;

/// Sets the title to use for the Selected state.
- (UIButton *(^)(NSString *))cc_setSelectedTitle;

// MARK: - Title Color

/// Sets the title color to use for the normal state.
- (UIButton *(^)(UIColor *))cc_setNormalTitleColor;

/// Sets the title color to use for the Highlighted state.
- (UIButton *(^)(UIColor *))cc_setHighlightedTitleColor;

/// Sets the title color to use for the Disabled state.
- (UIButton *(^)(UIColor *))cc_setDisabledTitleColor;

/// Sets the title color to use for the Selected state.
- (UIButton *(^)(UIColor *))cc_setSelectedTitleColor;

// MARK: - Image

/// Sets the image to use for the normal state.
- (UIButton *(^)(UIImage *))cc_setNormalImage;

/// Sets the image to use for the Highlighted state.
- (UIButton *(^)(UIImage *))cc_setHighlightedImage;

/// Sets the image to use for the Disabled state.
- (UIButton *(^)(UIImage *))cc_setDisabledImage;

/// Sets the image to use for the Selected state.
- (UIButton *(^)(UIImage *))cc_setSelectedImage;

// MARK: - BackgroundImage

/// Sets the background image to use for the normal button state.
- (UIButton *(^)(UIImage *))cc_setNormalBackgroundImage;

/// Sets the background image to use for the Highlighted button state.
- (UIButton *(^)(UIImage *))cc_setHighlightedBackgroundImage;

/// Sets the background image to use for the Disabled button state.
- (UIButton *(^)(UIImage *))cc_setDisabledBackgroundImage;

/// Sets the background image to use for the Selected button state.
- (UIButton *(^)(UIImage *))cc_setSelectedBackgroundImage;

// MARK: - BackgroundColor

/// Sets the backgroundColor to use for the normal state
- (UIButton *(^)(UIColor *))cc_setNormalBackgroundColor;

/// Sets the backgroundColor to use for the Highlighted state
- (UIButton *(^)(UIColor *))cc_setHighlightedBackgroundColor;

/// Sets the backgroundColor to use for the Disabled state
- (UIButton *(^)(UIColor *))cc_setDisabledBackgroundColor;

/// Sets the backgroundColor to use for the Selected state
- (UIButton *(^)(UIColor *))cc_setSelectedBackgroundColor;

// MARK: - AttributedTitle

/// Sets the styled title to use for the normal state.
- (UIButton *(^)(NSAttributedString *))cc_setNormalAttributedTitle;

/// Sets the styled title to use for the Highlighted state.
- (UIButton *(^)(NSAttributedString *))cc_setHighlightedAttributedTitle;

/// Sets the styled title to use for the Disabled state.
- (UIButton *(^)(NSAttributedString *))cc_setDisabledAttributedTitle;

/// Sets the styled title to use for the Selected state.
- (UIButton *(^)(NSAttributedString *))cc_setSelectedAttributedTitle;

- (UIButton *(^)(UIFont  *))cc_font;

/// Sets the title to use for the specified state.
- (UIButton *(^)(NSString *text,UIControlState state))cc_setTitleForState;

/// Sets the color of the title to use for the specified state.
- (UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleColorForState;

/// Sets the color of the title shadow to use for the specified state.
- (UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleShadowColorForState;

/// Sets the image to use for the specified
- (UIButton *(^)(UIImage *image,UIControlState state))cc_setImageForState;

/// Sets the background image to use for the specified button state.
- (UIButton *(^)(UIImage *image,UIControlState state))cc_setBackgroundImageForState;

/// Sets the styled title to use for the specified state.
- (UIButton *(^)(NSAttributedString *attributed,UIControlState state))cc_setAttributedTitleForState;

/// Sets the backgroundColor to use for the specified state
- (UIButton *(^)(UIColor *color,UIControlState state))cc_setBackgroundColorForState;

@end

@interface UIButton (CCDeprecated)

- (void)cc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state DEPRECATED_MSG_ATTRIBUTE("Using cc_setBackgroundColorForState instead");

@end

// MARK: - UIButton属性链式协议 -

@protocol CC_ButtonChainExtProtocol <NSObject>

/// 设置字体
- (__kindof CC_Button *(^)(UIFont  *))cc_font;

/// 设置正常状态的标题 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(NSString *))cc_setNormalTitle;

/// 设置高亮状态的标题
- (__kindof CC_Button *(^)(NSString *))cc_setHighlightedTitle;

/// 设置不可用状态的标题
- (__kindof CC_Button *(^)(NSString *))cc_setDisabledTitle;

/// 设置选中状态的标题
- (__kindof CC_Button *(^)(NSString *))cc_setSelectedTitle;

/// 设置正常状态的标题前景色
- (__kindof CC_Button *(^)(UIColor *))cc_setNormalTitleColor;

/// 设置高亮状态的标题前景色
- (__kindof CC_Button *(^)(UIColor *))cc_setHighlightedTitleColor;

/// 设置不可用状态的标题前景色
- (__kindof CC_Button *(^)(UIColor *))cc_setDisabledTitleColor;

/// 设置选中状态的标题前景色 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIColor *))cc_setSelectedTitleColor;

/// 设置正常状态的图片 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIImage *))cc_setNormalImage;

/// 设置高亮状态的图片
- (__kindof CC_Button *(^)(UIImage *))cc_setHighlightedImage;

/// 设置不可用状态的图片
- (__kindof CC_Button *(^)(UIImage *))cc_setDisabledImage;

/// 设置被选中状态的图片
- (__kindof CC_Button *(^)(UIImage *))cc_setSelectedImage;

/// 设置正常状态的背景图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(UIImage *))cc_setNormalBackgroundImage;

/// 设置高亮状态的背景图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(UIImage *))cc_setHighlightedBackgroundImage;

/// 设置不可用状态的背景图 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIImage *))cc_setDisabledBackgroundImage;

/// 设置被选中状态的背景图 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIImage *))cc_setSelectedBackgroundImage;

/// 设置正常状态的背景色 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIColor *))cc_setNormalBackgroundColor;

/// 设置高亮状态的背景色 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIColor *))cc_setHighlightedBackgroundColor;

/// 设置不可用状态的背景色 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIColor *))cc_setDisabledBackgroundColor;

/// 设置被选中状态的背景色 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(UIColor *))cc_setSelectedBackgroundColor;
 
/// 设置正常状态的富文本 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setNormalAttributedTitle;

/// 设置高亮状态的富文本 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setHighlightedAttributedTitle;

/// 设置不可用状态的富文本 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setDisabledAttributedTitle;

/// 设置被选中状态的富文本 [ctrl + ⌘ + ↑] 到.m查看实现
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setSelectedAttributedTitle;

- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setBackgroundColorForState;
- (__kindof CC_Button *(^)(NSString *text,UIControlState state))cc_setTitleForState;
- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setTitleColorForState;
- (__kindof CC_Button *(^)(UIImage *image,UIControlState state))cc_setImageForState;
- (__kindof CC_Button *(^)(UIImage *image,UIControlState state))cc_setBackgroundImageForState;
- (__kindof CC_Button *(^)(NSAttributedString *attributed,UIControlState state))cc_setAttributedTitleForState;
- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setTitleShadowColorForState;


@end

NS_ASSUME_NONNULL_END
