//
//  CC_WebVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_WebVC.h"
#import "CC_Share.h"

@interface CC_WebVC ()<WKUIDelegate,WKNavigationDelegate>{
    UIView *progressV;
}

@end

@implementation CC_WebVC

@synthesize webV;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=COLOR_WHITE;
    
}

- (void)dealloc
{
    [webV removeObserver:self forKeyPath:@"title"];
    [webV removeObserver:self forKeyPath:@"estimatedProgress"];
    [webV removeObserver:self forKeyPath:@"URL"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)presentWeb:(NSString *)urlStr{
    CC_WebVC *web=[[CC_WebVC alloc]init];
    web.urlStr=urlStr;
    [web initUI];
    [[CC_Code getRootNav] presentViewController:web animated:YES completion:nil];
}

- (void)initUI{
    float barH=[ccui getRH:45];
    
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc] init];
    webV=[[WKWebView alloc]initWithFrame:CGRectMake([ccui getX], [ccui getSY]+barH, [ccui getW], [ccui getSH]-barH) configuration:config];
    [self.view addSubview:webV];
    
    webV.UIDelegate = self;
    webV.navigationDelegate=self;
    webV.allowsBackForwardNavigationGestures = YES;
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [webV loadRequest:request];
    
    [webV addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [webV addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [webV addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context:nil];
    
    progressV=[[UIView alloc]init];
    progressV.frame=CGRectMake(0, webV.top, 0, 1);
    progressV.backgroundColor=[UIColor colorWithRed:62/255.0f green:188/255.0f blue:202/255.0f alpha:1];
    [self.view addSubview:progressV];
    
    NSArray *names=@[@"X"];
    for (int i=0; i<names.count; i++) {
        CC_Button *bt=[[CC_Button alloc]initWithFrame:CGRectMake([ccui getRH:75]*i, [ccui getSY], barH, barH)];
        [bt setTitle:names[i] forState:UIControlStateNormal];
        [bt setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
        [self.view addSubview:bt];
        [bt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            
            [[CC_Code getRootNav] dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        float p=webV.estimatedProgress;
        [UIView animateWithDuration:.2f animations:^{
            self->progressV.width=[ccui getW]*p;
        } completion:^(BOOL finished) {
            
        }];
        CCLOG(@"p=%f",p);
        if (p==1) {
            self->progressV.width=0;
        }
    }else if ([keyPath isEqualToString:@"title"]){
        
        
    }else if ([keyPath isEqualToString:@"URL"]){
        
        
    }
    
}

@end
