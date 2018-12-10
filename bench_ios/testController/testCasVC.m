//
//  testCasVC.m
//  bench_ios
//
//  Created by gwh on 2018/7/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "testCasVC.h"
# define DebugLog(fmt, ...) NSLog((@"\n[文件名:%s]\n""[函数名:%s]\n""[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
@interface testCasVC ()

@end

@implementation testCasVC

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(250, 100, 100, 40)];
    l.backgroundColor=[UIColor yellowColor];
    l.text=@"普通label";
    [self.view addSubview:l];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_i_figure1" class:[UIImageView class] finishBlock:^(UIImageView *atom) {
    }];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_b_box1" class:[CC_Button class] finishBlock:^(CC_Button *atom) {
        [atom setBackgroundColor:[UIColor brownColor]];
        [atom addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            
            [self requestxxx1];
        }];
    }];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_l_box2" type:CCAtomTypeLabel finishBlock:^(CC_Label *atom) {
        //        atom.text=@"数据刷新";
        //        [atom sizeToFit];
    }];
    
    
    
    CC_TextField *textField=[CC_UIAtom initAt:self.view name:@"MainVC_tf_box1" type:CCAtomTypeTextField finishBlock:^(id atom) {
    }];
    
    
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CCLOG(@"%d",l.stopCas);
        CC_TextView *atom=[CC_UIAtom initAt:self.view name:@"MainVC_tv_box1" type:CCAtomTypeTextView finishBlock:^(CC_TextView *atom) {
        }];
        [textField updateLayout];
        textField.height=100;
        double delayInSeconds = 3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            textField.width=10;
        });
    });
}

- (void)requestxxx1{
//    CCLOG(@"tapped");
//    DebugLog(@"Current method: %@ m=%@",NSStringFromSelector(_cmd),[NSThread callStackSymbols]);
    [CC_HookTrack willPopOfIndex:1];
    //http://mapi.csfengy.com/client/service.json?service=MY_USER_INFO_QUERY&sign=523ac4816eea20e5e6136bdb40339ac7&authedUserId=10044001473443540200290010021115&loginKey=USLc037212a800941c4b842cce0881524bb USS63118e2fe817415d953243cea50e3473
    NSURL *url=[NSURL URLWithString:@"http://mapi.csfengy.com/client/service.json?"];
    [[CC_HttpTask getInstance]setSignKeyStr:@"USS63118e2fe817415d953243cea50e3473"];
    [[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:@{@"appVersion":@"2.2.1",@"appName":@"pandasport-iphone"}];
    [[CC_HttpTask getInstance]post:url params:@{@"service":@"MY_USER_INFO_QUERY",@"authedUserId":@"10044001473443540200290010021115",@"loginKey":@"USLc037212a800941c4b842cce0881524bb"} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [CC_Note showAlert:error];
            return ;
        }
        CCLOG(@"%@",result.resultDic);
        
        
        int index=(int)[[self.navigationController viewControllers]indexOfObject:self];
        int toIndex=index-1;
        id controller=[self.navigationController.viewControllers objectAtIndex:toIndex];
        [self.navigationController popToViewController:controller animated:YES];
        //    [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

@end
