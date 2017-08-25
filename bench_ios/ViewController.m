//
//  ViewController.m
//  bench_ios
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

#import "CC_Share.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //CC_Button
    //一行代码完成button的基本功能创建
    CC_Button *button=[CC_Button createWithFrame:CGRectMake(100, 100, 100, 100) andTitleString_stateNoraml:@"123" andAttributedString_stateNoraml:nil andTitleColor_stateNoraml:[UIColor blackColor] andTitleFont:[UIFont systemFontOfSize:16] andBackGroundColor:nil andImage:nil andBackGroundImage:nil inView:self.view];
    //附加属性自由添加
    [button setBackgroundColor:[UIColor grayColor]];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    [button.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
    [button.layer setBorderColor:colorref];//边框颜色
    
    //CC_UIVIEWExt
    button.width=100;
    
    //CC_Label
    id label=[CC_Label createWithFrame:CGRectMake(100, 200, 100, 100) andTitleString:@"123" andAttributedString:nil andTitleColor:[UIColor greenColor] andBackGroundColor:nil andFont:[UIFont systemFontOfSize:24] andTextAlignment:NSTextAlignmentRight atView:self.view];
    
    //CC_DESTool
    NSString *newDes=[DESTool encryptUseDES:@"😄多少abc123h到底2344343242343243223423方法。" key:@"91caizhan"];
    NSLog(@"%@",newDes);
    
    NSString *decode=[DESTool decryptUseDES:newDes key:@"91caizhan"];
    NSLog(@"%@",decode);
    
    //CC_GHttpSessionTask
    [[CC_Share shareInstance] setUserSignKey:@"123"];
    [[CC_Share shareInstance] setHttpRequestWithAppName:@"app" andHTTPMethod:@"POST" andTimeoutInterval:10];
    NSURL *url=[NSURL URLWithString:@"http://api.jczj123.com/client/service.json"];
    NSMutableDictionary *paraDic=[[NSMutableDictionary alloc]init];
    [paraDic setObject:@"1" forKey:@"service"];
    [CC_GHttpSessionTask postSessionWithJsonUrl:url ParamterStr:paraDic Info:nil FinishCallbackBlock:^(NSDictionary *resultDic, NSString *resultStr, NSString *error) {
        
    }];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
