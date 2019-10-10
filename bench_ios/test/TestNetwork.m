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
//    [ccs configureDomainWithReqGroupList:@[@[@"http://sssynout-eh-resource.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.kkjk123.com/eh_url.txt"],@[@"http://test-onlinetreat.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.onlinetreat.net/eh_url.txt"]]
//                                  andKey:@"eh_doctor_api"
//                                   cache:NO
//                                pingTest:YES
//                                   block:^(HttpModel *result) {
//                                       
//                                       HttpModel *model = [[HttpModel alloc]init];
//                                       model.forbiddenJSONParseError = YES;
//                                       [ccs.httpTask get:@"https://www.jianshu.com/p/a1ec0db3c710" params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {
//                                           
//                                       }];
//                                       
//                                   }];
    
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
    
    [[ccs httpTask]uploadFileWithPath:@"" params:@{@"key":@"value"} progress:^(double progress) {
        
    } finishHandler:^(NSString *error, NSDictionary *result) {
        
    }];
    
    [[ccs httpTask]uploadFileData:nil fileName:@"fileName" url:nil mimeType:nil params:nil progress:^(double progress) {
        
    } finishHandler:^(NSString *error, NSDictionary *result) {
        
    }];
    
    [[ccs httpTask]downloadDataWithUrl:@"" progress:^(double progress) {
        
    } finishHandler:^(NSError *error, NSDictionary *result) {
        
    }];
    
    
}



@end
