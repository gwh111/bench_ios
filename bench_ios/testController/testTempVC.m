//
//  testTempVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testTempVC.h"

#import "LCdes.h"

@interface testTempVC ()

@property(strong) void (^blk)();

@end

@implementation testTempVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        
        //    int i1=[CC_Validate isPureInt:@"123"];
        //    int i2=[CC_Validate isPureInt:@"发123"];
        //    int i3=[CC_Validate isPureInt:@"发的冯绍峰"];
        //    int i4=[CC_Validate isPureInt:@"dfks"];
        //    int i5=[CC_Validate isPureInt:@"dfks12"];
        //    int i6=[CC_Validate isPureInt:@"dfks是"];
        //    int i7=[CC_Validate isPureInt:@"dfks21点饭"];
        
        int i1=[CC_Validate isPureLetter:@"S大"];
        int i2=[CC_Validate isPureLetter:@"S"];
        int i3=[CC_Validate isPureLetter:@"asf"];
        int i4=[CC_Validate isPureLetter:@"asf12"];
        int i5=[CC_Validate isPureLetter:@"1asf发"];
        int i6=[CC_Validate isPureLetter:@"1asf"];
        int i7=[CC_Validate isPureLetter:@"水电费"];
        int i8=[CC_Validate isPureLetter:@"123"];
        
        
        NSString *iiii=[ccs getKeychainUUID];
        
        int v1=[CC_Logic compareV1:@"1.3" cutV2:@"1.2.1"];
        //    int v2=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3.2"];
        //    int v3=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3.3"];
        int v2=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.2"];
        int v3=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3"];
        int v4=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.4"];
        
        NSDate *d1=[NSDate date];
        CCLOG(@"d1=%@",d1);
        [ccs delay:.5 block:^{
            NSDate *d2=[NSDate date];
            CCLOG(@"d2=%@",d2);
            NSTimeInterval d3=[CC_Date compareDate:d2 cut:d1]*1000;
            CCLOG(@"d3=%f",d3);
        }];
        
        int i=[CC_Validate hasChinese:@""];
        
        float f1=1.25;
        float f2=1.24;
        float f3=1.26;
        float f4=1.35;
        float f5=1.34;
        float f6=1.36;
        CCLOG(@"%.1f %.1f %.1f    %.1f %.1f %.1f",f1,f2,f3,f4,f5,f6);
        NSDecimalNumberHandler *handel=[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:6 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:@"1.25"];
        NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:@"2"];
        
        NSDecimalNumber *aDN = [[NSDecimalNumber alloc] initWithFloat:0.125532];
        NSDecimalNumber *resultDN = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        NSString *str=[NSString stringWithFormat:@"%@",resultDN];
        NSString *str1=[NSString stringWithFormat:@"1.254"];
        str1=[str1 getDecimalStrWithMode:NSRoundPlain scale:1];
        CCLOG(@"%@ %@ %@",resultDN,str,str1);
    }
    
    //    //死锁
    //    NSLog(@"1");
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    //        // 回到主线程进行UI操作
    //        NSLog(@"4");
    //    });
    //    NSLog(@"5");
    
    //黑底白字提示
    [CC_Notice show:@"黑底白字提示~"];
    
    //加载中Mask
    [[CC_Mask getInstance]setText:@"加载中"];
    [[CC_Mask getInstance]start];
    //...
    [[CC_Mask getInstance]stop];
    
    //加载中纯文字
    [[CC_Loading getInstance]setText:@"加载中"];
    [[CC_Loading getInstance]start];
    //...
    [[CC_Loading getInstance]stop];
    
    
    //CC_HookTrack 路径跟踪开启 app启动时开启一次
    [CC_HookTrack catchTrack];
    //获取此时刻调用的前三个方法名
    NSString *actions=[CC_HookTrack getInstance].triggerActionStr;
    //目前所在控制器名
    NSString *currentVCStr=[CC_HookTrack getInstance].currentVCStr;
    //堆栈中所有的控制器名字们
    NSArray *lastVCs=[CC_HookTrack getInstance].lastVCs;
    //记录控制器进出的记录 ViewController1-pushTo-ViewController2
    NSString *pushPopActionStr=[CC_HookTrack getInstance].pushPopActionStr;
    
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
        CC_Button *button=[[CC_Button alloc]initWithFrame:CGRectMake(0, [ccui getRH:200], RH(100), [ccui getRH:100])];
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
    
    [ccs delay:1.1 block:^{
        
    }];
    
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
}

- (NSString *)utf8ToUnicode:(NSString *)string{
    
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

@end
