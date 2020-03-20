//
//  Sub_DomainCenter.h
//  bench_ios
//
//  Created by ml on 2019/9/27.
//

#import "CC_AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// 域名管理
/// 依赖 UI + Netowrk
@interface Sub_DomainCenter : CC_AppDelegate

@property (nonatomic,copy,readonly) NSArray *domainURLs;

@end

NS_ASSUME_NONNULL_END
