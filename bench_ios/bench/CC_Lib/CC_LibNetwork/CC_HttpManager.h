//
//  CC_HttpManager.h
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_Foundation.h"

#import "CC_HttpResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CCHttpTaskType) {
    CCHttpTaskTypeGet,
    CCHttpTaskTypePost,
    CCHttpTaskTypeImage,
    CCHttpTaskTypeFile,
};

@interface CC_HttpManager : NSObject

- (BOOL)cc_isNetworkReachable;

// 获取域名 传入获取域名的地址
// @param domainReqList @[@[线上地址1,线上地址2...],@[主干地址1,主干地址2...],@[分支1地址1,分支2地址2]...]
// @param cache 是否缓存 使用否会直接返回缓存，在后台检测有无变更，有变更再次从block返回新地址
// @param pingTest 是否ping一个该域名下的test接口来检测域名是否有效（需要服务端有service=TEST的接口）
// GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
// 如果没有配置CCBUILDTAG，在debug下默认使用主干地址1，在release默认使用线上地址1.
- (void)cc_domainWithReqList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(ResModel *result))block;

- (ResModel *)cc_commonModel;

@end

NS_ASSUME_NONNULL_END
