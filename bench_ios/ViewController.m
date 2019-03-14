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
#import "LoginKit.h"

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

- (void)reqqq{
    [[CC_HttpTask getInstance]get:[NSURL URLWithString:@"http://mapi1.kkbuluo.net/client/service.json?authedUserId=10004001888050707700290980138076&columnId=4001777412645712260000006810&commentByPay=1&content=%E5%91%A8%E4%BA%8C002%0A%20%20%20Word%E7%BC%96%E8%BE%91%EF%BC%8C%E5%A4%8D%E5%88%B6%E5%88%B0%E5%BE%AE%E4%BF%A1%EF%BC%8C%E5%86%8D%E5%A4%8D%E5%88%B6%E5%87%BA%E6%9D%A5%E3%80%82%0A%20%20%20%E5%9C%B0%E7%82%B9%EF%BC%9A%E6%96%97%E5%B1%B1%E7%90%83%E5%9C%BA%0A%20%20%20%E5%9C%BA%E6%AC%A1%EF%BC%9A2018-19%E8%B5%9B%E5%AD%A3%E6%AC%A7%E5%86%A0%E5%B0%8F%E7%BB%84%E8%B5%9B%E7%AC%AC6%E8%BD%AE&from=publishpay_navigation_unpersonalrelease_null_null_null&hiddenContent=%F0%9F%90%B0%E3%80%81ygg&loginKey=USL16a153b37edb4e2da9990c52fa16bc27&objectType=PERSONAL_ARTICLE&oneAuthId=6201807270000122&postChannelId=10004001888050707700290980138076&postChannelType=USER_TOPIC&priceAmount=58&service=SUBJECT_CREATE&stopAfterTime=1&timeUnitType=MINUTE&timestamp=1544600889667&title=%E5%A5%BD%E5%90%A7%E4%B9%9F%E8%A6%81&to=news&transmitToUserTopic=0&sign=97a75ac9b10657a96d73a1ecd42d4da3"] params:@{@"getDate":@""} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        
        if (error) {
            [self reqqq];
        }
    }];
}
     
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    
    {
        [[LoginKit getInstance]setUrlStr:@"http://mapi.kkbuluo.net/client/service.json?"];
        MAPI_ONE_AUTH_LOGIN *req=[[MAPI_ONE_AUTH_LOGIN alloc]initWithCell:@"15000000000" loginPassword:@"123" selectedDefaultUserToLogin:YES];
        [req requestAtView:self.view mask:YES block:^(NSDictionary *modifiedDic, ResModel *result) {
            
        }];
        
        CCLOG(@"%@",req.cell);
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
    
    [[CC_HttpTask getInstance]getDomainWithReqListNoCache:@[@"http://test-kkbuluo-resource.oss-cn-hangzhou.aliyuncs.com/URL/analysis_url.txt",@"http://dynamic.kkbuluo.net/analysis_url.txt"] block:^(ResModel *result) {
        
    }];
//    return;
    
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
    
    
    //@"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json"
    [CC_HttpTask getInstance].static_netTestContain=@"KK部落";
    [[CC_HttpTask getInstance]getConfigure:^(Confi *configure) {
        
    }];
    
    //@"https://test-caihong-resource.oss-cn-hangzhou.aliyuncs.com/URL/ch_url.txt"
//    [[CC_HttpTask getInstance]getDomain:@"http://test-kkbuluo-resource.oss-cn-hangzhou.aliyuncs.com/URL/kk_url.txt" block:^(ResModel *result) {
//        
//    }];
//    [[CC_HttpTask getInstance]getDomainWithReqList:@[@"http://dynamic.kkbuluo.net/kk_url.txt",@"http://dynamic.kkbuluo.net/kk_url.txt"] andKey:@"KK" block:^(ResModel *result) {
//        
//    }];
    
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
    //http://mapi.kkbuluo.net/client/service.json?getDxGgSp=1&getRfGgSp=1&getSfGgSp=1&getSfcGgSp=1&getSupport=1&hhgg=1&service=JCZQ_SELLABLE_ISSUE_QUERY
    
    [[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:@{@"appCode":@"chaoyue",@"appName":@"ch_user_ios",@"appVersion":@"100000"}];
    [[CC_HttpTask getInstance]get:[NSURL URLWithString:@"http://user1-mapi.caihong.net/client/service.json?service=CLIENT_VERSION_UPDATE_QUERY"] params:@{@"getDate":@""} model:[[ResModel alloc]init] finishCallbackBlock:^(NSString *error, ResModel *result) {
        NSString *dateStr=[CC_Date ccgetDateStr:result.responseDate formatter:result.responseDateFormatStr];
        NSString *dateStr2=[CC_Date ccgetDateStr:result.responseDate formatter:@"dd MM yyyy HH:mm:ss"];
        CCLOG(@"dateStr2=%@",dateStr2);
        CCLOG(@"min=%f",[CC_Date compareDate:[NSDate date] cut:result.responseDate]/60);
        
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"tishi" message:result.resultDic[@"response"][@"updateLogMemo"] delegate:nil cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
        [alt show];
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

- (void)bttt:(CC_Button *)button{
    CCLOG(@"???");
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
