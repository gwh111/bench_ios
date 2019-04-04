//
//  CC_Mask.m
//  bench_ios
//
//  Created by gwh on 2019/2/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Mask.h"
#import "CC_Share.h"

@interface CC_Mask(){
    
    NSString *textStr;
}

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIView *progressView;

@property (nonatomic,strong) UIView *crossView;
@property (nonatomic,assign) BOOL canCross;

@end

@implementation CC_Mask
@synthesize textL;

static CC_Mask *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_Mask alloc] init];
        [instance initUI];
    });
    return instance;
}

- (void)start{
    [self startAtView:nil];
}

- (void)setCross:(BOOL)cross{
    self.canCross=cross;
}

- (void)setText:(NSString *)text{
    textStr=text;
}

- (void)startAtView:(UIView *)view
{
    UIView *showV;
    if (view) {
        showV=view;
    }else{
        showV=[CC_Code getAView];
    }
    
    if (_canCross==0) {
        showV.hidden=NO;
        [showV addSubview:_crossView];
    }else{
        showV.hidden=YES;
    }
    
    [self.activityIndicator startAnimating];
    
    UIView *progressView = self.progressView;
    
    [progressView setCenter:showV.center];
    progressView.bottom=showV.height/2;
    [showV addSubview:progressView];
    
    _progressView.hidden=NO;
    if (textStr) {
        textL.text=textStr;
        _activityIndicator.top=-[ccui getRH:10];
    }else{
        _activityIndicator.top=0;
    }
}

- (void)initUI
{
    _crossView=[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getW], [ccui getH])];
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100], [ccui getRH:100])];
    [_progressView setBackgroundColor:[UIColor blackColor]];
    _progressView.backgroundColor = ccRGBA(0, 0, 0, .5);
    _progressView.layer.cornerRadius = [ccui getRH:15];
    _progressView.layer.masksToBounds = YES;
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100], [ccui getRH:100])];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_progressView addSubview:_activityIndicator];
    
    textL=[[UILabel alloc]init];
    textL.frame=CGRectMake(0.0f, [ccui getRH:60], [ccui getRH:100], [ccui getRH:40]);
    textL.font=[ccui getRFS:14];
    textL.textColor=[UIColor whiteColor];
    textL.textAlignment=NSTextAlignmentCenter;
    [_progressView addSubview:textL];
}

- (void)stop
{
    [self.activityIndicator stopAnimating];
    _progressView.hidden=YES;
    _crossView.hidden=YES;
}

- (void)dealloc
{
    
}

@end
