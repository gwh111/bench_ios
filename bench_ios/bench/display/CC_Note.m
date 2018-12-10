//
//  CC_Note.m
//  bench_ios
//
//  Created by gwh on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Note.h"
#import "CC_Share.h"

@implementation CC_Note

static CC_Note *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_Note alloc] init];
        instance.delayTime=3;
    });
    return instance;
}

+ (void)showAlert:(NSString *)str{
    [self showAlert:str atView:nil];
}

+ (void)showAlert:(NSString *)str atView:(UIView *)view{
    if ([NSThread isMainThread]) {
        [self main_showAlert:str atView:view];
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self main_showAlert:str atView:view];
        });
    }
}

+ (void)main_showAlert:(NSString *)str atView:(UIView *)view{
    UIView *showV=[CC_Code getAView];
    
    UIView *alertView=[[UIView alloc]initWithFrame:CGRectMake(10, showV.frame.size.height/2+[CC_Note getInstance].ccnote_count*40, showV.frame.size.width-20, 40)];
    [CC_Note getInstance].ccnote_count=[CC_Note getInstance].ccnote_count+1;
    if ([CC_Note getInstance].ccnote_count>3) {
        [CC_Note getInstance].ccnote_count=-3;
    }
    [[CC_Code getAView] addSubview:alertView];
    alertView.backgroundColor=ccRGBA(0, 0, 0, .8);
    
    UILabel *alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, showV.frame.size.width-20, 40)];
    alertLabel.textColor=[UIColor whiteColor];
    alertLabel.font=[UIFont systemFontOfSize:12];
    alertLabel.textAlignment=NSTextAlignmentCenter;
    alertLabel.text=str;
    [alertView addSubview:alertLabel];
    alertView.alpha=0;
    alertLabel.numberOfLines=0;
    
    [UIView animateWithDuration:.5f animations:^{
        alertView.alpha=1;
    } completion:^(BOOL finished) {
        
        double delayInSeconds = [CC_Note getInstance].delayTime;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:.5f animations:^{
                alertView.alpha=0;
            } completion:^(BOOL finished) {
                [alertView removeFromSuperview];
            }];
        });
    }];
}

@end
