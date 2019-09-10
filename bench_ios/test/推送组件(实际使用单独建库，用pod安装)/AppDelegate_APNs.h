//
//  AppDelegate2.h
//  testbenchios
//
//  Created by gwh on 2019/8/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CC_PushMessageBlock)(NSDictionary *messageDic, BOOL lanchFromRemote);

@interface AppDelegate_APNs : CC_AppDelegate

@property (nonatomic,retain) NSMutableArray *arr;

/**
 上传推送配置

 @param domainUrl 域名
 @param authedUserId 用户ID
 @param pushMessageBlock 推送回调
 */
- (void)updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(CC_PushMessageBlock)pushMessageBlock;

@end

NS_ASSUME_NONNULL_END
