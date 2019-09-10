//
//  ccs+APNs.h
//  bench_ios
//
//  Created by gwh on 2019/9/9.
//

#import "ccs.h"

#import "AppDelegate_APNs.h"

@interface ccs (APNs)

/**
 上传推送配置

 @param domainUrl 域名URL
 @param authedUserId 用户ID
 @param pushMessageBlock 推送回调
 */
+ (void)APNs_updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock;

@end

