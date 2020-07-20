//
//  CC_Notice.m
//  bench_ios
//
//  Created by gwh on 2017/8/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Notice.h"
#import "CC_NavigationController.h"
#import "CC_CoreUI.h"
#import "UIColor+CCUI.h"
#import "ccs.h"

@implementation CC_Notice

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (void)showNotice:(NSString *)noticeStr{
    [self showNotice:noticeStr atView:nil delay:0];
}

- (void)showNotice:(NSString *)noticeStr atView:(UIView *)view{
    [self showNotice:noticeStr atView:view delay:0];
}

- (void)showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay {
    
    if ([NSThread currentThread] == [NSThread mainThread]) {
        [self _showNotice:noticeStr atView:view delay:delay];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _showNotice:noticeStr atView:view delay:delay];
    });
    
}

- (void)_showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay {
    if (noticeStr.length <= 0) {
        return;
    }
    UIView *showV;
    if (view) {
        showV = view;
    } else {
        showV = ccs.currentVC.view;
    }
    
    CC_Label *label = [CC_Base.shared cc_init:CC_Label.class];
    label
    .cc_text(noticeStr)
    .cc_numberOfLines(0)
    .cc_font(RF(14))
    .cc_textColor(UIColor.whiteColor)
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_addToView(showV)
    .cc_backgroundColor(RGBA(0, 0, 0, .8));
    
    label.width = WIDTH() - RH(40);
    [label sizeToFit];
    label.bottom = HEIGHT()/2 + [CC_Notice shared].cc_yOffset;
    label.left = WIDTH()/2-label.width/2;
    
    //adjust
    label.width = label.width+RH(20);
    label.left = label.left-RH(10);
    label.height = label.height+RH(20);
    
    float animateDelay = delay;
    if (animateDelay == 0) {
        if (noticeStr.length < 10) {
            animateDelay = 3;
        }else if (noticeStr.length < 30){
            animateDelay = 3 + (noticeStr.length - 10) * 0.2;
        }else{
            animateDelay = 7;
        }
    }
    
    [CC_Thread.shared delay:animateDelay block:^{
        [UIView animateWithDuration:.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            if (!showV) {
                return;
            }
            [label removeFromSuperview];
        }];
    }];
}

@end
