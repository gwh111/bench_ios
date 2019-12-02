//
//  CC_HttpManager.m
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_HttpHelper.h"
#import "Reachability.h"
#import "CC_HttpTask.h"
#import "CC_Notice.h"
#import "CC_BenchUpdate.h"
#import "CC_Base.h"

@interface CC_HttpHelper (){
    NSArray *tempDomainReqList;
    NSString *tempDomainReqKey;
    BOOL tempCache;
    BOOL tempPingTest;
    void (^tempDomainBlock)(HttpModel *result);
    int tempReqIndex;
    int tempReqCount;
}
@property (nonatomic, strong) NSMutableArray *sessionArr;

@end
@implementation CC_HttpHelper

static NSString *DOMAIN_TAG_KEY = @"cc_domainTag";
static NSString *DOMAIN_DEFAULT_KEY = @"cc_domainDic";

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        
    }];
}

- (instancetype)init {
    if (self = [super init]) {
        self.sessionArr = @[].mutableCopy;
        self.stopSession = YES;
    }
    return self;
}

- (void)addURLSession:(NSURLSession *)session {
    [self.sessionArr addObject:session];
}

- (void)cancelURLSession:(NSURLSession *)session {
    [session invalidateAndCancel];
    [self.sessionArr removeObject:session];
    CCLOG(@"取消%@session",session);
}

- (void)cancelAllSession{
    for (NSURLSession *session in _sessionArr) {
        [session invalidateAndCancel];
        [_sessionArr removeObject:session];
    }
    CCLOG(@"取消所有session");
}

- (BOOL)isNetworkReachable {
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

- (void)domainWithReqList:(NSArray *)domainReqList block:(void (^)(HttpModel *result))block {
    __block int tag = 0;
    // 如果安装环境不是内网 一定是线上包
    HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
    model.timeoutInterval = 2;
    [CC_HttpTask.shared get:BENCH_IOS_NET_TEST_URL params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
        // tag = 0 线上
        // tag = 1 主干
        // tag = 2 分支1
        // ...
        if ([result.resultStr containsString:BENCH_IOS_NET_TEST_CONTAIN]) {
            // net environment
            tag = CC_Base.shared.cc_environment;
        }else{
            tag = 0;
        }
        NSString *domain = domainReqList[tag];
        HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
        model.resultDic = @{@"domain":domain};
        model.resultStr = domain;
        block(model);
    }];
}

- (void)domainWithReqGroupList:(NSArray *)domainReqGroupList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block {
    
    if (![self isNetworkReachable]) {
        tempReqCount++;
        if (tempReqCount % 3 == 0) {
            [CC_Notice.shared showNotice:@"网络权限被关闭，不能获取网络"];
        }
        [CC_CoreThread.shared cc_delay:3 block:^{
            [self domainWithReqGroupList:(NSArray *)domainReqGroupList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block];
        }];
        return;
    }
    
    tempDomainReqKey = domainReqKey;
    tempCache = cache;
    tempPingTest = pingTest;
    tempDomainBlock = block;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CCDomainLaunchNotification
                                                        object:domainReqGroupList];
    
    __block int tag = 0;
    if ([CC_DefaultStore cc_default:DOMAIN_TAG_KEY] && tempCache) {
        tag = [[CC_DefaultStore cc_default:DOMAIN_TAG_KEY]intValue];
        tempDomainReqList = domainReqGroupList[tag];
        if (tag > 0) {
            [CC_BenchUpdate checkUpdate];
        }
        [self getDomain];
    } else {
        // 如果安装环境不是内网 一定是线上包
        HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
        model.timeoutInterval = 2;
        [CC_HttpTask.shared get:BENCH_IOS_NET_TEST_URL params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
            // tag = 0 线上
            // tag = 1 主干
            // tag = 2 分支1
            // ...
            if ([result.resultStr containsString:BENCH_IOS_NET_TEST_CONTAIN]) {
                // net environment
                tag = CC_Base.shared.cc_environment;
            }else{
                tag = 0;
            }
            self->tempDomainReqList = domainReqGroupList[tag];
            [CC_DefaultStore cc_saveDefault:DOMAIN_TAG_KEY value:@(tag)];
            if (tag > 0) {
                [CC_BenchUpdate checkUpdate];
            }
            [self getDomain];
        }];
    }
}

- (HttpModel *)commonModel:(HttpModel *)model url:(id)url params:(id)params configure:(CC_HttpConfig *)configure type:(CCHttpTaskType)type {
    if (!model) {
        model = [CC_Base.shared cc_init:HttpModel.class];
    }
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl = url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl = [NSURL URLWithString:url];
        if (configure.httpRequestType == CCHttpRequestTypeMock) {
            if (CC_Base.shared.cc_environment == 0) {
                tempUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", url,  model.mockRequestPath]];
            }
        }
    }else{
        CCLOG(@"url 不合法");
    }
    model.requestDomain = tempUrl;
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        params = [[NSMutableDictionary alloc]initWithDictionary:params];
    }
    if (!model) {
        model = [CC_Base.shared cc_init:HttpModel.class];
    }
    model.service = params[@"service"];
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
    for (int i = 0; i < keys.count; i++) {
        [params setObject:configure.extreParameter[keys[i]] forKey:keys[i]];
    }
    if (!configure.signKeyStr) {
        if (model.debug) {
            CCLOG(@"_signKeyStr为空");
        }
    }
    model.requestParams = params;
    
    NSString *paraStr;
    if (configure.headerEncrypt && model.forbiddenEncrypt == NO && [configure.encryptDomain isEqualToString:tempUrl.absoluteString]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        Class clazz = NSClassFromString(@"CC_HttpEncryption");
        
        NSString *ciphertext = [clazz performSelector:@selector(getCiphertext:httpTask:) withObject:params withObject:self];
        params = @{@"ciphertext":ciphertext};
#pragma clang diagnostic pop
        paraStr = [CC_String cc_MD5SignWithDic:params andMD5Key:nil];
    }else{
        paraStr = [CC_String cc_MD5SignWithDic:params andMD5Key:configure.signKeyStr];
    }
    model.requestParamsStr = paraStr;
    
    return model;
}

- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString model:(HttpModel *)model configure:(CC_HttpConfig *)configure type:(CCHttpTaskType)type {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.URL = url;
    if (type == CCHttpTaskTypeGet) {
        if (paramsString) {
            request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",url.absoluteString,paramsString]];
        }
    }else if (type != CCHttpTaskTypeRequest) {
        
        if (configure.httpRequestType == CCHttpRequestTypeMock) {
            
            if (model.requestParams) {
                NSData *data= [NSJSONSerialization dataWithJSONObject:model.requestParams options:NSJSONWritingPrettyPrinted error:nil];
                request.HTTPBody = data;
            }
        } else {

            request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    if (type == CCHttpTaskTypeGet) {
        [request setHTTPMethod:@"GET"];
    } else {
        [request setHTTPMethod:@"POST"];
    }
    if (model.timeoutInterval > 0) {
        [request setTimeoutInterval:model.timeoutInterval];
    }else{
        [request setTimeoutInterval:configure.httpTimeoutInterval];
    }
    if (model && model.forbiddenEncrypt == NO) {
        if (configure.headerEncrypt) {
            [request setValue:[NSString stringWithFormat:@"%d",configure.headerEncrypt] forHTTPHeaderField:@"encrypt"];
        }
    }
    if (!configure.httpHeaderFields) {
        CCLOG(@"没有设置_requestHTTPHeaderFieldDic");
        return request;
    }
    if (configure.httpRequestType == CCHttpRequestTypeMock) {
        [request setValue:model.mockRequestPath forHTTPHeaderField:@"Web-Exterface-RequestPath"];
        [request setValue:model.mockAppCode forHTTPHeaderField:@"Web-Exterface-AppCode"];
        [request setValue:model.mockSourceVersion forHTTPHeaderField:@"Web-Exterface-SourceVersion"];
        [request setValue:model.mockExterfaceVersion forHTTPHeaderField:@"Web-Exterface-ExterfaceVersion"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    NSArray *keys = [configure.httpHeaderFields allKeys];
    for (int i = 0; i < keys.count; i++) {
        [request setValue:configure.httpHeaderFields[keys[i]] forHTTPHeaderField:keys[i]];
    }
    return request;
}

#pragma mark private
- (void)getDomain {
    NSString *urlStr = tempDomainReqList[tempReqIndex];
    int updateInBackGround = NO;
    
    id domanDefault = [CC_DefaultStore cc_default:DOMAIN_DEFAULT_KEY];
    if (domanDefault && tempCache) {
        HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
        model.resultDic = domanDefault;
        tempDomainBlock(model);
        //后台更新domain
        updateInBackGround = YES;
    }
    tempReqCount = 0;
    HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
    model.forbiddenEncrypt = YES;
    [CC_HttpTask.shared get:urlStr params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            if (self->tempReqCount % 5 == 0) {
                //几秒后提示 是网络没有打开的提示还是网络打开了但是域名请求失败的提示
                if ([self isNetworkReachable]) {
                    [CC_Notice.shared showNotice:@"域名请求失败"];
                }else{
                    [CC_Notice.shared showNotice:@"网络权限被关闭，不能获取网络"];
                }
            }
            //多个备用域名请求链接
            self->tempReqCount++;
            self->tempReqIndex++;
            if (self->tempReqIndex >= self->tempDomainReqList.count) {
                self->tempReqIndex = 0;
            }
            [CC_CoreThread.shared cc_delay:0.5 block:^{
                [self getDomain];
            }];
            return;
        }
        
        // 成功获取域名请求
        NSString *domanKey = result.resultDic[self->tempDomainReqKey];
        if (!domanKey) {
            if (!updateInBackGround) {
                [CC_Notice.shared showNotice:@"域名获取失败"];
            }
        }
        if (!self->tempPingTest) {
            // 不需要校验
            [self finishResult:result updateInBackGround:updateInBackGround];
            return;
        }
        domanKey = [NSString stringWithFormat:@"%@%@",domanKey,BENCH_IOS_NET_TEST_SERVICE];
        // 验证url可请求成功
        [CC_HttpTask.shared get:domanKey params:nil model:nil finishBlock:^(NSString *error2, HttpModel *result2) {
            if (result2.parseFail == 1 || error2) {
                if (!updateInBackGround) {
                    [CC_Notice.shared showNotice:@"服务器开小差了"];
                }
                self->tempReqCount++;
                self->tempReqIndex++;
                if (self->tempReqIndex >= self->tempDomainReqList.count) {
                    self->tempReqIndex = 0;
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

- (void)finishResult:(HttpModel *)result updateInBackGround:(BOOL)updateInBackGround {
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

NSNotificationName const CCDomainLaunchNotification  = @"CCDomainLaunchNotification";
NSNotificationName const CCDomainChangedNotification = @"CCDomainChangedNotification";
NSNotificationName const CCDomainDoneNotification    = @"CCDomainDoneNotification";
