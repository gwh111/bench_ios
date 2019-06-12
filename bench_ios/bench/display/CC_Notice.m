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

static CC_Notice *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_Notice alloc] init];
    });
    return instance;
}

+ (void)show:(NSString *)noticeStr{
    [self showNoticeStr:noticeStr atView:nil delay:0];
}

+ (void)show:(NSString *)noticeStr atView:(UIView *)view{
    [self showNoticeStr:noticeStr atView:view delay:0];
}

+ (void)showNoticeStr:(NSString *)noticeStr{
    [self showNoticeStr:noticeStr atView:nil delay:0];
}

+ (void)showNoticeStr:(NSString *)noticeStr atView:(UIView *)view{
    [self showNoticeStr:noticeStr atView:view delay:0];
}

+ (void)showNoticeStr:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay{
 
    UIView *showV;
    if (view) {
        showV=view;
    }else{
        showV=[CC_Code getAView];
    }
    
    CC_Label *label=[[CC_Label alloc]init];
    label.text=noticeStr;
    label.numberOfLines=0;
    label.lineBreakMode=NSLineBreakByWordWrapping;
    label.font=[UIFont systemFontOfSize:14];
    [label setTextColor:COLOR_WHITE];
    [label setBackgroundColor:ccRGBA(0, 0, 0, .8)];
    label.textAlignment=NSTextAlignmentCenter;
    [showV addSubview:label];
    
    label.width=CC_SCREEN_WIDTH-[ccui getRH:40];
    [label sizeToFit];
    label.bottom=CC_SCREEN_HEIGHT/2+[CC_Notice getInstance].yOffset;
    label.left=CC_SCREEN_WIDTH/2-label.width/2;
    
    //adjust
    label.width=label.width+[ccui getRH:20];
    label.left=label.left-[ccui getRH:10];
    label.height=label.height+[ccui getRH:20];
    
    if (delay==0) {
        if (noticeStr.length<10) {
            delay=3;
        }else if (noticeStr.length<30){
            delay=3+(noticeStr.length-10)*0.2;
        }else{
            delay=7;
        }
    }
    
    [ccs delay:delay block:^{
        [UIView animateWithDuration:.5f animations:^{
            label.alpha=0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
