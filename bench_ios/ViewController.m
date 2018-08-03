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
#import "CC_3DWindow.h"

#import <objc/runtime.h>


@interface ViewController (){
    NSArray *nameArr;
    NSArray *controArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    
    
#pragma mark init
    [CC_Share getInstance].ccDebug=0;
    //设置基准 效果图的尺寸即可
    [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
    NSString *absoluteFilePath=CASAbsoluteFilePath(@"stylesheet.cas");
    [CC_ClassyExtend initSheet:absoluteFilePath];
    [CC_ClassyExtend parseCas];
    
    //3D
    [CC_3DWindow show];
#if (ZZ_TARGET_PLATFORM == ZZ_PLATFORM_IOS_IPHONE)
    NSLog(@"new");
#endif
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    {//emoj->str
        NSData *data11 = [@"😂" dataUsingEncoding:NSUTF8StringEncoding];
        NSString *stringBase64 = [data11 base64Encoding]; // base64格式的字符串
        NSString *decodeStr = [[NSString alloc] initWithData:data11 encoding:NSUTF8StringEncoding];
    }
    {//str->emoji
        NSData *data11 = [@"8J+Ygg==" dataUsingEncoding:NSUTF8StringEncoding];
        NSData *baseData=[[NSData alloc] initWithBase64EncodedData:data11 options:0];
    }
        CCLOG(@"path=%@\n%@",NSHomeDirectory(),[[CCReqRecord getInstance]getTotalStr]);
    
    //CC_Button
    //一行代码完成button的基本功能创建
    CC_Button *button=[CC_Button createWithFrame:CGRectMake(100, 100, 100, 100) andTitleString_stateNoraml:@"123" andAttributedString_stateNoraml:nil andTitleColor_stateNoraml:[UIColor blackColor] andTitleFont:[UIFont systemFontOfSize:16] andBackGroundColor:nil andImage:nil andBackGroundImage:nil inView:self.view];
    [button addTappedOnceDelay:2.1 withBlock:^(UIButton *button) {
        NSLog(@"tap");
        [self requestxxx];
    }];
    //附加属性自由添加
    [button setBackgroundColor:[UIColor grayColor]];
    [CC_CodeClass setLineColorR:2 andG:32 andB:33 andA:1 width:2 view:button];
    
    //CC_UIVIEWExt
    button.width=100;
    
    //CC_Label
    id label323=[CC_Label createWithFrame:CGRectMake(100, 200, 100, 100) andTitleString:@"123" andAttributedString:nil andTitleColor:[UIColor greenColor] andBackGroundColor:nil andFont:[UIFont systemFontOfSize:24] andTextAlignment:NSTextAlignmentRight atView:self.view];
    
    id l=[CC_Label cr:self.view l:100 t:200 w:100 h:30 ts:@"cclabel" ats:nil tc:ccRGBHexA(0xFF0000, 1) bgc:[UIColor yellowColor] f:[ccui getRFS:14] ta:0];
    
    id v=[CC_View cr:self.view l:50 t:250 w:30 h:30 bgc:ccRGBHexA(0xFFF000,1)];
    
    id tf=[CC_TextField cr:self.view l:0 t:100 w:100 h:30 tc:[UIColor blackColor] bgc:[UIColor whiteColor] f:[ccui getRFS:14] ta:0 ph:@"ccfield" uie:NO];
    
    id tv=[CC_TextView cr:self.view l:200 t:100 w:100 h:30 ts:@"cctextview" ats:nil tc:[UIColor blackColor] bgc:[UIColor whiteColor] f:[ccui getRFS:14] ta:0 sb:NO eb:NO uie:NO];
    
    id b=[CC_Button cr:self.view l:0 t:50 w:100 h:40 ts:@"ccbutton" ats:nil tc:[UIColor blackColor] bgc:nil img:nil bgimg:nil f:[ccui getRFS:16] ta:2 uie:NO];
    
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
    
    [[CC_HttpTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:NO logicBlock:^(NSDictionary *resultDic) {
        CCLOG(@"%@",@"PARAMETER_ERROR");
        
        [[CC_HttpTask getInstance]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
    }];
//    [[CC_HttpTask getInstance] addResponseLogic:@"jumpLogin" logicStr:@"response,jumpLogin=0" stop:YES popOnce:YES logicBlock:^(NSDictionary *errorDic) {
//        CCLOG(@"%@",@"jumpLogin");
//    }];
    //CC_GHttpSessionTask
    //    [request setValue:@"cc-iphone" forHTTPHeaderField:@"appName"];
    //    [request setValue:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"appVersion"];
    //    CCLOG(@"%@",request.allHTTPHeaderFields);
    //http头部信息
    [[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:
  @{@"appName":@"ljzsmj_ios",
    @"appVersion":@"1.0.3",
    @"appUserAgent":@"e1",
    }];
    //签名的key 一般登录后获取
    [[CC_HttpTask getInstance]setSignKeyStr:@"abc"];
    //额外每个请求要传的参数
//    [[CC_HttpTask getInstance]setExtreDic:@{@"key":@"v"}];
    [self requestxxx];
    
    
    //https://api.leancloud.cn/1/date
    //http://mapi1.93leju.net/service.json?service=APP_INITIAL_CONFIG_LOAD&loginKey=&timestamp=1526266427&authedUserId=&sign=03971cacca9b2c1dc90065edea390cb5
    [[CC_HttpTask getInstance]get:[NSURL URLWithString:@"http://mapi1.93leju.net/service.json?service=APP_INITIAL_CONFIG_LOAD&loginKey=&timestamp=1526266427&authedUserId=&sign=03971cacca9b2c1dc90065edea390cb5"] params:@{} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [CC_Note showAlert:error];
            return ;
        }
//        CCLOG(@"%@",result.resultDic);
//        ccstr(@"a%@b=2",@"=1");
    }];
    
    [[CC_HttpTask getInstance]get:[NSURL URLWithString:@"https://www.baidu.com"] params:@{@"getDate":@""} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        NSString *dateStr=[CC_Date ccgetDateStr:result.responseDate formatter:result.responseDateFormatStr];
        NSString *dateStr2=[CC_Date ccgetDateStr:result.responseDate formatter:@"dd MM yyyy HH:mm:ss"];
        CCLOG(@"dateStr2=%@",dateStr2);
        CCLOG(@"min=%f",[CC_Date compareDate:[NSDate date] cut:result.responseDate]/60);
        
    }];
#pragma mark map arr parser
    NSDictionary *result=@{@"response":
  @{@"purchaseOrders":
  @[
  @{@"name":@"111",@"order":@"1111",@"prize":@"aaa"},
  @{@"name":@"222",@"order":@"2222",@"prize":@"bbb"}],
    
    @"paidFeeMap":
  @{@"1111":@"100yuan",@"2222":@"120yuan"},
    
    @"prizeFeeMap":
  @{@"aaa":@{@"name":@"a",@"time":@"ac"},
    @"bbb":@{@"name":@"b",@"time":@"bc"}}
                                       }};
    NSMutableArray *parr=[CC_Parser getMapParser:result[@"response"][@"purchaseOrders"] idKey:@"order" keepKey:YES pathMap:result[@"response"][@"paidFeeMap"]];
    parr=[CC_Parser addMapParser:parr idKey:@"prize" keepKey:NO map:result[@"response"][@"prizeFeeMap"]];
    
#pragma mark 测试排序
    NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}]];
    arr=[CC_Array sortChineseArr:arr depthArr:@[@"name"]];
    
#pragma mark demo测试控制器
    testColorViewController *testColor=[[testColorViewController alloc]init];
    testCasVC *testCas=[[testCasVC alloc]init];
    nameArr=@[@"颜色匹配",@"动态布局",@"模拟阻止闪退"];
    controArr=@[testColor,testCas];
    
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, self.view.height/2, self.view.width, self.view.height/2)];
    [self.view addSubview:tab];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=[UIColor whiteColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)requestxxx{
    NSURL *url=[NSURL URLWithString:@"http://mapi1.93leju.net/service.json?"];
    
    [[CC_HttpTask getInstance]post:url params:@{@"service":@"ROOM_USER_SETTLE_QUERY_BY_ROOM"} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [CC_Note showAlert:error];
            return ;
        }
        CCLOG(@"%@",result.resultDic);
    }];
    
    {
        
        NSURL *url=[NSURL URLWithString:@"http://mapi.93lejudev.net/service.json?service=APP_INITIAL_CONFIG_LOAD&appVersion=1.0.4&appName=ljzsmj_ios"];
        [[CC_HttpTask getInstance]get:url params:nil model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
            if (error) {
                [CC_Note showAlert:error];
                return ;
            }
            CCLOG(@"%@",result.resultDic);
        }];
    }
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
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    if (indexPath.section==2) {
        NSArray *arr = @[@(0), @(1)];
        CCLOG(@"%@", arr[2]); //模拟越界异常
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    CCLOG(@"%@\n%@\n%@",arr, reason, name);
    
    BOOL isContiune = TRUE; // 是否要保活
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (isContiune) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, true);
        }
    }
    CFRelease(allModes);
    
}
void UncaughtExceptio(NSException *exception) {

}

@end
