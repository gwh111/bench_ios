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
 * CC_Notice同一时间可以有多个 覆盖弹出
 * 会一个个往下移使用CC_Note
 * 错误提示
 * noticeStr：提示信息
 */
+ (void)showNoticeStr:(NSString *)noticeStr;

+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay;

@end
