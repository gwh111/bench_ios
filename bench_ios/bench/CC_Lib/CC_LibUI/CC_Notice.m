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
#import "UIColor+CC.h"

@implementation CC_Notice

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (CC_Label *)showNotice:(NSString *)noticeStr{
    return [self showNotice:noticeStr atView:nil delay:0];
}

- (CC_Label *)showNotice:(NSString *)noticeStr atView:(UIView *)view{
    return [self showNotice:noticeStr atView:view delay:0];
}

- (CC_Label *)showNotice:(NSString *)noticeStr atView:(UIView *)view delay:(int)delay{
    if (noticeStr.length <= 0) {
        return nil;
    }
    UIView *showV;
    if (view) {
        showV = view;
    }else{
        showV = [CC_NavigationController shared].cc_UINav.topViewController.view;
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
    
    if (delay == 0) {
        if (noticeStr.length < 10) {
            delay = 3;
        }else if (noticeStr.length < 30){
            delay = 3 + (noticeStr.length - 10) * 0.2;
        }else{
            delay = 7;
        }
    }
    
    [CC_CoreThread.shared cc_delay:delay block:^{
        [UIView animateWithDuration:.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            if (!showV) {
                return;
            }
            [label removeFromSuperview];
        }];
    }];
    
    return label;
}

@end
