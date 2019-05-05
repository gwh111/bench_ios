//
//  testWebVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testWebVC.h"

#import "CC_WebView.h"
#import "CC_WebVC.h"

@interface testWebVC ()

@end

@implementation testWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CC_Button *button=[[CC_Button alloc]initWithFrame:CGRectMake(RH(10), RH(100), RH(100), RH(50))];
    [button setBackgroundColor:COLOR_BLACK];
    [self.view addSubview:button];
    
    [button addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
        
        CC_WebVC *web=[[CC_WebVC alloc]init];
        
        [self.navigationController presentViewController:web animated:YES completion:nil];
    }];
    
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
