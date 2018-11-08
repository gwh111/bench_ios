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
#import<SystemConfiguration/CaptiveNetwork.h>

@interface ViewController (){
    NSArray *nameArr;
    NSArray *controArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    
    NSString *key=[NSString stringWithFormat:@"%@%@",[ccs getBid],[ccs getBundleVersion]];
    
    
    NSString *html = @"{\"71.40\":71.40,\"8.37\":8.37,\"80.40\":80.40,\"188.40\":188.40}";//模拟器处理耗时0.000379秒
    //\"test\":\"xxx\"
//    NSString *html = @"{\"test\":\"xxx\"}";
//    NSString *html = @"{\"test\":xxx}";
//    NSString *html=[ccs getPlistDic:@"test"][@"test2"];//12:23:55.709415+0800 12:23:55.711681+0800 耗时0.002266秒

    NSData *jsonData_ = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonParsingError_ = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData_ options:0 error:&jsonParsingError_]];
    NSLog(@"dic:%@", dic);
    dic=[dic correctDecimalLoss:dic];
    NSLog(@"dic:%@", dic);
    NSString *value=dic[@"71.40"];
    NSLog(@"dic:%@", [value correctDecimalLoss:value]);
    
    
    //@"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json"
    [CC_HttpTask getInstance].static_netTestContain=@"KK部落";
    [[CC_HttpTask getInstance]getConfigure:^(CCConfigure *configure) {
        
    }];
    
    //@"https://test-caihong-resource.oss-cn-hangzhou.aliyuncs.com/URL/ch_url.txt"
//    [[CC_HttpTask getInstance]getDomain:@"http://test-kkbuluo-resource.oss-cn-hangzhou.aliyuncs.com/URL/kk_url.txt" block:^(ResModel *result) {
//        
//    }];
    [[CC_HttpTask getInstance]getDomainWithReqList:@[@"http://dynamic.kkbuluo.net/kk_url.txt",@"http://dynamic.kkbuluo.net/kk_url.txt"] andKey:@"KK" block:^(ResModel *result) {
        
    }];
    
//    NSString *sss=[self filterString3:@"1"];
    
    NSString *regex = @"[^a-zA-Z0-9\u4e00-\u9fa5]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:@"1但"];
    if (isMatch==0) {
        
    }
    NSString *time = [CC_Date getUniqueNowTimeTimestamp];
    NSString *time2 = [CC_Date getUniqueNowTimeTimestamp];
    
    CC_Button *button11=[[CC_Button alloc]init];
    if ([button11 isKindOfClass:[CC_Button class]]) {
        NSLog(@"2");
    }
    id class1=[CC_Button superclass];
    id class2=[UIButton class];
    
    
    if ([class1 isKindOfClass:class2]) {
        NSLog(@"yes");
    }
    
    [CC_Share getInstance].ccDebug=1;
    //3D
//    [CC_3DWindow show];
#if (ZZ_TARGET_PLATFORM == ZZ_PLATFORM_IOS_IPHONE)
    NSLog(@"new");
#endif
    
    //获得一个文件夹下的所有文件完整路径
    NSArray *plistPath = [ccs getPathsOfType:@"plist" inDirectory:@"model"];
    
    [[CC_UIHelper getInstance]addModelDocument:@"model"];
    [[CC_UIHelper getInstance]initModels];
    
    CC_Button *getbt=[CC_Button getModel:@"normal1"];
    
//    [CC_ObjectModel showModel:getbt];
    
//    NSString *path=[NSString stringWithFormat:@"%@", NSHomeDirectory()];
//    CCLOG(@"%@",path);
    CC_Button *button=[[CC_Button alloc]init];
    button.frame=CGRectMake(0, 0, [ccui getRH:100], [ccui getRH:35]);
    button.backgroundColor=[UIColor clearColor];
    button.titleLabel.font=[ccui getRFS:14];
    [button setTitle:@"normal2" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [CC_Button saveModel:button name:@"normal2" des:@"黑色无边框黑色文字圆角 初始字体14 " hasSetLayer:0];
//    [CC_ObjectModel showModel:button];
    
//    [CC_ObjectModel showModels];
    
    NSLog(@"1");
    [ccs gotoThread:^{
        NSLog(@"2");
        NSLog(@"3");
        [ccs gotoMain:^{
            NSLog(@"4");
        }];
    }];
    NSLog(@"5");
    
    
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
    
    //CC_UIVIEWExt
    button.width=100;
    
    //CC_Label
    id label323=[CC_Label createWithFrame:CGRectMake(100, 200, 100, 100) andTitleString:@"123" andAttributedString:nil andTitleColor:[UIColor greenColor] andBackGroundColor:nil andFont:[UIFont systemFontOfSize:24] andTextAlignment:NSTextAlignmentRight atView:self.view];
    
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
//    [self requestxxx];
    
    
    //https://api.leancloud.cn/1/date
    //http://mapi1.93leju.net/service.json?service=APP_INITIAL_CONFIG_LOAD&loginKey=&timestamp=1526266427&authedUserId=&sign=03971cacca9b2c1dc90065edea390cb5
    [[CC_HttpTask getInstance]post:[NSURL URLWithString:@"https://www.baidu.com/baidu?wd=%E4%BD%A0%E4%BB%8E%E5%93%AA%E9%87%8C%E6%9D%A5"] params:@{} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
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
        
//        NSMutableString *tempStr = [NSMutableString stringWithString:dateStr2];
//        NSRange range = NSMakeRange (10, tempStr.length-10);
//        [tempStr deleteCharactersInRange:range];
        
        CCLOG(@"");
    }];
    
//    [[CC_HttpTask getInstance]get:[NSURL URLWithString:@"https://gwhnewword.oss-cn-shanghai.aliyuncs.com/word4.plist?Expires=1537608258&OSSAccessKeyId=TMP.AQGQr7p95Q4AeiSGE7_Pw3XJCjXSZiFuxdyBkOsPb31cfMwU7QaqA-LOcInaMC4CFQCCO8zDL6QVrMEBWPYo9Rj9NSINBQIVAMGbrF9gU8Jxlf-x1Ges2Ejc1Tju&Signature=h9O8%2F8Z0lOjBmMrZVfsa8NbCeZQ%3D"] params:@{@"getDate":@""} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
//        
//        NSData* plistData = [result.resultStr dataUsingEncoding:NSUTF8StringEncoding];
//        
////        NSPropertyListFormat format;
//        NSDictionary* plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListReadStreamError format:NSPropertyListImmutable error:nil];
//        
//        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",@"word4_1"]];
//        [plist writeToFile:fileName atomically:YES];
//        
////        NSLog( @"plist is %@", plist );
//        
//        
//        NSLog(@"1");
//    }];
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
    testAutoLabelGroupVC *labelGroup=[[testAutoLabelGroupVC alloc]init];
    nameArr=@[@"颜色匹配",@"动态布局",@"自动标签",@"模拟阻止闪退"];
    controArr=@[testColor,testCas,labelGroup];
    
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
    
    if (indexPath.section==3) {
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
