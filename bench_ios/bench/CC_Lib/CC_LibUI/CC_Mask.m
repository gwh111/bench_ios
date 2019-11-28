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
#import "UIColor+CC.h"

@interface CC_Mask(){
    NSString *textStr;
    UIActivityIndicatorView *activityIndicator;
    CC_View *crossView;
    BOOL canCross;
    CC_View *progressView;
}

@end

@implementation CC_Mask
@synthesize textL;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_Mask.shared initUI];
    }];
}

- (void)start {
    [self startAtView:nil];
}

- (void)setCross:(BOOL)cross {
    canCross = cross;
}

- (void)setText:(NSString *)text {
    textStr = text;
}

- (void)startAtView:(UIView *)view {
    
    [CC_CoreThread.shared cc_gotoMain:^{
        
        [self safeStartAtView:view];
    }];
    
}

- (void)safeStartAtView:(UIView *)view {
    UIView *showV;
    if (view) {
        showV = view;
    }else{
        showV = [CC_NavigationController shared].cc_UINav.topViewController.view;
    }
    
    if (canCross == 0) {
        crossView.hidden = NO;
        showV.hidden = NO;
        [showV addSubview:crossView];
    }else{
        showV.hidden = YES;
    }
    
    [activityIndicator startAnimating];
    
    [progressView setCenter:showV.center];
    progressView.bottom = showV.height/2;
    [showV addSubview:progressView];
    
    progressView.hidden = NO;
    if (textStr) {
        textL.text = textStr;
        activityIndicator.top = -RH(10);
    }else{
        activityIndicator.top = 0;
    }
}

- (void)initUI {
    crossView = [CC_Base.shared cc_init:CC_View.class];
    crossView.cc_frame(0.0f, 0.0f, WIDTH(), HEIGHT());
    
    progressView = [CC_Base.shared cc_init:CC_View.class];
    progressView.cc_frame(0.0f, 0.0f, RH(100), RH(100))
    .cc_backgroundColor(RGBA(0, 0, 0, 0.5))
    .cc_cornerRadius(RH(15));
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, RH(100), RH(100))];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [progressView addSubview:activityIndicator];
    
    textL = [CC_Base.shared cc_init:CC_Label.class];
    textL
    .cc_font(RF(14))
    .cc_textColor(UIColor.whiteColor)
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_addToView(progressView)
    .cc_frame(0.0f, RH(60), RH(100), RH(40));
}

- (void)stop {
    
    [CC_CoreThread.shared cc_gotoMain:^{
        
        [self safeStop];
    }];
}

- (void)safeStop {

    [activityIndicator stopAnimating];
    progressView.hidden = YES;
    crossView.hidden = YES;
}

- (void)dealloc {
    
}

@end
