//
//  CC_HttpManager.h
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_Foundation.h"

#import "CC_HttpTask.h"
#import "CC_HttpResponseModel.h"
#import "CC_HttpConfig.h"

typedef NS_ENUM(NSUInteger, CCHttpTaskType) {
    CCHttpTaskTypeRequest,
    CCHttpTaskTypeGet,
    CCHttpTaskTypePost,
    CCHttpTaskTypeImage,
    CCHttpTaskTypeFile,
};

@interface CC_HttpHelper : NSObject
// 配置是否进入后台，请求是否中断，默认开启
@property (nonatomic, assign) BOOL stopSession;

+ (instancetype)shared;

// session管理
- (void)addURLSession:(NSURLSession *)session;
- (void)cancelURLSession:(NSURLSession *)session;
- (void)cancelAllSession;


- (BOOL)isNetworkReachable;

/**
    获取域名 传入获取域名的地址
    @param domainReqList @[@[线上地址1,线上地址2...],
                           @[主干地址1,主干地址2...],
                           @[分支1地址1,分支1地址2...]
                            ...]
    @param cache 是否缓存 使用否会直接返回缓存，在后台检测有无变更，有变更再次从block返回新地址
    @param pingTest 是否ping一个该域名下的test接口来检测域名是否有效（需要服务端有service=TEST的接口）
    如果没有新建.xcconfig配置CCBUILDTAG，在debug下默认使用主干地址1，在release默认使用线上地址1.
 
    GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
 
    CC_CommonConfig.xcconfig
    CC_ReleaseConfig.xcconfig
    CC_TrunkConfig.xcconfig
    CC_Branch1Config.xcconfig
    ...
 */
- (void)domainWithReqGroupList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block;

// 直接获取域名
- (void)domainWithReqList:(NSArray *)domainReqList block:(void (^)(HttpModel *result))block;

- (HttpModel *)commonModel:(HttpModel *)model url:(id)url params:(id)params configure:(CC_HttpConfig *)configure type:(CCHttpTaskType)type;

- (NSMutableURLRequest *)requestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString model:(HttpModel *)model configure:(CC_HttpConfig *)configure type:(CCHttpTaskType)type;

@end

/// 域名初始化通知
FOUNDATION_EXPORT NSNotificationName const CCDomainLaunchNotification;

/// 域名变更通知    应用中接收该通知用于域名切换
FOUNDATION_EXPORT NSNotificationName const CCDomainChangedNotification;

/// 域名设置完成通知 应用中发送该通知完成重新请求
FOUNDATION_EXPORT NSNotificationName const CCDomainDoneNotification;
