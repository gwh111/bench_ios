//
//  CC_Notice.h
//  bench_ios
//
//  Created by gwh on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Label.h"

@interface CC_Notice : UIView

@property (nonatomic,assign) float cc_yOffset;

+ (instancetype)shared;

// 自动根据noticeStr长度调整消失时间
- (CC_Label *)showNotice:(NSString *)noticeStr;
// 有键盘的页面获取window会被释放 传入view
- (CC_Label *)showNotice:(NSString *)noticeStr atView:(UIView *)view;
// 自己控制延时
- (CC_Label *)showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay;

@end
