//
//  CC_Notice.m
//  bench_ios
//
//  Created by gwh on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Notice.h"
#import "CC_Share.h"

@implementation CC_Notice

+ (void)showNoticeStr:(NSString *)noticeStr{
    [self showNoticeStr:noticeStr delay:3];
}

+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay{
 
    UIView *showV=[CC_Code getAView];
    
    CC_Label *label=[[CC_Label alloc]init];
    label.text=noticeStr;
    label.numberOfLines=0;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.font=[UIFont systemFontOfSize:14];
    [label setTextColor:COLOR_WHITE];
    [label setBackgroundColor:ccRGBA(0, 0, 0, .8)];
    label.textAlignment=NSTextAlignmentCenter;
    [showV addSubview:label];
    
    label.width=CC_SCREEN_WIDTH;
    [label sizeToFit];
    label.top=CC_SCREEN_HEIGHT/3;
    label.left=CC_SCREEN_WIDTH/2-label.width/2;
    
    [ccs delay:delay block:^{
        [UIView animateWithDuration:.5f animations:^{
            label.alpha=0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
