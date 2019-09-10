//
//  CC_HttpManager.m
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_HttpManager.h"
#import "Reachability.h"
#import "CC_HttpTask.h"
#import "CC_Notice.h"

#ifdef CCBUILDTAG
#   define CCBUILDTAG2 CCBUILDTAG
#else
#   define CCBUILDTAG2 0
#endif

@interface CC_HttpManager (){
    NSArray *tempDomainReqList;
    NSString *tempDomainReqKey;
    BOOL tempCache;
    BOOL tempPingTest;
    void (^tempDomainBlock)(ResModel *result);
    int tempReqIndex;
    int tempReqCount;
}

@end
@implementation CC_HttpManager

static NSString *DOMAIN_DEFAULT_KEY = @"cc_domainDic";
static NSString *DOMAIN_TEST_SERVICE = @"/client/service.json?service=TEST";// 测试域名是否可用的服务端地址

- (BOOL)cc_isNetworkReachable{
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
#ifndef __OPTIMIZE__
    switch (netStatus) {
        case NotReachable:
            CCLOG(@"Network is not reachable");
            break;
        case ReachableViaWiFi:
            CCLOG(@"Network is WiFi");
            break;
        case ReachableViaWWAN:
            CCLOG(@"Network is WWAN");
            break;
        default:
            break;
    }
#endif
    if(netStatus == NotReachable) {
        return NO;
    }
    return YES;
}

- (void)cc_domainWithReqList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(ResModel *result))block{
    if (CCBUILDTAG2==0) {
        if (DEBUG && domainReqList.count>1) {
            tempDomainReqList = domainReqList[1];
        }else{
            tempDomainReqList = domainReqList.firstObject;
        }
    }else{
        tempDomainReqList = domainReqList[CCBUILDTAG2];
    }
    tempDomainReqList = domainReqList;
    tempDomainReqKey = domainReqKey;
    tempCache = cache;
    tempPingTest = pingTest;
    tempDomainBlock = block;
    [self getDomain];
}

- (ResModel *)cc_commonModel:(ResModel *)model url:(id)url params:(id)params configure:(CC_HttpConfigure *)configure type:(CCHttpTaskType)type{
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl=url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl=[NSURL URLWithString:url];
    }else{
        CCLOG(@"url 不合法");
    }
    if ([params isKindOfClass:[NSDictionary class]]) {
        params = [[NSMutableDictionary alloc]initWithDictionary:params];
    }
    
    if (!model) {
        model = [CC_Base.shared cc_init:ResModel.class];
    }
    model.serviceStr = params[@"service"];
    model.headerEncrypt = configure.headerEncrypt;//设置这次请求是否为加密请求
    if (model.forbiddenEncrypt) {
        model.headerEncrypt = NO;
    }
    
    if (configure.forbiddenTimestamp == NO ||
        model.forbiddenEncrypt == YES) {
        if (!params[@"timestamp"]) {
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
            [params cc_setKey:@"timestamp" value:timeSp];
        }
    }
    NSArray *keys = [configure.extreParameter allKeys];
    for (int i = 0; i <keys.count; i++) {
        [params setObject:configure.extreParameter[keys[i]] forKey:keys[i]];
    }
    
    if (!configure.signKeyStr) {
        if (model.debug) {
            CCLOG(@"_signKeyStr为空");
        }
    }
    
    model.requestDic = params;
    return model;
}

#pragma mark private
- (void)getDomain{
    NSString *urlStr = tempDomainReqList[tempReqIndex];
    int updateInBackGround = NO;
    
    id domanDefault = [CC_DefaultStore cc_default:DOMAIN_DEFAULT_KEY];
    if (domanDefault && tempCache) {
        ResModel *model = [CC_Base.shared cc_init:ResModel.class];
        model.resultDic = domanDefault;
        tempDomainBlock(model);
        //后台更新domain
        updateInBackGround = YES;
    }
    ResModel *model = [CC_Base.shared cc_init:ResModel.class];
    model.forbiddenEncrypt = YES;
    [[CC_HttpTask shared]get:urlStr params:nil model:model finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            if (tempReqCount % 5 == 0) {
                //几秒后提示 是网络没有打开的提示还是网络打开了但是域名请求失败的提示
                if ([self cc_isNetworkReachable]) {
                    [CC_Notice showNoticeStr:@"域名请求失败"];
                }else{
                    [CC_Notice showNoticeStr:@"网络权限被关闭，不能获取网络"];
                }
            }
            //多个备用域名请求链接
            tempReqCount++;
            tempReqIndex++;
            if (tempReqIndex >= tempDomainReqList.count) {
                tempReqIndex = 0;
            }
            [CC_CoreThread.shared cc_delay:0.5 block:^{
                [self getDomain];
            }];
            return;
        }
        
        // 成功获取域名请求
        NSString *domanKey=result.resultDic[tempDomainReqKey];
        if (!domanKey) {
            if (!updateInBackGround) {
                [CC_Notice showNoticeStr:@"域名获取失败"];
            }
        }
        if (!tempPingTest) {
            // 不需要校验
            [self finishResult:result updateInBackGround:updateInBackGround];
            return;
        }
        domanKey = [NSString stringWithFormat:@"%@%@",domanKey,DOMAIN_TEST_SERVICE];
        // 验证url可请求成功
        [[CC_HttpTask shared]get:domanKey params:nil model:nil finishCallbackBlock:^(NSString *error2, ResModel *result2) {
            if (result2.parseFail == 1 || error2) {
                if (!updateInBackGround) {
                    [CC_Notice showNoticeStr:@"服务器开小差了"];
                }
                tempReqCount++;
                tempReqIndex++;
                if (tempReqIndex >= tempDomainReqList.count) {
                    tempReqIndex = 0;
                }
                [CC_CoreThread.shared cc_delay:0.5 block:^{
                    [self getDomain];
                }];
            }else{
                [self finishResult:result updateInBackGround:updateInBackGround];
            }
        }];
    }];
}

- (void)finishResult:(ResModel *)result updateInBackGround:(BOOL)updateInBackGround{
    id domanDefault = [CC_DefaultStore cc_default:DOMAIN_DEFAULT_KEY];
    int change = 0;
    if (domanDefault) {
        NSArray *keys = [domanDefault allKeys];
        for (int i = 0; i < keys.count; i++) {
            NSString *name = keys[i];
            NSString *value = domanDefault[name];
            NSString *newValue = result.resultDic[name];
            if (newValue) {
                if (![newValue isEqualToString:value]) {
                    change = 1;
                }
            }
        }
    }
    [CC_DefaultStore cc_saveDefault:DOMAIN_DEFAULT_KEY value:result.resultDic];
    if (!updateInBackGround || change) {
        tempDomainBlock(result);
    }
}

@end
