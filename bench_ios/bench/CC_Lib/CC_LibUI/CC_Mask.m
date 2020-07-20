//
//  CC_Mask.m
//  bench_ios
//
//  Created by gwh on 2019/2/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Mask.h"
#import "CC_NavigationController.h"
#import "CC_CoreUI.h"
#import "UIColor+CCUI.h"
#import "ccs.h"

@interface CC_Mask(){
    NSString *textStr;
    UIActivityIndicatorView *activityIndicator;
    BOOL canCross;
}

@property (nonatomic, assign) BOOL isPause;
@property (nonatomic, assign) BOOL delayAnimateMark;
@property (nonatomic, retain) CC_View *progressView;
@property (nonatomic, retain) CC_View *crossView;

@end

@implementation CC_Mask
@synthesize textL;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        if (NSThread.isMainThread) {
            [CC_Mask.shared initUI];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CC_Mask.shared initUI];
            });
        }
    }];
}

- (void)start {
    if (_isPause) {
        return;
    }
    [self startAtView:nil];
}

- (void)pause {
    _isPause = YES;
}

- (void)resume {
    _isPause = NO;
}

- (void)setCross:(BOOL)cross {
    canCross = cross;
}

- (void)setText:(NSString *)text {
    textStr = text;
}

- (void)startAtView:(UIView *)view {
    
    _delayAnimateMark = YES;
    if (NSThread.isMainThread) {
        [self safeStartAtView:view];
    } else {
        [ccs gotoMain:^{
            [self safeStartAtView:view];
        }];
    }
    
}

- (void)safeStartAtView:(UIView *)view {
    
    UIView *showV;
    if (view) {
        showV = view;
    }else{
        showV = ccs.currentVC.view;
    }
    
    if (canCross == 0) {
        _crossView.hidden = NO;
        showV.hidden = NO;
        [showV addSubview:_crossView];
    }else{
        showV.hidden = YES;
    }
    
    [activityIndicator startAnimating];
    
    [_progressView setCenter:showV.center];
    _progressView.bottom = showV.height/2;
    [_crossView addSubview:_progressView];
    
    _progressView.hidden = NO;
    if (textStr) {
        textL.text = textStr;
        activityIndicator.top = -RH(10);
    }else{
        activityIndicator.top = 0;
    }
    
    _progressView.alpha = 0;
    [ccs delay:.5 block:^{
        
        if (self.delayAnimateMark) {
            self.progressView.alpha = 1;
        } else {
            [self stop];
        }
    }];
}

- (void)initUI {
    _crossView = [CC_Base.shared cc_init:CC_View.class];
    _crossView.cc_frame(0.0f, 0.0f, WIDTH(), HEIGHT());
    
    _progressView = [CC_Base.shared cc_init:CC_View.class];
    _progressView.cc_frame(0.0f, 0.0f, RH(100), RH(100))
    .cc_backgroundColor(RGBA(0, 0, 0, 0.5))
    .cc_cornerRadius(RH(15));
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, RH(100), RH(100))];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_progressView addSubview:activityIndicator];
    
    textL = [CC_Base.shared cc_init:CC_Label.class];
    textL
    .cc_font(RF(14))
    .cc_textColor(UIColor.whiteColor)
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_addToView(_progressView)
    .cc_frame(0.0f, RH(60), RH(100), RH(40));
}

- (void)stop {
    
    _delayAnimateMark = NO;
    [ccs gotoMain:^{
        
        [self safeStop];
    }];
}

- (void)safeStop {

    [activityIndicator stopAnimating];
    _progressView.hidden = YES;
    _crossView.hidden = YES;
}

- (void)dealloc {
    
}

@end
