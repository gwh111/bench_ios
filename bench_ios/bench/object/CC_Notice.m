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
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *noticV=[[UIView alloc]init];
    noticV.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    [window addSubview:noticV];
    
    CC_Label *label=[CC_Label createWithFrame:CGRectMake(0, 0, 0, 0) andTitleString:noticeStr andAttributedString:nil andTitleColor:[UIColor whiteColor] andBackGroundColor:[UIColor clearColor] andFont:[UIFont systemFontOfSize:14] andTextAlignment:NSTextAlignmentCenter atView:noticV];
    
    float sw=[UIScreen mainScreen].bounds.size.width;
    float sh=[UIScreen mainScreen].bounds.size.height;
    
    [label sizeToFit];
    if (label.width>sw) {
        label.numberOfLines=0;
        int n=label.width/sw+1;
        label.height=label.height*n;
        label.width=sw;
    }
    
    noticV.left=sw/2-label.width/2-10;
    noticV.top=sh/2;
    noticV.width=label.width+20;
    noticV.height=label.height+10;
    
    label.left=10;
    label.top=5;
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:.5f animations:^{
            label.alpha=0;
            noticV.alpha=0;
        } completion:^(BOOL finished) {
            [noticV removeFromSuperview];
            [label removeFromSuperview];
        }];
        
    });
}

+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    UIView *noticV=[[UIView alloc]init];
    noticV.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    [window addSubview:noticV];
    
    CC_Label *label=[CC_Label createWithFrame:CGRectMake(0, 0, 0, 0) andTitleString:noticeStr andAttributedString:nil andTitleColor:[UIColor whiteColor] andBackGroundColor:[UIColor clearColor] andFont:[UIFont systemFontOfSize:14] andTextAlignment:NSTextAlignmentCenter atView:noticV];
    
    float sw=[UIScreen mainScreen].bounds.size.width;
    float sh=[UIScreen mainScreen].bounds.size.height;
    
    [label sizeToFit];
    if (label.width>sw) {
        label.numberOfLines=0;
        int n=label.width/sw+1;
        label.height=label.height*n;
        label.width=sw;
    }
    
    noticV.left=sw/2-label.width/2-10;
    noticV.top=sh/2;
    noticV.width=label.width+20;
    noticV.height=label.height+10;
    
    label.left=10;
    label.top=5;
    
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:.5f animations:^{
            label.alpha=0;
            noticV.alpha=0;
        } completion:^(BOOL finished) {
            [noticV removeFromSuperview];
            [label removeFromSuperview];
        }];
        
    });
}


+ (void)showNoticeStr:(NSString *)noticeStr delay:(int)delay atView:(UIView *)view{
    
    UIView *noticV=[[UIView alloc]init];
    noticV.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    [view addSubview:noticV];
    
    CC_Label *label=[CC_Label createWithFrame:CGRectMake(0, 0, 0, 0) andTitleString:noticeStr andAttributedString:nil andTitleColor:[UIColor whiteColor] andBackGroundColor:[UIColor clearColor] andFont:[UIFont systemFontOfSize:14] andTextAlignment:NSTextAlignmentCenter atView:noticV];
    
    float sw=[UIScreen mainScreen].bounds.size.width;
    float sh=[UIScreen mainScreen].bounds.size.height;
    
    [label sizeToFit];
    if (label.width>sw) {
        label.numberOfLines=0;
        int n=label.width/sw+1;
        label.height=label.height*n;
        label.width=sw;
    }
    
    noticV.left=sw/2-label.width/2-10;
    noticV.top=sh/2;
    noticV.width=label.width+20;
    noticV.height=label.height+10;
    
    label.left=10;
    label.top=5;
    
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:.5f animations:^{
            label.alpha=0;
            noticV.alpha=0;
        } completion:^(BOOL finished) {
            [noticV removeFromSuperview];
            [label removeFromSuperview];
        }];
        
    });
}

@end
