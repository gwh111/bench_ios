//
//  CC_Notice.h
//  bench_ios
//
//  Created by gwh on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Notice : UIView

/**
 * 错误提示
 * noticeStr：提示信息
 */
+ (void)showNoticeStr:(NSString *)noticeStr;

+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay;

+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay atView:(UIView *)view;

@end
