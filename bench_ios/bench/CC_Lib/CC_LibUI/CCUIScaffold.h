//
//  CCUIScaffold.h
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_View,CC_Label,CC_ImageView,CC_Button,CC_ScrollView,CC_TextField,CC_TextView,CC_TableView,CC_CollectionView,CC_WebView;

/**
 链式辅助协议
 通用属性最终调用 UIView+CCUI
 特殊类型比如代理,交由对应类实现
 
 */
@protocol CC_View <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_View *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_View *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_View *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_View *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_View *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_View *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_View *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_View *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_View *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_View *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_View *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_View *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_View *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_View *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_View *(^)(CGFloat))cc_top;

/// 设置x值 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_View *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_View *(^)(CGFloat bottom))cc_bottom;


- (__kindof CC_View *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_View *(^)(CGFloat))cc_centerX;
- (__kindof CC_View *(^)(CGFloat))cc_centerY;
- (__kindof CC_View *(^)(void))cc_centerSuper;
- (__kindof CC_View *(^)(void))cc_centerXSuper;
- (__kindof CC_View *(^)(void))cc_centerYSuper;

@end

@protocol CC_Label <NSObject>

@optional
- (__kindof CC_Label *(^)(id))cc_addToView;
- (__kindof CC_Label *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_Label *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_Label *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_Label *(^)(UIColor *))cc_borderColor;
- (__kindof CC_Label *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_Label *(^)(BOOL))cc_hidden;
- (__kindof CC_Label *(^)(CGFloat))cc_alpha;
- (__kindof CC_Label *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_Label *(^)(void))cc_sizeToFit;
- (__kindof CC_Label *(^)(NSString *))cc_name;
- (__kindof CC_Label *(^)(CGFloat))cc_tag;
- (__kindof CC_Label *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_Label *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_Label *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_Label *(^)(CGFloat))cc_w;
- (__kindof CC_Label *(^)(CGFloat))cc_h;
- (__kindof CC_Label *(^)(CGFloat))cc_top;
- (__kindof CC_Label *(^)(CGFloat))cc_left;

- (__kindof CC_Label *(^)(CGFloat right))cc_right;
- (__kindof CC_Label *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_Label *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_Label *(^)(CGFloat))cc_centerX;
- (__kindof CC_Label *(^)(CGFloat))cc_centerY;
- (__kindof CC_Label *(^)(void))cc_centerSuper;
- (__kindof CC_Label *(^)(void))cc_centerXSuper;
- (__kindof CC_Label *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UILabel
///-------------------------------

- (__kindof CC_Label *(^)(NSString *))cc_text;
- (__kindof CC_Label *(^)(UIFont *))cc_font;
- (__kindof CC_Label *(^)(UIColor *))cc_textColor;
- (__kindof CC_Label *(^)(UIColor *))cc_shadowColor;
- (__kindof CC_Label *(^)(CGFloat, CGFloat))cc_shadowOffset;
- (__kindof CC_Label *(^)(NSTextAlignment))cc_textAlignment;
- (__kindof CC_Label *(^)(NSLineBreakMode))cc_lineBreakMode;
- (__kindof CC_Label *(^)(NSAttributedString *))cc_attributedText;
- (__kindof CC_Label *(^)(NSInteger))cc_numberOfLines;

@end


@protocol CC_ImageView <NSObject>

@optional
- (__kindof CC_ImageView *(^)(id))cc_addToView;
- (__kindof CC_ImageView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_ImageView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_ImageView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_ImageView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_ImageView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_ImageView *(^)(BOOL))cc_hidden;
- (__kindof CC_ImageView *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_ImageView *(^)(void))cc_sizeToFit;
- (__kindof CC_ImageView *(^)(CGFloat))cc_alpha;
- (__kindof CC_ImageView *(^)(NSString *))cc_name;
- (__kindof CC_ImageView *(^)(CGFloat))cc_tag;
- (__kindof CC_ImageView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_ImageView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_ImageView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_ImageView *(^)(CGFloat))cc_w;
- (__kindof CC_ImageView *(^)(CGFloat))cc_h;
- (__kindof CC_ImageView *(^)(CGFloat))cc_top;
- (__kindof CC_ImageView *(^)(CGFloat))cc_left;

- (__kindof CC_ImageView *(^)(CGFloat right))cc_right;
- (__kindof CC_ImageView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_ImageView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_ImageView *(^)(CGFloat))cc_centerX;
- (__kindof CC_ImageView *(^)(CGFloat))cc_centerY;
- (__kindof CC_ImageView *(^)(void))cc_centerSuper;
- (__kindof CC_ImageView *(^)(void))cc_centerXSuper;
- (__kindof CC_ImageView *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UIImageView
///-------------------------------

/// The image displayed in the image view.
- (__kindof CC_ImageView *(^)(UIImage *))cc_image;

/// The highlighted image displayed in the image view
- (__kindof CC_ImageView *(^)(UIImage *))cc_highlightedImage;

/// A Boolean value that determines whether the image is highlighted.
- (__kindof CC_ImageView *(^)(BOOL))cc_highlighted;

/// An array of UIImage objects to use for an animation.
- (__kindof CC_ImageView *(^)(NSArray *))cc_animationImages;

/// An array of UIImage objects to use for an animation when the view is highlighted.
- (__kindof CC_ImageView *(^)(NSArray *))cc_highlightedAnimationImages;

/// for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
- (__kindof CC_ImageView *(^)(NSTimeInterval))cc_animationDuration;

/// 0 means infinite (default is 0)
- (__kindof CC_ImageView *(^)(NSInteger))cc_animationRepeatCount;

@end

@protocol CC_Button <NSObject>

@optional
- (__kindof CC_Button *(^)(id))cc_addToView;
- (__kindof CC_Button *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_Button *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_Button *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_Button *(^)(UIColor *))cc_borderColor;
- (__kindof CC_Button *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_Button *(^)(BOOL))cc_hidden;
- (__kindof CC_Button *(^)(CGFloat))cc_alpha;
- (__kindof CC_Button *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_Button *(^)(void))cc_sizeToFit;
- (__kindof CC_Button *(^)(NSString *))cc_name;
- (__kindof CC_Button *(^)(CGFloat))cc_tag;
- (__kindof CC_Button *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_Button *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_Button *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_Button *(^)(CGFloat))cc_w;
- (__kindof CC_Button *(^)(CGFloat))cc_h;
- (__kindof CC_Button *(^)(CGFloat))cc_top;
- (__kindof CC_Button *(^)(CGFloat))cc_left;

- (__kindof CC_Button *(^)(CGFloat right))cc_right;
- (__kindof CC_Button *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_Button *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_Button *(^)(CGFloat))cc_centerX;
- (__kindof CC_Button *(^)(CGFloat))cc_centerY;
- (__kindof CC_Button *(^)(void))cc_centerSuper;
- (__kindof CC_Button *(^)(void))cc_centerXSuper;
- (__kindof CC_Button *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UIButton
///-------------------------------

- (__kindof CC_Button *(^)(UIFont  *))cc_font;
- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setBackgroundColorForState;
- (__kindof CC_Button *(^)(NSString *text,UIControlState state))cc_setTitleForState;
- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setTitleColorForState;
- (__kindof CC_Button *(^)(UIImage *image,UIControlState state))cc_setImageForState;
- (__kindof CC_Button *(^)(UIImage *image,UIControlState state))cc_setBackgroundImageForState;
- (__kindof CC_Button *(^)(NSAttributedString *attributed,UIControlState state))cc_setAttributedTitleForState;
- (__kindof CC_Button *(^)(UIColor *color,UIControlState state))cc_setTitleShadowColorForState;

// MARK: - Title
- (__kindof CC_Button *(^)(NSString *))cc_setNormalTitle;
- (__kindof CC_Button *(^)(NSString *))cc_setHighlightedTitle;
- (__kindof CC_Button *(^)(NSString *))cc_setDisabledTitle;
- (__kindof CC_Button *(^)(NSString *))cc_setSelectedTitle;

// MARK: - Title Color
- (__kindof CC_Button *(^)(UIColor *))cc_setNormalTitleColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setHighlightedTitleColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setDisabledTitleColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setSelectedTitleColor;

// MARK: - Image
- (__kindof CC_Button *(^)(UIImage *))cc_setNormalImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setHighlightedImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setDisabledImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setSelectedImage;

// MARK: - BackgroundImage
- (__kindof CC_Button *(^)(UIImage *))cc_setNormalBackgroundImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setHighlightedBackgroundImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setDisabledBackgroundImage;
- (__kindof CC_Button *(^)(UIImage *))cc_setSelectedBackgroundImage;

// MARK: - BackgroundColor
- (__kindof CC_Button *(^)(UIColor *))cc_setNormalBackgroundColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setHighlightedBackgroundColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setDisabledBackgroundColor;
- (__kindof CC_Button *(^)(UIColor *))cc_setSelectedBackgroundColor;

// MARK: - AttributedTitle
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setNormalAttributedTitle;
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setHighlightedAttributedTitle;
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setDisabledAttributedTitle;
- (__kindof CC_Button *(^)(NSAttributedString *))cc_setSelectedAttributedTitle;

@end

@protocol CC_TextField <NSObject>

@optional
- (__kindof CC_TextField *(^)(id))cc_addToView;
- (__kindof CC_TextField *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TextField *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TextField *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TextField *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TextField *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TextField *(^)(BOOL))cc_hidden;
- (__kindof CC_TextField *(^)(CGFloat))cc_alpha;
- (__kindof CC_TextField *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_TextField *(^)(void))cc_sizeToFit;
- (__kindof CC_TextField *(^)(NSString *))cc_name;
- (__kindof CC_TextField *(^)(CGFloat))cc_tag;
- (__kindof CC_TextField *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_TextField *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_TextField *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_TextField *(^)(CGFloat))cc_w;
- (__kindof CC_TextField *(^)(CGFloat))cc_h;
- (__kindof CC_TextField *(^)(CGFloat))cc_top;
- (__kindof CC_TextField *(^)(CGFloat))cc_left;

- (__kindof CC_TextField *(^)(CGFloat right))cc_right;
- (__kindof CC_TextField *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_TextField *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_TextField *(^)(CGFloat))cc_centerX;
- (__kindof CC_TextField *(^)(CGFloat))cc_centerY;
- (__kindof CC_TextField *(^)(void))cc_centerSuper;
- (__kindof CC_TextField *(^)(void))cc_centerXSuper;
- (__kindof CC_TextField *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UITextField
///-------------------------------

- (__kindof CC_TextField *(^)(NSString *))cc_text;
- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedText;
- (__kindof CC_TextField *(^)(UIColor *))cc_textColor;
- (__kindof CC_TextField *(^)(UIFont *))cc_font;
- (__kindof CC_TextField *(^)(NSTextAlignment))cc_textAlignment;
- (__kindof CC_TextField *(^)(UITextBorderStyle))cc_borderStyle;
- (__kindof CC_TextField *(^)(NSString *))cc_placeholder;
- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedPlaceholder;
- (__kindof CC_TextField *(^)(BOOL))cc_clearsOnBeginEditing;
- (__kindof CC_TextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth;
- (__kindof CC_TextField *(^)(UIImage *))cc_background;

- (__kindof CC_TextField *(^)(id<UITextFieldDelegate>))cc_delegate;

/// default is NO. allows editing text attributes with style operations and pasting rich text
- (__kindof CC_TextField *(^)(BOOL))cc_allowsEditingTextAttributes;

/// sets when the clear button shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_clearButtonMode;

/// e.g. magnifying glass
- (__kindof CC_TextField *(^)(UIView *))cc_leftView;

/// sets when the left view shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_leftViewMode;

/// e.g. bookmarks button
- (__kindof CC_TextField *(^)(UIView *))cc_rightView;

/// sets when the right view shows up. default is UITextFieldViewModeNever
- (__kindof CC_TextField *(^)(UITextFieldViewMode))cc_rightViewMode;

@end

@protocol CC_TextView <NSObject>

@optional
- (__kindof CC_TextView *(^)(id))cc_addToView;
- (__kindof CC_TextView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TextView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TextView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TextView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TextView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TextView *(^)(BOOL))cc_hidden;
- (__kindof CC_TextView *(^)(CGFloat))cc_alpha;
- (__kindof CC_TextView *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_TextView *(^)(void))cc_sizeToFit;
- (__kindof CC_TextView *(^)(NSString *))cc_name;
- (__kindof CC_TextView *(^)(CGFloat))cc_tag;
- (__kindof CC_TextView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_TextView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_TextView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_TextView *(^)(CGFloat))cc_w;
- (__kindof CC_TextView *(^)(CGFloat))cc_h;
- (__kindof CC_TextView *(^)(CGFloat))cc_top;
- (__kindof CC_TextView *(^)(CGFloat))cc_left;

- (__kindof CC_TextView *(^)(CGFloat right))cc_right;
- (__kindof CC_TextView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_TextView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_TextView *(^)(CGFloat))cc_centerX;
- (__kindof CC_TextView *(^)(CGFloat))cc_centerY;
- (__kindof CC_TextView *(^)(void))cc_centerSuper;
- (__kindof CC_TextView *(^)(void))cc_centerXSuper;
- (__kindof CC_TextView *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UITextView
///-------------------------------
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

@protocol CC_ScrollView <NSObject>

@optional
- (__kindof CC_ScrollView *(^)(id))cc_addToView;
- (__kindof CC_ScrollView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_ScrollView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_ScrollView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_ScrollView *(^)(BOOL))cc_hidden;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_alpha;
- (__kindof CC_ScrollView *(^)(NSString *))cc_name;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_tag;
- (__kindof CC_ScrollView *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_ScrollView *(^)(void))cc_sizeToFit;
- (__kindof CC_ScrollView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_ScrollView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_ScrollView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_w;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_h;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_top;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_left;

- (__kindof CC_ScrollView *(^)(CGFloat right))cc_right;
- (__kindof CC_ScrollView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_ScrollView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_centerX;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_centerY;
- (__kindof CC_ScrollView *(^)(void))cc_centerSuper;
- (__kindof CC_ScrollView *(^)(void))cc_centerXSuper;
- (__kindof CC_ScrollView *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name UITextView
///-------------------------------

/// The point at which the origin of the content view is offset from the origin of the scroll view.
- (__kindof CC_ScrollView *(^)(CGPoint))cc_contentOffset;

/// The size of the content view.
- (__kindof CC_ScrollView *(^)(CGSize))cc_contentSize;

/// default NO. if YES, try to lock vertical or horizontal scrolling while dragging
- (__kindof CC_ScrollView *(^)(BOOL))cc_directionalLockEnabled;

/// default YES. if YES, bounces past edge of content and back again
- (__kindof CC_ScrollView *(^)(BOOL))cc_bounces;

/// default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
- (__kindof CC_ScrollView *(^)(BOOL))cc_alwaysBounceVertical;

/// default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally
- (__kindof CC_ScrollView *(^)(BOOL))cc_alwaysBounceHorizontal;

/// default NO. if YES, stop on multiples of view bounds
- (__kindof CC_ScrollView *(^)(BOOL))cc_pagingEnabled;

/// default YES. turn off any dragging temporarily
- (__kindof CC_ScrollView *(^)(BOOL))cc_scrollEnabled;

/// default YES. show indicator while we are tracking. fades out after tracking
- (__kindof CC_ScrollView *(^)(BOOL))cc_showsHorizontalScrollIndicator;

/// default YES. show indicator while we are tracking. fades out after tracking
- (__kindof CC_ScrollView *(^)(BOOL))cc_showsVerticalScrollIndicator;

/// A floating-point value that determines the rate of deceleration after the user lifts their finger.
- (__kindof CC_ScrollView *(^)(UIScrollViewDecelerationRate))cc_decelerationRate;

/// default is YES. if NO, we immediately call
- (__kindof CC_ScrollView *(^)(BOOL))cc_delaysContentTouches;

/// default is YES. if NO, then once we start tracking, we don't try to drag if the touch moves. this has no effect on presses
- (__kindof CC_ScrollView *(^)(BOOL))cc_canCancelContentTouches;

@end

@protocol CC_TableView <NSObject>

@optional
- (__kindof CC_TableView *(^)(id))cc_addToView;
- (__kindof CC_TableView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TableView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TableView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TableView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TableView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TableView *(^)(BOOL))cc_hidden;
- (__kindof CC_TableView *(^)(CGFloat))cc_alpha;
- (__kindof CC_TableView *(^)(NSString *))cc_name;
- (__kindof CC_TableView *(^)(CGFloat))cc_tag;
- (__kindof CC_TableView *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_TableView *(^)(void))cc_sizeToFit;
- (__kindof CC_TableView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_TableView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_TableView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_TableView *(^)(CGFloat))cc_w;
- (__kindof CC_TableView *(^)(CGFloat))cc_h;
- (__kindof CC_TableView *(^)(CGFloat))cc_top;
- (__kindof CC_TableView *(^)(CGFloat))cc_left;

- (__kindof CC_TableView *(^)(CGFloat right))cc_right;
- (__kindof CC_TableView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_TableView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_TableView *(^)(CGFloat))cc_centerX;
- (__kindof CC_TableView *(^)(CGFloat))cc_centerY;
- (__kindof CC_TableView *(^)(void))cc_centerSuper;
- (__kindof CC_TableView *(^)(void))cc_centerXSuper;
- (__kindof CC_TableView *(^)(void))cc_centerYSuper;

- (__kindof CC_TableView *(^)(CGPoint))cc_contentOffset;
- (__kindof CC_TableView *(^)(CGSize))cc_contentSize;

@end

@protocol CC_CollectionView <NSObject>

@optional
- (__kindof CC_CollectionView *(^)(id))cc_addToView;
- (__kindof CC_CollectionView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_CollectionView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_CollectionView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_CollectionView *(^)(BOOL))cc_hidden;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_alpha;
- (__kindof CC_CollectionView *(^)(NSString *))cc_name;
- (__kindof CC_CollectionView *(^)(BOOL))cc_clipsToBounds;
- (__kindof CC_CollectionView *(^)(void))cc_sizeToFit;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_tag;
- (__kindof CC_CollectionView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_CollectionView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_CollectionView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_w;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_h;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_top;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_left;

- (__kindof CC_CollectionView *(^)(CGFloat right))cc_right;
- (__kindof CC_CollectionView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_CollectionView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_centerX;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_centerY;
- (__kindof CC_CollectionView *(^)(void))cc_centerSuper;
- (__kindof CC_CollectionView *(^)(void))cc_centerXSuper;
- (__kindof CC_CollectionView *(^)(void))cc_centerYSuper;

- (__kindof CC_CollectionView *(^)(CGPoint))cc_contentOffset;
- (__kindof CC_CollectionView *(^)(CGSize))cc_contentSize;

@end

@protocol CC_WebView <NSObject>

@optional
- (__kindof CC_WebView *(^)(id))cc_addToView;
- (__kindof CC_WebView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_WebView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_WebView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_WebView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_WebView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_WebView *(^)(BOOL))cc_hidden;
- (__kindof CC_WebView *(^)(CGFloat))cc_alpha;
- (__kindof CC_WebView *(^)(NSString *))cc_name;
- (__kindof CC_WebView *(^)(CGFloat))cc_tag;
- (__kindof CC_WebView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof CC_WebView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof CC_WebView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof CC_WebView *(^)(CGFloat))cc_w;
- (__kindof CC_WebView *(^)(CGFloat))cc_h;
- (__kindof CC_WebView *(^)(CGFloat))cc_top;
- (__kindof CC_WebView *(^)(CGFloat))cc_left;

- (__kindof CC_WebView *(^)(CGFloat right))cc_right;
- (__kindof CC_WebView *(^)(CGFloat bottom))cc_bottom;
- (__kindof CC_WebView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof CC_WebView *(^)(CGFloat))cc_centerX;
- (__kindof CC_WebView *(^)(CGFloat))cc_centerY;
- (__kindof CC_WebView *(^)(void))cc_centerSuper;
- (__kindof CC_WebView *(^)(void))cc_centerXSuper;
- (__kindof CC_WebView *(^)(void))cc_centerYSuper;

@end

NS_ASSUME_NONNULL_END
