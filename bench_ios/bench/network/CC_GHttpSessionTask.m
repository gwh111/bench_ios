//
//  GHttpSessionTask.m
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CC_GHttpSessionTask.h"
#import "CC_FormatDic.h"
#import "CC_Share.h"
#import "CC_RequestRecordTool.h"
#import "CC_ResponseLogicModel.h"
#import "CC_HookTrack.h"
#import "Reachability.h"

@interface CC_HttpTask()
/**
 *  统一处理回调合集
 */
@property(nonatomic,retain) NSMutableArray *logicMutArr;

@end

@implementation CC_HttpTask
@synthesize finishCallbackBlock;

static CC_HttpTask *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_HttpTask alloc] init];
        [instance initBase];
    });
    return instance;
}

- (void)initBase{
    _httpTimeoutInterval=10;
    _forbiddenSendHookTrack=1;
    _static_domainTestKey=@"/client/service.json?service=TEST";
    _static_pingThirdWebUrl=@"http://www.baidu.com";
    _static_netTestUrl=@"http://d.net/";
    _static_configureUrl=@"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json";
    _static_netTestContain=@"http://d.net";
}

#pragma mark network
- (BOOL)isNetworkReachable{
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
#ifndef __OPTIMIZE__
    switch (netStatus) {
        case NotReachable:
            NSLog(@"Network is not reachable");
            break;
        case ReachableViaWiFi:
            NSLog(@"Network is WiFi");
            break;
        case ReachableViaWWAN:
            NSLog(@"Network is WWAN");
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

- (void)setRequestHTTPHeaderFieldDic:(id)requestHTTPHeaderFieldDic{
    if ([requestHTTPHeaderFieldDic isKindOfClass:[NSDictionary class]]) {
        _requestHTTPHeaderFieldDic=[[NSMutableDictionary alloc]initWithDictionary:requestHTTPHeaderFieldDic];
    }else if ([requestHTTPHeaderFieldDic isKindOfClass:[NSMutableDictionary class]]){
        _requestHTTPHeaderFieldDic=requestHTTPHeaderFieldDic;
    }else{
        CCLOG(@"requestHTTPHeaderFieldDic 格式错误 只允许 NSDictionary or NSMutableDictionary");
    }
}

- (id)requestHTTPHeaderFieldDic{
    return _requestHTTPHeaderFieldDic;
}

- (void)post:(id)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block{
    [self request:url Params:paramsDic model:model FinishCallbackBlock:^(NSString *error, ResModel *result) {
        block(error,result);
    } type:0];
}

- (void)get:(id)url params:(id)paramsDic model:(ResModel *)model finishCallbackBlock:(void (^)(NSString *, ResModel *))block{
    [self request:url Params:paramsDic model:model FinishCallbackBlock:^(NSString *error, ResModel *result) {
        block(error,result);
    } type:1];
}

- (void)request:(id)url Params:(id)paramsDic model:(ResModel *)model FinishCallbackBlock:(void (^)(NSString *, ResModel *))block type:(int)type{
    
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl=url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl=[NSURL URLWithString:url];
    }else{
        CCLOG(@"url 不合法");
    }
    [CC_HookTrack catchTrack];
    
    if (!model) {
        model=[[ResModel alloc]init];
    }
    model.serviceStr=paramsDic[@"service"];
    
    CC_HttpTask *executorDelegate = [[CC_HttpTask alloc] init];
    executorDelegate.finishCallbackBlock = block; // 绑定执行完成时的block
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];
    
    if ([paramsDic isKindOfClass:[NSDictionary class]]) {
        paramsDic=[[NSMutableDictionary alloc]initWithDictionary:paramsDic];
    }
    if (_forbiddenTimestamp==0) {
        if (!paramsDic[@"timestamp"]) {
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
            [paramsDic setObject:timeSp forKey:@"timestamp"];
        }
    }
    if (_extreDic) {
        NSArray *keys=[_extreDic allKeys];
        for (int i=0; i<keys.count; i++) {
            [paramsDic setObject:_extreDic[keys[i]] forKey:keys[i]];
        }
    }
    
    if (_forbiddenSendHookTrack==0) {
        //添加埋点追踪
        NSString *pushPop=[CC_HookTrack getInstance].pushPopActionStr;
        if (pushPop) {
            [paramsDic setObject:pushPop forKey:@"pushPopAction"];
            [CC_HookTrack getInstance].pushPopActionStr=nil;
        }
        NSString *trigger=[CC_HookTrack getInstance].triggerActionStr;
        if (trigger) {
            [paramsDic setObject:trigger forKey:@"triggerAction"];
            [CC_HookTrack getInstance].triggerActionStr=nil;
        }
        NSString *prePush=[CC_HookTrack getInstance].prePushActionStr;
        if (prePush) {
            [paramsDic setObject:prePush forKey:@"prePushAction"];
            [CC_HookTrack getInstance].prePushActionStr=nil;
        }
        NSString *prePop=[CC_HookTrack getInstance].prePopActionStr;
        if (prePop) {
            [paramsDic setObject:prePop forKey:@"prePopAction"];
            [CC_HookTrack getInstance].prePopActionStr=nil;
        }
    }
    
    if (!_signKeyStr) {
        if (model.debug) {
            CCLOG(@"_signKeyStr为空");
        }
    }
    NSString *paraString=[CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:_signKeyStr];
    
    NSURLRequest *urlReq;
    if (type==0) {
        urlReq=[self postRequestWithUrl:tempUrl andParamters:paraString];
    }else{
        urlReq=[self getRequestWithUrl:tempUrl andParamters:paraString];
    }
    
    model.requestUrlStr=urlReq.URL.absoluteString; model.requestStr=ccstr(@"%@%@",urlReq.URL.absoluteString,paraString);
    
    __block CC_HttpTask *blockSelf=self;
    NSURLSessionDownloadTask *mytask=[session downloadTaskWithRequest:urlReq completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [session finishTasksAndInvalidate];
        
        if (error.code == -1003 ) {
            NSURL *urlBase =  error.userInfo[NSURLErrorFailingURLErrorKey];
            //        NSURL *urlBase =  [NSURL URLWithString:@"http://mapi.njgreat88.com/client/service.json?"];
            NSString *ipStr = self.scopeIp;
            if (ipStr.length>0 && urlBase.host.length>0) {
                NSMutableString *mutUrlStr = [NSMutableString stringWithString:urlBase.relativeString];
                NSURL *newUrl = [NSURL URLWithString:[mutUrlStr stringByReplacingOccurrencesOfString:urlBase.host withString:ipStr]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [blockSelf->_requestHTTPHeaderFieldDic setValue:urlBase.host forKey:@"host"];
                    [blockSelf request:newUrl Params:paramsDic model:model FinishCallbackBlock:^(NSString *error, ResModel *result) {
                        block(error,result);
                    } type:0];
                    
                    executorDelegate.finishCallbackBlock(@"", model);
                });
                return ;
            }
        }else
        {
            [blockSelf->_requestHTTPHeaderFieldDic setValue:nil forKey:@"host"];
        }
        
        if (paramsDic[@"getDate"]||blockSelf.needResponseDate) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            [blockSelf loadResponseDate:model response:httpResponse];
        }
        
        if (error) {
            [model parsingError:error];
        }else{
            NSString *resultStr= [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:&error];
            //            NSCAssert(!resultStr, @"没有解析成数据");
            if (!resultStr) {
                NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                resultStr= [NSString stringWithContentsOfURL:location encoding:enc error:&error];
                if (model.debug&&resultStr) {
                    CCLOG(@"返回头是GBK编码");
                }
            }
            [model parsingResult:resultStr];
            model.networkError=nil;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (model.debug) {
                [[CCReqRecord getInstance]insertRequestDataWithHHSService:paramsDic[@"service"] requestUrl:tempUrl.absoluteString parameters:paraString];
            }
            if (model.resultDic) {
                CCLOG(@"%@\n%@",model.requestStr,[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:model.resultDic options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
            }else{
                CCLOG(@"%@\n%@",model.requestStr,model.resultStr);
            }
            
            NSArray *keyNames=[blockSelf.logicBlockMutDic allKeys];
            for (NSString *name in keyNames) {
                CC_ResLModel *logicModel=blockSelf.logicBlockMutDic[name];
                if (logicModel.logicPathArr.count>0) {
                    [blockSelf reponseLogicPassed:logicModel result:model.resultDic index:0];
                    //使用更新后的数据
                    CC_ResLModel *newModel=blockSelf.logicBlockMutDic[logicModel.logicNameStr];
                    if (newModel.logicPassed) {
                        newModel.logicBlock(model.resultDic);
                        if (newModel.logicPassStop) {
                            return ;
                        }
                    }
                }
            }
            
            executorDelegate.finishCallbackBlock(model.errorMsgStr, model);
        });
        
    }];
    
    [mytask resume];
}

#pragma mark NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler{
    //信任伪造HTTPS证书
    //    if([challenge.protectionSpace.host isEqualToString:@"api.lz517.me"] /*check if this is host you trust: */ ){
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
    //    }
}

- (void)setHttpHeader:(NSDictionary *)dic{
    self.requestHTTPHeaderFieldDic=dic;
}

- (void)setSignKey:(NSString *)str{
    _signKeyStr=str;
}

- (void)addExtreDic:(NSDictionary *)dic{
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    if (_extreDic) {
        [mutDic addEntriesFromDictionary:_extreDic];
    }
    _extreDic=[[NSDictionary alloc]initWithDictionary:mutDic];
}

- (void)setExtreDic:(NSDictionary *)dic{
    _extreDic=dic;
}

- (NSURLRequest *)postRequestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString{
    return [self requestWithUrl:url andParamters:paramsString andType:0];
}

- (NSURLRequest *)getRequestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString{
    return [self requestWithUrl:url andParamters:paramsString andType:1];
}

//创建request
- (NSURLRequest *)requestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString andType:(int)type{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    request.URL=url;
    
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *types=@[@"POST",@"GET"];
    [request setHTTPMethod:types[type]];
    [request setTimeoutInterval:_httpTimeoutInterval];
    
    if (!_requestHTTPHeaderFieldDic) {
        CCLOG(@"没有设置_requestHTTPHeaderFieldDic");
        return request;
    }
    
    NSArray *keys=[_requestHTTPHeaderFieldDic allKeys];
    for (int i=0; i<keys.count; i++) {
        [request setValue:_requestHTTPHeaderFieldDic[keys[i]] forHTTPHeaderField:keys[i]];
    }
    
    return request;
}

- (void)loadResponseDate:(ResModel *)model response:(NSHTTPURLResponse *)httpResponse{
    //转换时间
    NSString *date = [[httpResponse allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init]; dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:model.responseDateFormatStr];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate dateByAddingTimeInterval: interval];
    model.responseDate=localeDate;
}

- (void)resetResponseLogicPopOnce:(NSString *)logicName{
    CC_ResLModel *model=_logicBlockMutDic[logicName];
    model.logicPopOnce=0;
    [_logicBlockMutDic setObject:model forKey:logicName];
}

- (void)addResponseLogic:(NSString *)logicName logicStr:(NSString *)logicStr stop:(BOOL)stop popOnce:(BOOL)popOnce logicBlock:(void (^)(NSDictionary *errorDic))block{
    CC_ResLModel *model=[[CC_ResLModel alloc]init];
    model.logicNameStr=logicName;
    model.logicPassStop=stop;
    model.logicBlock=block;
    model.logicPopOnce=popOnce;
    if ([logicStr containsString:@"="]) {
        NSArray *equal=[logicStr componentsSeparatedByString:@"="];
        model.logicEqualStr=equal[1];
        NSString *pathStr=equal[0];
        model.logicPathArr=[pathStr componentsSeparatedByString:@","];
    }else{
        model.logicPathArr=[logicStr componentsSeparatedByString:@","];
    }
    
    if (!_logicBlockMutDic) {
        _logicBlockMutDic=[[NSMutableDictionary alloc]init];
    }
    [_logicBlockMutDic setObject:model forKey:logicName];
}

- (void)reponseLogicPassed:(CC_ResLModel *)model result:(id)result index:(int)index{
    if (!result) {
        return;
    }
    model.logicPassed=0;
    if ([result isKindOfClass:[NSString class]]||
        [result isKindOfClass:[NSNumber class]]) {
        if ([result isKindOfClass:[NSNumber class]]) {
            result=ccstr(@"%@",result);
        }
        if (model.logicEqualStr) {
            if ([result isEqualToString:model.logicEqualStr]) {//字段相等 通过
                model.logicPassed=1;
            }else{
                model.logicPassed=0;
            }
        }else{//有这个字段 通过
            model.logicPassed=1;
        }
        [_logicBlockMutDic setObject:model forKey:model.logicNameStr];
        return;
    }
    if (index>=model.logicPathArr.count) {
        NSCAssert(index<model.logicPathArr.count, @"该路径下不是一个字段");
        return;
    }
    [self reponseLogicPassed:model result:result[model.logicPathArr[index]] index:index+1];
}

#pragma mark getDomain
- (void)getDomainWithReqListNoCache:(NSArray *)domainReqList block:(void (^)(ResModel *result))block{
    self.domainReqListNoCacheIndex=0;
    [self getDomainNoCache:domainReqList[0] block:block];
}

- (void)getDomainNoCache:(NSString *)urlStr block:(void (^)(ResModel *result))block{
    __block CC_HttpTask *blockSelf=self;
    [[CC_HttpTask getInstance]get:urlStr params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            blockSelf.domainReqListNoCacheIndex++;
            if (blockSelf.domainReqListNoCacheIndex>=blockSelf.domainReqListNoCache.count) {
                blockSelf.domainReqListNoCacheIndex=0;
            }
            [ccs delay:1 block:^{
                [blockSelf getDomainNoCache:blockSelf.domainReqListNoCache[blockSelf.domainReqListNoCacheIndex] block:block];
            }];
            return ;
        }
        block(result);
    }];
}

- (void)getDomainWithReqList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey block:(void (^)(ResModel *result))block{
    self.domainReqListIndex=0;
    self.domainReqList=domainReqList;
    self.domainReqKey=domainReqKey;
    [self getDomain:domainReqList[0] block:block];
}

- (void)getDomain:(NSString *)urlStr block:(void (^)(ResModel *result))block{
    //    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    //    pasteboard.string=@"http://sssynout-prod-caihong-resource.oss-cn-hangzhou.aliyuncs.com/URL/ch_url.txt";
    
    //线上 http://sssynout-prod-caihong-resource.oss-cn-hangzhou.aliyuncs.com/URL/ch_url.txt
    //线下 https://test-caihong-resource.oss-cn-hangzhou.aliyuncs.com/URL/ch_url.txt
    _hasSuccessGetDomain=0;
    
    if ([ccs getDefault:@"domainDic"]&&_updateInBackGround==0) {
        
        ResModel *model=[[ResModel alloc]init];
        model.resultDic=[ccs getDefault:@"domainDic"];
        
        self.hasSuccessGetDomain=1;
        
        block(model);
        
        //后台更新domain
        _updateInBackGround=1;
        [self getDomain:urlStr block:block];
        return;
    }
    
    __block CC_HttpTask *blockSelf=self;
    [[CC_HttpTask getInstance]get:urlStr params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        if (error) {
            [ccs delay:3 block:^{
                if (blockSelf.hasSuccessGetDomain==0) {
                    
                    //更新不提示
                    if (blockSelf.updateInBackGround==0) {
                        //3秒后提示 是网络没有打开的提示还是网络打开了但是域名请求失败的提示
                        if (blockSelf.hasSuccessGetThirdUrlResponse==1) {
                            
                            [CC_Notice showNoticeStr:@"域名请求失败"];
                        }else{
                            
                            [CC_Notice showNoticeStr:@"网络权限被关闭，不能获取网络"];
                        }
                    }
                }
                
            }];
            
            //请求第三方的网络验证网络情况
            blockSelf.hasSuccessGetThirdUrlResponse=[self isNetworkReachable];
//            [[CC_HttpTask getInstance]get:blockSelf.static_pingThirdWebUrl params:@{@"getDate":@""} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
//                if (result.responseDate) {
//                    blockSelf.hasSuccessGetThirdUrlResponse=1;
//                }else{
//                }
//            }];
            
            //多个备用域名请求链接
            if (blockSelf.domainReqList.count>0) {
                blockSelf.domainReqListIndex++;
                if (blockSelf.domainReqListIndex>=blockSelf.domainReqList.count) {
                    blockSelf.domainReqListIndex=0;
                }
                
                if (blockSelf.updateInBackGround==0) {
                    [ccs delay:.3 block:^{
                        
                        [self getDomain:blockSelf.domainReqList[blockSelf.domainReqListIndex] block:block];
                    }];
                }else{
                    if (blockSelf.domainReqListIndex>0) {
                        [ccs delay:.3 block:^{
                            
                            [self getDomain:blockSelf.domainReqList[blockSelf.domainReqListIndex] block:block];
                        }];
                    }
                }
                
            }else{
                
                if (blockSelf.updateInBackGround==0) {
                    [ccs delay:1 block:^{
                        
                        [self getDomain:urlStr block:block];
                    }];
                }
                
            }
            return ;
        }
        
        //成功获取域名请求
        NSString *domanKey=result.resultDic[blockSelf.domainReqKey];
        domanKey=[NSString stringWithFormat:@"%@%@",domanKey,blockSelf.static_domainTestKey];
        //验证url可请求成功
        if (domanKey) {
            [[CC_HttpTask getInstance]get:domanKey params:nil model:nil finishCallbackBlock:^(NSString *error2, ResModel *result2) {
                
                if (result2.parseFail==1||error2) {
                    
                    if (blockSelf.domainReqList.count>0) {
                        blockSelf.domainReqListIndex++;
                        if (blockSelf.domainReqListIndex>=blockSelf.domainReqList.count) {
                            blockSelf.domainReqListIndex=0;
                            
                            if (blockSelf.updateInBackGround==0) {
                                [ccs delay:3 block:^{
                                    if (blockSelf.hasSuccessGetDomain==0) {
                                        
                                        [CC_Notice showNoticeStr:@"服务器开小差了"];
                                        
                                    }
                                    
                                }];
                            }
                            
                        }
                        
                        if (blockSelf.updateInBackGround==0) {
                            [ccs delay:.3 block:^{
                                
                                [self getDomain:blockSelf.domainReqList[blockSelf.domainReqListIndex] block:block];
                            }];
                        }else{
                            if (blockSelf.domainReqListIndex>0) {
                                [ccs delay:.3 block:^{
                                    
                                    [self getDomain:blockSelf.domainReqList[blockSelf.domainReqListIndex] block:block];
                                }];
                            }
                        }
                        
                    }else{
                        
                        if (blockSelf.updateInBackGround==0) {
                            
                            [ccs delay:1 block:^{
                                
                                [self getDomain:urlStr block:block];
                            }];
                        }
                    }
                    
                }else{
                    
                    blockSelf.hasSuccessGetDomain=1;
                    [ccs saveDefaultKey:@"domainDic" andV:result.resultDic];
                    
                    if (blockSelf.updateInBackGround==0) {
                        block(result);
                    }
                }
                
            }];
        }else{
            if (blockSelf.updateInBackGround==0) {
                [CC_Notice showNoticeStr:@"域名获取失败"];
            }
        }
        
        
    }];
}

#pragma mark getConfigure
- (void)getConfigure:(void (^)(Confi *result))block{
    [self getConfigure:_static_netTestUrl contain:_static_netTestContain block:block];
}

- (void)getConfigure:(NSString *)urlStr contain:(NSString *)containStr block:(void (^)(Confi *result))block{
    
    self.getConfigureBlock=block;
    
    NSDictionary *resultDic=[ccs getDefault:@"bench_configure"];
    if (resultDic) {
        //缓存
        Confi *configure=[[Confi alloc]init];
        configure.resultDic=resultDic;
        configure.net=[resultDic[@"net"] intValue];
        configure.showLog=[resultDic[@"showLog"] intValue];
        self.getConfigureBlock(configure);
        return;
    }
    __block CC_HttpTask *blockSelf=self;
    CC_HttpTask *tempTask=[[CC_HttpTask alloc]init];
    tempTask.httpTimeoutInterval=3;
    [tempTask get:urlStr params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        //第一次网络没有授权情况？
        if ([[NSString stringWithFormat:@"%@",result.resultStr] containsString:containStr]&&result.networkError==nil) {
            [tempTask get:blockSelf.static_configureUrl params:nil model:nil finishCallbackBlock:^(NSString *error2, ResModel *result2) {
                
                NSString *buildKey=[NSString stringWithFormat:@"build%@%@",[ccs getBid],[ccs getBundleVersion]];
                NSDictionary *resultDic2=result2.resultDic[buildKey];
                CCLOG(@"k=%@",buildKey);
                if (!resultDic2) {
                    NSString *key=[NSString stringWithFormat:@"%@%@",[ccs getBid],[ccs getVersion]];
                    resultDic2=result2.resultDic[key];
                    CCLOG(@"k=%@",key);
                }
                if (resultDic2) {
                    
                    [ccs saveDefaultKey:@"bench_configure" andV:resultDic2];
                    //缓存下来
                    Confi *configure=[[Confi alloc]init];
                    configure.resultDic=resultDic2;
                    configure.net=[resultDic2[@"net"] intValue];
                    configure.showLog=[resultDic2[@"showLog"] intValue];
                    self.getConfigureBlock(configure);
                }else{
                    [ccs saveDefaultKey:@"bench_configure" andV:@{@"net":@"0",@"showLog":@"0"}];
                    Confi *configure=[[Confi alloc]init];
                    configure.net=0;
                    configure.showLog=0;
                    self.getConfigureBlock(configure);
                }
            }];
        }else{
            [ccs saveDefaultKey:@"bench_configure" andV:@{@"net":@"0",@"showLog":@"0"}];
            Confi *configure=[[Confi alloc]init];
            configure.net=0;
            configure.showLog=0;
            self.getConfigureBlock(configure);
        }
        
        
    }];
}

@end


