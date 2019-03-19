//
//  CC_Loading.m
//  NewWord
//
//  Created by gwh on 2017/12/26.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import "CC_Loading.h"
#import "CC_Share.h"

@interface CC_Loading(){
    UIView *loadingV;
    UILabel *textLabel;
    NSTimer *aniTimer;
    NSString *loadingTextStr;
}
@end

@implementation CC_Loading

static CC_Loading *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_Loading alloc] init];
        [instance initUI];
    });
    return instance;
}

- (void)remove{
    instance=nil;
    onceToken=0;
}

- (void)initUI{
    loadingV=[[UIView alloc]init];
    loadingV.backgroundColor=ccRGBA(0, 0, 0, 0);
    
    textLabel=[[UILabel alloc]initWithFrame:loadingV.frame];
    textLabel.numberOfLines=0;
    textLabel.textColor=[UIColor blackColor];
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.font=[ccui getRFS:16];
    [loadingV addSubview:textLabel];
    textLabel.height=textLabel.height/2;
    textLabel.bottom=loadingV.bottom;
}

- (void)loading:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view textColor:(UIColor *)color{
    textLabel.textColor=color;
    [self showLoadingWithText:loadingText withAni:ani atView:view];
}

- (void)stop{
    [self stopLoading];
}

- (void)showLoadingWithText:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view{
    
    [view addSubview:loadingV];
    
    loadingV.hidden=NO;
    textLabel.hidden=NO;
    
    loadingTextStr=loadingText;
    loadingV.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    textLabel.frame=loadingV.frame;
    textLabel.text=loadingText;
    
    [aniTimer invalidate];
    
    if (ani) {
        aniTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shengchengTimer) userInfo:nil repeats:YES];
    }
    [view addSubview:loadingV];
}

- (void)stopLoading{
    loadingV.hidden=YES;
    textLabel.hidden=YES;
    [aniTimer invalidate];
}

- (void)shengchengTimer{
    if ([textLabel.text hasSuffix:@"..."]) {
        textLabel.text=loadingTextStr;
    }else if ([textLabel.text hasSuffix:@".."]){
        textLabel.text=[NSString stringWithFormat:@"%@...",loadingTextStr];
    }else if ([textLabel.text hasSuffix:@"."]){
        textLabel.text=[NSString stringWithFormat:@"%@..",loadingTextStr];
    }else{
        textLabel.text=[NSString stringWithFormat:@"%@.",loadingTextStr];
    }
}

@end
