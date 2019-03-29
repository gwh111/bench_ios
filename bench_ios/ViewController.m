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

@property(strong) void (^blk)();

@end

@implementation ViewController

- (NSString *) utf8ToUnicode:(NSString *)string{
    
    NSUInteger length = [string length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        unichar _char = [string characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
        }
        [str appendFormat:@"%@", s];
    }
    return str;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    
    //get
    [[CC_HttpTask getInstance]get:@"https://www.baidu.com/" params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];
    //post
    [[CC_HttpTask getInstance]post:@"https://www.baidu.com/" params:@{@"getDate":@""} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];
    
    {
        NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----";
        NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMjZu9UtVitvgHS\ntpmAU/rRVdhy9GaT2rnpCJOYSb0deVI+rXPKHI9Aca2LkWiRgkzM1wqbRvAvWrqK\ngm4PgQUjnoNr7vRd1HPUKNA9ATfJetddW86yar0ux3FMVaxUFN6F0KatqkplVXHo\n8qXubKHRx9dCbK95P96rJkrWBiO9AgMBAAECgYBO1UKEdYg9pxMX0XSLVtiWf3Na\n2jX6Ksk2Sfp5BhDkIcAdhcy09nXLOZGzNqsrv30QYcCOPGTQK5FPwx0mMYVBRAdo\nOLYp7NzxW/File//169O3ZFpkZ7MF0I2oQcNGTpMCUpaY6xMmxqN22INgi8SHp3w\nVU+2bRMLDXEc/MOmAQJBAP+Sv6JdkrY+7WGuQN5O5PjsB15lOGcr4vcfz4vAQ/uy\nEGYZh6IO2Eu0lW6sw2x6uRg0c6hMiFEJcO89qlH/B10CQQDDdtGrzXWVG457vA27\nkpduDpM6BQWTX6wYV9zRlcYYMFHwAQkE0BTvIYde2il6DKGyzokgI6zQyhgtRJ1x\nL6fhAkB9NvvW4/uWeLw7CHHVuVersZBmqjb5LWJU62v3L2rfbT1lmIqAVr+YT9CK\n2fAhPPtkpYYo5d4/vd1sCY1iAQ4tAkEAm2yPrJzjMn2G/ry57rzRzKGqUChOFrGs\nlm7HF6CQtAs4HC+2jC0peDyg97th37rLmPLB9txnPl50ewpkZuwOAQJBAM/eJnFw\nF5QAcL4CYDbfBKocx82VX/pFXng50T7FODiWbbL4UnxICE0UBFInNNiWJxNEb6jL\n5xd0pcy9O2DOeso=\n-----END PRIVATE KEY-----";
        
        NSString *originString = @"hello world!中文";
        for(int i=0; i<4; i++){
            originString = [originString stringByAppendingFormat:@" %@", originString];
        }
        NSString *encWithPubKey;
        NSString *decWithPrivKey;
        NSString *encWithPrivKey;
        NSString *decWithPublicKey;
        
        NSLog(@"Original string(%d): %@", (int)originString.length, originString);
        
        // Demo: encrypt with public key
        encWithPubKey = [CC_RSA encryptStr:originString publicKey:pubkey];
        NSLog(@"Enctypted with public key: %@", encWithPubKey);
        // Demo: decrypt with private key
        decWithPrivKey = [CC_RSA decryptStr:encWithPubKey privateKey:privkey];
        NSLog(@"Decrypted with private key: %@", decWithPrivKey);
    }
    
    __weak typeof(self) weakSelf = self;
    self.blk = ^{
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"Use Property:%@", weakSelf);
        NSLog(@"Use Property:%@", strongSelf);
        //……
    };
    self.blk();
    
    {
        self.blk = ^(UIViewController *vc) {
            NSLog(@"Use Property:%@", vc);
        };
        self.blk(self);
    }
    
//    abc *a=[[abc alloc]init];
//    a.str=@"dfdsg";
//    [a log];
    {
        
        NSArray *arr=[[NSArray alloc]init];
        CCLOG(@"%@",[arr class]);
        UIButton *bbb=[[UIButton alloc]init];
        CCLOG(@"%@",[bbb class]);
        UIButton *ccc=[UIButton buttonWithType:UIButtonTypeInfoDark];
        CCLOG(@"%@",[ccc class]);
    }
    
    
    UITextField *textF=[[UITextField alloc]initWithFrame:CGRectMake(0, [ccui getRH:100], [ccui getRH:100], [ccui getRH:100])];
    textF.keyboardType=UIKeyboardTypeNumberPad;
    textF.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:textF];
    
    {
        CC_Button *button=[[CC_Button alloc]initWithFrame:CGRectMake(0, [ccui getRH:200], [ccui getRH:100], [ccui getRH:100])];
        button.backgroundColor=[UIColor orangeColor];
        [self.view addSubview:button];
        [button addTappedBlock:^(UIButton *button) {
            
        }];
    }
    
    {
        NSString *key = @"efrVN9vy6MxuHrtG";
        NSString *iv = @"N3nLasdhgypjZu3r";
        
        NSString *str1 = @"you are not that into me";
        NSData *data1 = [str1 dataUsingEncoding:NSUTF8StringEncoding];
        //加密
        data1=[CC_AES encryptWithKey:key iv:iv data:data1];
        NSData *base64Data = [data1 base64EncodedDataWithOptions:0];
        NSString *base64Str = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        //解密
        NSData *data2 = [CC_AES decryptWithKey:key iv:iv data:data1];
        NSString *str2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"str2:%@", str2);
    }
    
    [[CC_HttpTask getInstance]getConfigure:^(Confi *result) {
        
    }];
    
    [[CC_HttpTask getInstance]getConfigure:^(Confi *result) {
        
    }];
    
    //timer
//    [[CC_TManager getInstance]registerT:@"g1" interval:0.1 block:^{
//
//        CCLOG(@"g1");
//    }];
//    [[CC_TManager getInstance]registerT:@"g2" interval:2 block:^{
//
//        CCLOG(@"g2");
//    }];
//    [[CC_TManager getInstance]registerT:@"g3" interval:5 block:^{
//
//        CCLOG(@"g3");
//        [[CC_TManager getInstance]unRegisterT:@"g1"];
//        [[CC_TManager getInstance]unRegisterT:@"g2"];
//        [[CC_TManager getInstance]unRegisterT:@"g3"];
//    }];
    
    CCLOG(@"%@",self.view);
    CCLOG(@"%@",self.view.window);
    {
        
        NSMutableArray *mutArr=[[NSMutableArray alloc]init];
        
        NSDictionary *dic1=@{@"la":@"1",@"count":@"2"};
        NSDictionary *dic4=@{@"la":@"1",@"count":@"123"};
        NSDictionary *dic0=@{@"la":@"1",@"count":@"99"};
        NSDictionary *dic2=@{@"la":@"1",@"count":@"34"};
        NSDictionary *dic3=@{@"la":@"1",@"count":@"13"};
        [mutArr addObject:dic0];
        [mutArr addObject:dic1];
        [mutArr addObject:dic2];
        [mutArr addObject:dic3];
        [mutArr addObject:dic4];
        mutArr=[CC_Parser sortMutArr:mutArr byKey:@"count" desc:1];
        CCLOG(@"%@",mutArr);
        mutArr=[CC_Parser sortMutArr:mutArr byKey:@"count" desc:0];
        CCLOG(@"%@",mutArr);
        
    }
    
    NSMutableArray *mutArr=[[NSMutableArray alloc]init];
    NSMutableString *str22=[[NSMutableString alloc]init];
    for (int i=0; i<4; i++) {
        NSMutableString *str222=[ccs copyThis:str22];
        [str222 appendString:@"2"];
        [mutArr addObject:str222];
    }
    
    NSString *sss=mutArr[1];
    sss=@"abc";
    
    
    id s= [CC_Date getWeekFromDate:[NSDate date]];
    //2018-11-13 09:48:51
    
    NSString *s1=[CC_Date getFormatDateFromNow:@"2018-11-13 09:48:51" andTime:@"2018-11-13 09:48:41"];
    NSString *s2=[CC_Date getFormatBeforeDateFromNow:@"2018-11-13 09:48:51" andTime:@"2018-11-13 09:48:41"];
    NSString *s3=[CC_Date getFormatMinuteDateFromNow:@"2018-11-13 09:48:51" andTime:@"2018-11-13 09:48:41"];
    
    {
        id i=@(5);
        NSString *html2=[i stringValue];
        
        
        NSString *html=[ccs getPlistDic:@"test"][@"test4"];
        
        NSLog(@"%@",html);
        NSString *tempStr1 = [html stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
        NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
        
        NSLog(@"%@",str);
    }
    
    NSString *key=[NSString stringWithFormat:@"%@%@",[ccs getBid],[ccs getBundleVersion]];
    key=[self utf8ToUnicode:@"😆"];
    
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
    NSLog(@"dic:%@", [dic[@"71.40"] stringValue]);
    

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
    
    NSMutableAttributedString *att=[[NSMutableAttributedString alloc]init];
    att=[CC_AttributedStr getOrigAttStr:att appendStr:@"" withColor:nil];
    
    CC_Button *button=[[CC_Button alloc]init];
    button.frame=CGRectMake(0, 0, [ccui getRH:100], [ccui getRH:35]);
    button.backgroundColor=[UIColor clearColor];
    button.titleLabel.font=[ccui getRFS:14];
    [button setTitle:@"normal2" forState:UIControlStateNormal];
    [button setAttributedTitle:att forState:UIControlStateNormal];
    [button setTitleColor:COLOR_BLACK forState:UIControlStateNormal];
    [CC_Button saveModel:button name:@"normal2" des:@"黑色无边框黑色文字圆角 初始字体14 " hasSetLayer:0];
//    [CC_ObjectModel showModel:button];
//    [button addTarget:self action:@selector(bttt:) forControlEvents:UIControlEventTouchUpInside];
    [button addTappedOnceDelay:2 withBlock:^(UIButton *button) {
        CCLOG(@"???");
    }];
    
//    button.cs_acceptEventInterval=10;
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
    
    {
        CC_Label *label=[[CC_Label alloc]init];
        label.frame=CGRectMake(100, 200, 100, 100);
        [self.view addSubview:label];
        NSString *originStr=@"askfofpfjdsfdsf";
        NSDictionary *attrDict1 = @{ NSFontAttributeName: [UIFont fontWithName: @"Zapfino" size: 15],
                                     NSForegroundColorAttributeName: [UIColor blueColor] };
        NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString: [originStr substringWithRange: NSMakeRange(0, 4)] attributes: attrDict1];
        
        //第二段
        NSDictionary *attrDict2 = @{ NSFontAttributeName: [UIFont fontWithName: @"Zapfino" size: 15],
                                     NSForegroundColorAttributeName: [UIColor redColor] };
        NSAttributedString *attrStr2 = [[NSAttributedString alloc] initWithString: [originStr substringWithRange: NSMakeRange(4, 3)] attributes: attrDict2];
        
        //第三段
        NSDictionary *attrDict3 = @{ NSFontAttributeName: [UIFont fontWithName: @"Zapfino" size: 15],
                                     NSForegroundColorAttributeName: [UIColor blackColor] };
        NSAttributedString *attrStr3 = [[NSAttributedString alloc] initWithString: [originStr substringWithRange:
                                                                                    NSMakeRange(7, originStr.length - 4 - 3)] attributes: attrDict3];
        //合并
        NSMutableAttributedString *attributedStr03 = [[NSMutableAttributedString alloc] initWithAttributedString: attrStr1];
        [attributedStr03 appendAttributedString: attrStr2];
        [attributedStr03 appendAttributedString: attrStr3];
        label.attributedText=attributedStr03;
    }
    
    NSString *newDes=[CC_DES encryptUseDES:@"😄多少abc123h到底2344343242343243223423方法。" key:@"91caizhan"];
    newDes=[LCdes lcEncryUseDES:@"abc"];
    NSLog(@"%@",[LCdes lcEncryUseDES:@""]);
    
    NSString *decode=[CC_DES decryptUseDES:newDes key:@"apple"];
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
