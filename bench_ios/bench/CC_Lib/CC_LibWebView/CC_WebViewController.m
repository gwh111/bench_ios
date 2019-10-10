//
//  CC_WebVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_WebViewController.h"
#import "CC_View.h"
#import "UIColor+CC.h"
#import "CC_Label.h"

@interface CC_WebViewController ()<WKUIDelegate,WKNavigationDelegate>{
    CC_View *progressView;
    CC_Label *titleLabel;
    BOOL navHidden;
    
    CC_WebView *webV;
}

@end

@implementation CC_WebViewController
@synthesize urlStr,htmlContent;

- (void)cc_viewDidLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    self.cc_navigationBar.backButton.hidden = YES;
    [self initUI];
}

- (void)cc_dealloc {
    webV.UIDelegate = nil;
    webV.navigationDelegate = nil;
    [webV removeObserver:self forKeyPath:@"title" context:@"ccWebviewController"];
    [webV removeObserver:self forKeyPath:@"estimatedProgress" context:@"ccWebviewController"];
    [webV removeObserver:self forKeyPath:@"URL" context:@"ccWebviewController"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initUI {
    webV = [CC_Base.shared cc_init:CC_WebView.class];
    webV
    .cc_frame(0, STATUS_AND_NAV_BAR_HEIGHT, WIDTH(), SAFE_HEIGHT()-NAV_BAR_HEIGHT)
    .cc_addToView(self.view)
    .cc_UIDelegate(self)
    .cc_navigationDelegate(self)
    .cc_allowsBackForwardNavigationGestures(YES);
    
    if (urlStr) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [webV loadRequest:request];
    }else if (htmlContent) {
        [webV loadHTMLString:htmlContent baseURL:nil];
    }
    
    [webV addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:@"ccWebviewController"];
    [webV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:@"ccWebviewController"];
    [webV addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:@"ccWebviewController"];
    
    progressView = [CC_Base.shared cc_init:CC_View.class];
    progressView
    .cc_addToView(self.view)
    .cc_frame(0, webV.top, 0, 1)
    .cc_backgroundColor(RGBA(62, 255.0, 202, 1));
    
    NSArray *names = @[@"X"];
    
    // WS(weakSelf)
    for (int i = 0; i < names.count; i++) {
        CC_Button *button = ((CC_Button *)[CC_Base.shared cc_init:CC_Button.class])
        .cc_addToView(self.view)
        .cc_frame(RH(75)*i, Y(), NAV_BAR_HEIGHT, NAV_BAR_HEIGHT)
        .cc_setTitleForState(names[i], UIControlStateNormal)
        .cc_setTitleColorForState(UIColor.blackColor, UIControlStateNormal);
        
        [button cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            [[CC_NavigationController shared]cc_popViewController];
        }];
    }
    
    titleLabel = [CC_Base.shared cc_init:CC_Label.class];
    titleLabel
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_addToView(self.view)
    .cc_size(WIDTH() - RH(100), NAV_BAR_HEIGHT)
    .cc_center(WIDTH()/2, Y() + NAV_BAR_HEIGHT/2);
    
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [[CC_NavigationController shared]cc_pushWebViewControllerWithUrl:navigationAction.request.URL.absoluteString];
    }
    return nil;
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        float p = webV.estimatedProgress;
        [UIView animateWithDuration:.2f animations:^{
            self->progressView.width = WIDTH()*p;
        } completion:^(BOOL finished) {
            
        }];
        if (p == 1) {
            self->progressView.width = 0;
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        titleLabel.text = webV.title;
        self.title = webV.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    }
}

@end
