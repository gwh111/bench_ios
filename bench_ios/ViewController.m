//
//  ViewController.m
//  bench_ios
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

#import "CC_Share.h"

#import "LCdes.h"

@interface ViewController (){
    NSArray *nameArr;
    NSArray *controArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
    [[CC_UIHelper getInstance]initToolV];
#if (ZZ_TARGET_PLATFORM == ZZ_PLATFORM_IOS_IPHONE)
    NSLog(@"new");
#endif
    
    //CC_Button
    //一行代码完成button的基本功能创建
    CC_Button *button=[CC_Button createWithFrame:CGRectMake(100, 100, 100, 100) andTitleString_stateNoraml:@"123" andAttributedString_stateNoraml:nil andTitleColor_stateNoraml:[UIColor blackColor] andTitleFont:[UIFont systemFontOfSize:16] andBackGroundColor:nil andImage:nil andBackGroundImage:nil inView:self.view];
    [button addTappedOnceDelay:2.1 withBlock:^(UIButton *button) {
        NSLog(@"tap");
    }];
    //附加属性自由添加
    [button setBackgroundColor:[UIColor grayColor]];
    [CC_CodeClass setLineColorR:2 andG:32 andB:33 andA:1 width:2 view:button];
    
    //CC_UIVIEWExt
    button.width=100;
    
    //CC_Label
    id label=[CC_Label createWithFrame:CGRectMake(100, 200, 100, 100) andTitleString:@"123" andAttributedString:nil andTitleColor:[UIColor greenColor] andBackGroundColor:nil andFont:[UIFont systemFontOfSize:24] andTextAlignment:NSTextAlignmentRight atView:self.view];
    
    //CC_DESTool
    NSString *newDes=[DESTool encryptUseDES:@"😄多少abc123h到底2344343242343243223423方法。" key:@"91caizhan"];
    newDes=[LCdes lcEncryUseDES:@"abc"];
    NSLog(@"%@",[LCdes lcEncryUseDES:@""]);
    
    NSString *decode=[DESTool decryptUseDES:newDes key:@"apple"];
    NSLog(@"%@",decode);
    
    //base64
    NSString * str =@"str";
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    // 或 base64EncodedStringWithOptions
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSData *baseData = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    NSString * str2  =[[NSString alloc] initWithData:baseData encoding:NSUTF8StringEncoding];
    
    //CC_GHttpSessionTask
    //http头部信息
    [[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:
  @{@"appName":@"ljzsmj_ios",
    @"appVersion":@"1.0.3",
    @"appUserAgent":@"e1",
    }];
    //签名的key 一般登录后获取
    [[CC_HttpTask getInstance]setSignKeyStr:@"abc"];
    //额外每个请求要传的参数
    [[CC_HttpTask getInstance]setExtreDic:@{@"key":@"v"}];
    NSURL *url=[NSURL URLWithString:@"http://mapi.17caiyou.com/service.json?"];
    [[CC_HttpTask getInstance]post:url Params:@{@"service":@"PURCHASE_ORDRE_JOINED_SHOW_CONFIG_QUERY"} model:[[ResModel alloc]init] FinishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [CC_Note showAlert:error];
            return ;
        }
        
        CCLOG(@"%@",result.resultDic);
    }];
    
    
    
#pragma mark demo测试控制器
    testColorViewController *testColor=[[testColorViewController alloc]init];
    testUIViewController *testUI=[[testUIViewController alloc]init];
    nameArr=@[@"testColor",@"testUI"];
    controArr=@[testColor,testUI];
    
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, self.view.height/2, self.view.width, self.view.height/2)];
    [self.view addSubview:tab];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=[UIColor whiteColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [nameArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.textLabel.text=[nameArr objectAtIndex:indexPath.section];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    id con=controArr[indexPath.section];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
