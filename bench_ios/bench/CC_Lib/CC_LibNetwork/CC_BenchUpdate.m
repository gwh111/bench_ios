//
//  CC_BenchUpdate.m
//  bench_ios
//
//  Created by gwh on 2019/8/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_BenchUpdate.h"
#import "CC_HttpTask.h"
#import "CC_DefaultStore.h"
#import "CC_Notice.h"

@implementation CC_BenchUpdate

+ (void)checkUpdate {
#if DEBUG
    
#else
    // 减轻服务压力 debug才检查
    return;
#endif
    // 检查内网
    HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
    model.forbiddenJSONParseError = YES;
    [CC_HttpTask.shared get:BENCH_IOS_NET_TEST_URL params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {
        if ([[NSString stringWithFormat:@"%@",result.resultStr] containsString:BENCH_IOS_NET_TEST_CONTAIN]) {
            [CC_HttpTask.shared get:BENCH_IOS_VERSION_URL params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
                if (error) {
                    return;
                }
                NSString *version = result.resultDic[@"version"];
                if ([CC_Function cc_compareVersion:version cutVersion:BENCH_IOS_VERSION] > 0) {
                    CCLOG(@"bench_ios需要更新到%@",version);
                    if (result.resultDic[@"must"]) {
                        [CC_CoreThread.shared cc_delay:3 block:^{
                            [CC_Notice.shared showNotice:[NSString stringWithFormat:@"bench_ios需要更新到v%@",version]];
                        }];
                    }
                }
            }];
        }
    }];
    
}

@end
