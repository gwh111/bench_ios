//
//  UIScrollView+CCCat.h
//  bench_ios
//
//  Created by ml on 2019/6/3.
//  Copyright © 2019 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString const *CCFrameEndUserInfoKey;
UIKIT_EXTERN NSString const *CCAnimationDurationUserInfoKey;

@interface UIScrollView (CC_KdAdapter)

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
