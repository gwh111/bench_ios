//
//  UIScrollView+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (CCUI)

/// The point at which the origin of the content view is offset from the origin of the scroll view.
- (__kindof UIScrollView *(^)(CGPoint))cc_contentOffset;

/// The size of the content view.
- (__kindof UIScrollView *(^)(CGSize))cc_contentSize;

/// default NO. if YES, try to lock vertical or horizontal scrolling while dragging
- (__kindof UIScrollView *(^)(BOOL))cc_directionalLockEnabled;

/// default YES. if YES, bounces past edge of content and back again
- (__kindof UIScrollView *(^)(BOOL))cc_bounces;

/// default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
- (__kindof UIScrollView *(^)(BOOL))cc_alwaysBounceVertical;

/// default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally
- (__kindof UIScrollView *(^)(BOOL))cc_alwaysBounceHorizontal;

/// default NO. if YES, stop on multiples of view bounds
- (__kindof UIScrollView *(^)(BOOL))cc_pagingEnabled;

/// default YES. turn off any dragging temporarily
- (__kindof UIScrollView *(^)(BOOL))cc_scrollEnabled;

/// default YES. show indicator while we are tracking. fades out after tracking
- (__kindof UIScrollView *(^)(BOOL))cc_showsHorizontalScrollIndicator;

/// default YES. show indicator while we are tracking. fades out after tracking
- (__kindof UIScrollView *(^)(BOOL))cc_showsVerticalScrollIndicator;

/// A floating-point value that determines the rate of deceleration after the user lifts their finger.
- (__kindof UIScrollView *(^)(UIScrollViewDecelerationRate))cc_decelerationRate;

/// default is YES. if NO, we immediately call
- (__kindof UIScrollView *(^)(BOOL))cc_delaysContentTouches;

/// default is YES. if NO, then once we start tracking, we don't try to drag if the touch moves. this has no effect on presses
- (__kindof UIScrollView *(^)(BOOL))cc_canCancelContentTouches;

@end

UIKIT_EXTERN NSString const *CCFrameEndUserInfoKey;
UIKIT_EXTERN NSString const *CCAnimationDurationUserInfoKey;

@interface UIScrollView (CCActions)

///-------------------------------
/// @name Keybord Adapter
///-------------------------------

/**
 UIScrollView包含UITextField时,弹出系统键盘时自动上移
 
 @param offset 偏移量增量
 @note
 使用方式:
 [scrollView cc_kdAdapterWithOffset:CGPointMake(0, 20)]
 若键盘存在辅助视图时,可通过offset自定义调整偏移量
 
 @warning
 通过keyboardDismissMode方式退下键盘会提示一个警告
 -[UIWindow endDisablingInterfaceAutorotationAnimated:] called on <UITextEffectsWindow: 0x144048400; ... matching -beginDisablingInterfaceAutorotation. Ignoring.
 可通过成为UIScrollView代理,在代理方法中关闭键盘的方式解决该警告
 
 http://d.net:8090/pages/viewpage.action?pageId=29298675
 */
- (void)cc_kdAdapterWithOffset:(CGPoint)offset;

/**
 通知的格式
 notification.userInfo {
 CCFrameEndUserInfoKey:"NSRect: {{0, 510}, {414, 226}}"
 CCAnimationDurationUserInfoKey:0.25
 }
 
 字典的结构
 @{
    @"弹窗即将出现的通知字符串":@"弹窗即将消失的通知字符串"
 }
 
 @param notifications 通知名数组
 */
- (void)cc_kdAddNotifications:(NSDictionary *)notifications;

/**
 移除通知
 */
- (void)cc_removeKdAdapter;

@end

NS_ASSUME_NONNULL_END
