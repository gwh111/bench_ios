//
//  testHttpCodeVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testHttpCodeVC.h"
#import "CC_HttpEncryption.h"

@interface testHttpCodeVC ()

@end

@implementation testHttpCodeVC

- (NSString *)encodeParameter:(NSString *)originalPara{
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)originalPara, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[CC_HttpTask getInstance] setRequestHTTPHeaderFieldDic:@{@"":@""}];
    [[CC_HttpTask getInstance] setEncryptDomain:@"http://192.168.2.213/client/service.json?"];
    //http://192.168.2.213
    //@"http://mapi1.kkbuluo.net/client/service.json?"
    CC_HttpEncryption *encryption=[[CC_HttpEncryption alloc]init];
    [encryption prepare:^() {
        NSDictionary *paraDic=@{@"service":@"GO_TO_H5",
                                @"authedUserId":@"10004002198209112100290980132555",
                                @"h5Address":@"FAME_USER",
                                };
        [[CC_HttpTask getInstance]post:@"http://192.168.2.213/client/service.json?" params:paraDic model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
            
            if (error) {
                [CC_Note showAlert:error];
            }
            
            NSString *gotoUrl=result.resultDic[@"response"][@"gotoUrl"];
            CCLOG(@"%@",gotoUrl);
            
//            [[CC_HttpTask getInstance]post:@"http://mapi1.kkbuluo.net/client/service.json?" params:paraDic model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
//                
//                if (error) {
//                    [CC_Note showAlert:error];
//                }
//                
//                NSString *gotoUrl=result.resultDic[@"response"][@"gotoUrl"];
//                CCLOG(@"%@",gotoUrl);
//            }];
        }];
    }];
    return;
    {
        NSString *t=@"123";
        
        NSString *cstr=@"abc";
        NSData *ciphertextdata = [CC_Convert strToData_utf8:cstr];
        NSData *encodedata=[CC_AES encryptWithKey:@"1234123412341234" iv:t data:ciphertextdata];
        
        NSData *aesdata=[CC_AES decryptWithKey:@"1234123412341234" iv:t data:encodedata];
        
        NSString *aesdatastr22=[[NSString alloc] initWithData:aesdata encoding:NSUTF8StringEncoding];
        CCLOG(@"%@",aesdatastr22);
        
    }
    
    NSString *uuid=[ccs getKeychainUUID];
    CCLOG(@"%@ %lu",uuid,(unsigned long)uuid.length);
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    NSMutableString *timeMutSp=[[NSMutableString alloc]initWithString:timeSp];
    if (timeSp.length<16) {
        NSUInteger cut=16-timeSp.length;
        
    }
    timeSp=@"1555925958859529";
    CCLOG(@"%@",timeSp);
    CCLOG(@"%@",[CC_Convert intToData:36]);
    NSData *uuidData = [uuid dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *aescode=@"1234123412341234";
    aescode=@"rk7sdes48u0t5nlu";
    
    //zhouyi 259b4f14-33a2-4a7e-ac65-a9cb102c5facffffffffaaaaaaaa
    //ziji   D00D2DF5-34CC-4F15-B223-D328138448791234123412341234
    NSString *encs=[NSString stringWithFormat:@"%@%@",uuid,aescode];
    NSString *rsastr=[CC_RSA encryptStr:encs publicKey:@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0o6xAFiJ/hKoTPx9GmrRRx7aEyQtfz/KTJ5Ehvvj6C/PGkP0LHZTG8nhhH8NMWu32uIvxv1NMqVLujhtupIyAXILqEM85Fbd4aXtHwOLlrfG1F5xokbYGoi+7dIvy0sgpSvyXJO/GBlxOeblxudpQuLAKxLCSqG97AfcJ0WSJKxH2EyLB/s8NNl/vnQet0PS3MsUR6KjKkOa4J4YxAoRozysTV7O7qvjjT/dNOoLJfgpR85Z9nRue8oCELJRVVjA/85QNkIjXQypa9va/XITq6DSHuVS1dvS9+m8zetg5OWeI9niS1uMGkPdLe6kI8zVu64bje413YyUeXMFwjN3lwIDAQAB"];
    
    NSString *rsastr2=[self encodeParameter:rsastr];
    
    //    NSData *data111 =[rsastr dataUsingEncoding:NSUTF8StringEncoding];
    //    //2、对二进制数据进行base64编码，完成后返回字符串
    //    rsastr=[data111 base64EncodedStringWithOptions:0];
    //测试数据
    
//    这几个接口不用加密其他都要加密
//    TEST(null, false, null, false, "测试服务"),
//    CLIENT_KEY_DOWNLOAD(null, false, null, false, "客户端请求下载RSA秘钥"),
//    AES_SERCRET_KEY_UPDATE(null, false, null, false, "aes秘钥更新接口"),
//    IMAGE_TEMP_UPLOAD(ClientServiceSortEnum.SYSTEM, true, SignVerifyTypeEnum.BY_USER, false, "图片上传"),
    NSString *aesencodestr=[NSString stringWithFormat:@"authedUserId=10004002198209112100290980132555&service=GO_TO_H5&h5Address=FAME_USER&timestamp=%@",timeSp];
    //    NSData *aesdata=[CC_AES encryptData:[aesencodestr dataUsingEncoding:NSUTF8StringEncoding] key:[aescode dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *aesdata=[CC_AES encryptWithKey:aescode iv:timeSp data:[aesencodestr dataUsingEncoding:NSUTF8StringEncoding]];
//    aesdata=[aesdata base64EncodedDataWithOptions:0];
    NSString *aesdatastr=[[NSString alloc] initWithData:aesdata encoding:NSUTF8StringEncoding];
    
    //[data base64EncodedDataWithOptions:0]
    
    NSMutableData *mutData=[[NSMutableData alloc]init];
    [mutData appendData:[CC_Convert intToData:36]];//uuid length
    [mutData appendData:uuidData];//uuid
    [mutData appendData:[CC_Convert intToData:(int)aesdata.length]];//code length
    [mutData appendData:aesdata];//code
    [mutData appendData:[CC_Convert intToData:(int)timeSp.length]];//time length
    [mutData appendData:[timeSp dataUsingEncoding:NSUTF8StringEncoding]];//time
    
    NSString *codeStr=[CC_Convert dataToStr_base64:mutData];
    //    [CC_Share getInstance].dataaaa=mutData;
    
        [CC_HttpTask getInstance].forbiddenTimestamp=YES;
//    [[CC_HttpTask getInstance]setEncrypt:YES];
        [[CC_HttpTask getInstance]post:@"http://192.168.2.213/client/service.json?" params:@{@"ciphertext":codeStr} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
            if (error) {
                return ;
            }
            NSString *ciphertext=result.resultDic[@"response"][@"ciphertext"];
            
            NSData *ciphertextdata = [CC_Convert strToData_base64:ciphertext];
            
            NSString *nowTimestamp=[NSString stringWithFormat:@"%@",result.resultDic[@"response"][@"nowTimestamp"]];
            nowTimestamp=[self polishingStr:nowTimestamp];
            NSData *aesdata=[CC_AES decryptWithKey:aescode iv:nowTimestamp data:ciphertextdata];
    
            NSString *aesdatastr22=[[NSString alloc] initWithData:aesdata encoding:NSUTF8StringEncoding];
            NSDictionary *dic=[CC_Convert dictionaryWithJsonString:aesdatastr22];
    
            NSLog(@"f");
    
        }];
    //    return;
    {
        
        NSString *temp=uuid;
        NSData *datatemp =[temp dataUsingEncoding:NSUTF8StringEncoding];
        int datatemplength =CFSwapInt32BigToHost((uint32_t)datatemp.length);
        NSData *data = [NSData dataWithBytes: &datatemplength length: sizeof(datatemplength)];
        NSMutableData *result=[[NSMutableData alloc]init];
        [result appendData:data];
    }
    
    
}

- (NSString *)polishingStr:(NSString*)oldStr{
    
    NSInteger length = oldStr.length;
    if (length >= 16) {
        return oldStr;
    }else if (length == 0) {
        return @"";
    }else{
        NSMutableString* newStr = oldStr.mutableCopy;
        
        for (NSInteger i = length - 1; i >= (length*2-16); i --) {
            unichar character = [oldStr characterAtIndex:i];
            [newStr appendFormat:@"%c",character];
        }
        return [newStr copy];
    }
}

@end
