//
//  ccs+APNs.m
//  bench_ios
//
//  Created by gwh on 2019/9/9.
//

#import "ccs+APNs.h"
#import "CC_Message.h"

@implementation ccs (APNs)

+ (void)APNs_updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock {
    [cc_message cc_targetAppDelegate:@"AppDelegate_APNs" method:@"updateTokenToServerWithDomainUrl:authedUserId:pushMessageBlock:" block:^(BOOL success) {
        if (!success) {
            CCLOGAssert(@"you need add pod 'bench_ios_APNs' in podfile.");
        }
    } params:domainUrl,authedUserId,pushMessageBlock];
}

@end
