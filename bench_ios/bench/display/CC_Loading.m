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
    NSTimer *aniTimer;
    NSString *loadingTextStr;
}
@end

@implementation CC_Loading
@synthesize textL;

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
    
    textL=[[UILabel alloc]initWithFrame:loadingV.frame];
    textL.numberOfLines=0;
    textL.textColor=[UIColor blackColor];
    textL.textAlignment=NSTextAlignmentCenter;
    textL.font=[ccui getRFS:16];
    [loadingV addSubview:textL];
    textL.height=textL.height/2;
    textL.bottom=loadingV.bottom;
}

- (void)start{
    [self startAtView:nil];
}

- (void)setText:(NSString *)text{
    loadingTextStr=text;
}

- (void)startAtView:(UIView * _Nullable)view{
    [self loading:loadingTextStr?loadingTextStr:@"" withAni:YES atView:view textColor:textL.textColor==COLOR_BLACK?COLOR_BLACK:textL.textColor];
}

- (void)loading:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view textColor:(UIColor *)color{
    textL.textColor=color;
    [self showLoadingWithText:loadingText withAni:ani atView:view];
}

- (void)stop{
    [self stopLoading];
}

- (void)showLoadingWithText:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view{
    
    UIView *showV;
    if (view) {
        showV=view;
    }else{
        showV=[CC_Code getAView];
    }
    [showV addSubview:loadingV];
    
    loadingV.hidden=NO;
    textL.hidden=NO;
    
    loadingTextStr=loadingText;
    loadingV.frame=CGRectMake(0, 0, showV.frame.size.width, showV.frame.size.height);
    textL.frame=loadingV.frame;
    textL.text=loadingText;
    
    [aniTimer invalidate];
    
    if (ani) {
        aniTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(shengchengTimer) userInfo:nil repeats:YES];
    }
    [showV addSubview:loadingV];
}

- (void)stopLoading{
    loadingV.hidden=YES;
    textL.hidden=YES;
    [aniTimer invalidate];
}

- (void)shengchengTimer{
    if ([textL.text hasSuffix:@"..."]) {
        textL.text=loadingTextStr;
    }else if ([textL.text hasSuffix:@".."]){
        textL.text=[NSString stringWithFormat:@"%@...",loadingTextStr];
    }else if ([textL.text hasSuffix:@"."]){
        textL.text=[NSString stringWithFormat:@"%@..",loadingTextStr];
    }else{
        textL.text=[NSString stringWithFormat:@"%@.",loadingTextStr];
    }
}

@end
