//
//  CC_Mask.m
//  bench_ios
//
//  Created by gwh on 2019/2/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Mask.h"
#import "CC_Share.h"

@interface CC_Mask()

@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong) UIView *progressView;

@end

@implementation CC_Mask

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

- (void)startAtView:(UIView *)view
{
    [self.activityIndicator startAnimating];
    
    UIView *progressView = self.progressView;
    
    [progressView setCenter:view.center];
    [view addSubview:progressView];
    
    self.hidden=NO;
}

- (void)initUI
{
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100], [ccui getRH:100])];
    [_progressView setBackgroundColor:[UIColor blackColor]];
    _progressView.backgroundColor = ccRGBA(0, 0, 0, .5);
    _progressView.layer.cornerRadius = [ccui getRH:15];
    _progressView.layer.masksToBounds = YES;
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ccui getRH:100], [ccui getRH:100])];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_progressView addSubview:_activityIndicator];
    
}

- (void)stop
{
    [self.activityIndicator stopAnimating];
    self.hidden=YES;
}

- (void)dealloc
{
    
}

@end
