//
//  CC_HTTPConfigure.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_HttpConfig.h"

#import "CC_HttpTask.h"

#import "CC_BundleStore.h"
#import "CC_Device.h"
#import "CC_KeyChainStore.h"

@implementation CC_HttpConfig
@synthesize httpTimeoutInterval,httpHeaderFields,extreParameter,logicBlockMap;

- (void)start {
    
    httpTimeoutInterval = 10;
    
    NSString *appName = [CC_BundleStore cc_appName];
    NSString *appBundleId = [CC_BundleStore cc_appBid];
    NSString *appVersion = [CC_BundleStore cc_appVersion];
    NSString *appUserAgent = [CC_Device cc_deviceName];
    NSString *appDeviceId = [CC_KeyChainStore cc_keychainUUID];
    httpHeaderFields =
    @{@"appName":appName?appName:@"",
      @"appBundleId":appBundleId?appBundleId:@"",
      @"appVersion":appVersion?appVersion:@"",
      @"appUserAgent":appUserAgent?appUserAgent:@"",
      @"appDeviceId":appDeviceId?appDeviceId:@"",
    }.mutableCopy;
    
    extreParameter = [[NSMutableDictionary alloc]init];
    logicBlockMap = [[NSMutableDictionary alloc]init];
}

- (void)httpHeaderAdd:(NSString *)key value:(id)value {
    [httpHeaderFields cc_setKey:key value:value];
}

- (void)httpHeaderRemove:(NSString *)key {
    [httpHeaderFields cc_removeKey:key];
}

- (void)extreDicAdd:(NSString *)key value:(id)value {
    [extreParameter cc_setKey:key value:value];
}

- (void)extreDicRemove:(NSString *)key {
    [extreParameter cc_removeKey:key];
}

@end
