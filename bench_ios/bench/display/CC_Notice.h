//
//  CC_Notice.h
//  bench_ios
//
//  Created by gwh on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Notice : UIView

@property (nonatomic,assign) float yOffset;

+ (instancetype)getInstance;

/**
 *  自动根据noticeStr长度调整消失时间
 */
+ (void)show:(NSString *)noticeStr;
/**
 *  自动根据noticeStr长度调整消失时间
 */
+ (void)show:(NSString *)noticeStr atView:(UIView *)view;


/**
 * CC_Notice同一时间可以有多个 覆盖弹出
 * 会一个个往下移使用CC_Note
 * 错误提示
 * noticeStr：提示信息
 */
+ (void)showNoticeStr:(NSString *)noticeStr;

/**
 *  有键盘的页面获取window会被释放 传入view
    delay 延时
 */
+ (void)showNoticeStr:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay;

/**
 *  当delay==0时自动根据noticeStr长度调整消失时间
 */
+ (void)showNoticeStr:(NSString *)noticeStr atView:(UIView *)view;

@end
