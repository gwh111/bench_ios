//
//  AppDelegate2.h
//  testbenchios
//
//  Created by gwh on 2019/8/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_AppDelegate.h"

@interface AppDelegate_APNs : CC_AppDelegate

@property (nonatomic, assign) BOOL launchedFromRemoteNotification;
@property (nonatomic, assign) NSInteger requestCycleCount;  // 向服务端上传token循环次数.

+ (instancetype)shared;

/**
获取推送token
@param block success 是否成功获取
             granted 是否打开推送授权
*/
- (void)addReceiveDeviceTokenBlock:(void(^)(BOOL success, BOOL granted, NSData *deviceToken))block;

/**
上传推送配置
@param domainUrl 域名
@param authedUserId 用户ID
@param pushMessageBlock 推送回调
 */
- (void)updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock;

@end
