//
//  testHttpVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testHttpVC.h"

@interface testHttpVC ()

@end

@implementation testHttpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //get
    [[CC_HttpTask getInstance]get:@"https://www.baidu.com/" params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];
    //post
    [[CC_HttpTask getInstance]post:@"https://www.baidu.com/" params:@{@"getDate":@""} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];

    //接口统一处理回调 比如对其他地方登陆逻辑处理
    [[CC_HttpTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:NO logicBlock:^(ResModel *result, void (^finishCallbackBlock)(NSString *error, ResModel *result)) {
        CCLOG(@"%@",@"PARAMETER_ERROR");
        
        [[CC_HttpTask getInstance]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
    }];
    
    //http头部信息
    [[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:
     @{@"appName":@"ljzsmj_ios",
       @"appVersion":@"1.0.3",
       @"appUserAgent":@"e1",
       }];
    
    NSLog(@"?%@",[CC_HttpTask getInstance].requestHTTPHeaderFieldDic);
    [[CC_HttpTask getInstance].requestHTTPHeaderFieldDic setObject:@"11" forKey:@"22"];
    [[CC_HttpTask getInstance].requestHTTPHeaderFieldDic setValue:@"23" forKey:@"34"];
    NSLog(@"?%@",[CC_HttpTask getInstance].requestHTTPHeaderFieldDic);
    //签名的key 一般登录后获取
    //    [[CC_HttpTask getInstance]setSignKeyStr:@"abc"];
    //额外每个请求要传的参数
    //    [[CC_HttpTask getInstance]setExtreDic:@{@"key":@"v"}];
    
    //获取配置
    [[CC_HttpTask getInstance]getConfigure:^(Confi *result) {
        
    }];
    
    [[CC_HttpTask getInstance]getConfigure:^(Confi *result) {
        
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
