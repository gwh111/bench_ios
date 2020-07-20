//
//  testNetwork.m
//  testbenchios
//
//  Created by gwh on 2019/8/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestNetwork.h"
#import "CC_HttpTask.h"

@implementation TestNetwork

+ (void)start {
    
    {
        NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
            [ccs.httpTask post:@"https://apple@huored.gicp.net:8088/svn/bench_ios/trunk/bench_ios_net/bench_ios" params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
                
                NSLog(@"b");
            }];
        }];
        NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
            [ccs.httpTask post:@"https://apple@huored.gicp.net:8088/svn/bench_ios/trunk/bench_ios_net/bench_ios" params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
                
                NSLog(@"a");

            }];
        }];
        [ccs.httpHelper.httpQueue addOperation:op1];
        [ccs.httpHelper.httpQueue addOperation:op2];

        
    }
    return;
    
    [ccs.httpTask.configure.extreParameter cc_setKey:@"authUserId" value:@"10204007036655152100290032039588"];
    [ccs.httpTask.configure.extreParameter cc_setKey:@"loginKey" value:@"USL0a731d8b1c9f4008b9695ee4be00d981"];
    
    ccs.httpTask.configure.encryptDomain = @"http://192.168.2.32";
    ccs.httpTask.configure.encryptDomain = @"http://mapi.haichi.net";
    
    CC_HttpEncryption *encryption = ccs.httpEncryption;
    [encryption prepare:^{
        //1.生成AESCode，并保存
        //2.获取RSAPublicKey
        //3.使用RSAPublicKey加密AESCode，并上传服务端
        //4.每次请求使用AESCode对请求参数进行加密
        [CC_HttpTask shared].configure.headerEncrypt = NO;
        
        // 配置全局请求为mock方式
        CC_HttpConfig *httpConf = ccs.httpTask.configure;
        httpConf.httpRequestType = CCHttpRequestTypeMock;
        // 忽略错误 mock会返回error
        httpConf.ignoreMockError = YES;
        
        //加密配置完成
        NSString *service = [ccs string:@"%@/%@", @"activity", @"bannerQuery"];
//        service = @"user/myInComeAndFansDetailQuery";
        service = @"account/userAccountAmountQuery";
        
        HttpModel *model = ccs.httpModel;
        model.mockExterfaceVersion = @"1";
        model.mockSourceVersion = @"1.3";
        model.mockAppCode = @"hc.user.api.mobile.base";
        model.mockRequestPath = service;
        
        NSMutableDictionary *parameters = ccs.mutDictionary;
        [parameters cc_setKey:@"service" value:service];
        [parameters cc_setKey:@"projectId" value:@"123"];
        
        model.requestParams = parameters;
        
        for (int i = 0; i < 1; i++) {
            [ccs.httpTask post:@"http://mapi.haichi.net/web/exterface/execute" params:parameters model:model finishBlock:^(NSString *error, HttpModel *result) {
                
                [ccs maskStop];
                if (error) {
                    return;
                }
                
            }];
        }
        
        
    }];
    
    return;
    NSString *tmpStr = @"apple:Gwh199099";
    NSData *data = [tmpStr dataUsingEncoding:NSUTF8StringEncoding];
    id s2 = [data base64EncodedStringWithOptions:0];
    ccs.httpTask.configure.forbiddenTimestamp = YES;
    [ccs.httpTask.configure.httpHeaderFields cc_setKey:@"Authorization" value:[ccs string:@"Basic %@",s2]];
    [ccs.httpTask post:@"https://apple@huored.gicp.net:8088/svn/bench_ios/trunk/bench_ios_net/bench_ios" params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
        
        NSLog(@"error");
        
        
    }];
    return;
    
    ccs.httpTask.configure.signKeyStr = nil;
    ccs.httpTask.configure.extreParameter = nil;
    NSDictionary *params = @{@"cell":@"18639963996",@"service":@"REGISTER_SEND_SMS_ACK",@"timestamp":@"1577348071620"};
    [ccs.httpTask post:@"http://user1-mapi.yimei.net/client/service.json?" params:params model:nil finishBlock:^(NSString *error, HttpModel *result) {

        
        
    }];

    return;
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    return;
    
    [ccs configureDomainWithReqGroupList:@[@[@"http://sssynout-eh-resource.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.kkjk123.com/eh_url.txt"],@[@"http://test-onlinetreat.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.onlinetreat.net/eh_url.txt"]]
                                  andKey:@"eh_doctor_api"
                                   cache:NO
                                pingTest:YES
                                   block:^(HttpModel *result) {

                                       HttpModel *model = [[HttpModel alloc]init];
    model.forbiddenEncrypt = YES;
                                       model.forbiddenJSONParseError = YES;
                                       [ccs.httpTask get:@"https://www.jianshu.com/p/a1ec0db3c710" params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {

                                       }];

                                   }];
    
//    [ccs.imageView cc_setImageWithURL:[NSURL URLWithString:@""]];
    [ccs.httpTask get:@"https://www.baidu.com" params:@{@"key":@"value"} model:nil finishBlock:^(NSString *error, HttpModel *result) {
        
    }];
    
    //修改configure
    CC_HttpConfig *configure = ccs.httpTask.configure;
    configure.signKeyStr = @"xxx";
    
    ccs.httpTask.configure = configure;
    
    CC_HttpTask *c = [ccs init:CC_HttpTask.class];
    
    
}

- (void)testNetworkApi{
    
//    [[CC_HttpTask getInstance] post:@"" params:@{@"service":@"TESTAPI"} model:nil finishCallbackBlock:^(NSString *error, ResModel *resModel) {
//    }];
    
    [[ccs httpTask]post:@"" params:@{@"service":@"TESTAPI"} model:nil finishBlock:^(NSString *error, HttpModel *result) {
    }];
    
//    [[CC_HttpTask getInstance] get:@"" params:@{@"service":@"TESTAPI"} model:nil finishCallbackBlock:^(NSString *error, ResModel *resModel) {
//    }];
    
    [[ccs httpTask]get:@"" params:@{@"service":@"TESTAPI"} model:nil finishBlock:^(NSString *error, HttpModel *result) {
    }];
    
    [ccs.httpTask imageUpload:@[IMAGE(@"abc")] url:[NSURL URLWithString:@"xxx"] params:nil imageSize:1024 reConnectTimes:3 finishBlock:^(NSArray<HttpModel *> *errorModelArr, NSArray<HttpModel *> *successModelArr) {
        
    }];
    
    [ccs.httpTask imageUpload:@[IMAGE(@"abc")] url:[NSURL URLWithString:@"xxx"] params:nil imageScale:0.3 reConnectTimes:3 finishBlock:^(NSArray<HttpModel *> *errorModelArr, NSArray<HttpModel *> *successModelArr) {
        
    }];
    
    UIImageView *imgV = ccs.ImageView;
    imgV.showProgressView = YES;
    
    [ccs.httpEncryption prepare:^{
        
    }];
    
    [ccs.tool MD5SignWithDic:@{@"key":@"value"} andMD5Key:@"abc123"];
    [CC_MD5Object signString:@""];
    
    
}



@end
