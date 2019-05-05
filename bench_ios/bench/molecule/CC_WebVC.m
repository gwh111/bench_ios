//
//  CC_WebVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_WebVC.h"
#import "CC_Share.h"

@interface CC_WebVC ()

@end

@implementation CC_WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=COLOR_WHITE;
    
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc] init];
    WKWebView *webV=[[WKWebView alloc]initWithFrame:CGRectMake([ccui getX], [ccui getY]+[ccui getRH:45], [ccui getW], [ccui getH]-[ccui getRH:45]) configuration:config];
    [self.view addSubview:webV];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com/"]];
    [webV loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
