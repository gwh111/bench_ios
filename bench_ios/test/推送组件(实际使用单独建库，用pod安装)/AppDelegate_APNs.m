//
//  AppDelegate2.m
//  testbenchios
//
//  Created by gwh on 2019/8/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AppDelegate_APNs.h"
#import "ccs.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate_APNs ()<UNUserNotificationCenterDelegate>

@property (nonatomic, copy) void(^pushMessageBlock)(NSDictionary *messageDic, BOOL lanchFromRemote);
@property (nonatomic, copy) void(^deviceTokenBlock)(BOOL success, BOOL granted, NSData *deviceToken);

@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, assign) BOOL deviceTokenGranted;
@property (nonatomic, assign) BOOL getDeviceTokenSuccess;
@property (nonatomic, copy) NSURL *domainUrl;
@property (nonatomic, copy) NSString *authedUserId;
@property (nonatomic, retain) AppDelegate_APNs *appdelegate;

@end

@implementation AppDelegate_APNs

+ (instancetype)shared {
    return [CC_Base.shared cc_getAppDelegate:self.class];
}

+ (void)load {
    [ccs registerAppDelegate:self];
}

#pragma public
- (void)addReceiveDeviceTokenBlock:(void(^)(BOOL success, BOOL granted, NSData *deviceToken))block {
    if (_deviceToken) {
        _deviceTokenBlock(_getDeviceTokenSuccess, _deviceTokenGranted, _deviceToken);
        return;
    }
    _deviceTokenBlock = block;
}

- (void)updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock {
    self.domainUrl = domainUrl;
    self.authedUserId = authedUserId;
    self.pushMessageBlock = _pushMessageBlock;
    [self updateTokenToServerWithDeviceToken:_deviceToken domain:domainUrl authedUserId:authedUserId];
}

#pragma private
- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //判断是不是通过点击远程通知启动app
    NSDictionary *message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.launchedFromRemoteNotification = (message != nil);
    //注册远程通知
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            self.deviceTokenGranted = granted;
            if (granted) {
                CCLOG(@"request authorization succeeded!");
                [ccs gotoMain:^{
                    [application registerForRemoteNotifications];
                }];
            } else {
                [ccs gotoMain:^{
                    if (self.deviceTokenBlock) {
                        self.deviceTokenBlock(NO, NO, nil);
                    }
                }];
            }
        }];
    } else if (@available(iOS 8.0, *)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:apn_type];
#pragma clang diagnostic pop
    }
    
    return YES;
}

//获取DeviceToken成功
- (void)cc_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    self.deviceToken = deviceToken;
    if (_domainUrl) {
        [self updateTokenToServerWithDeviceToken:_deviceToken domain:_domainUrl authedUserId:_authedUserId];
    }
    if (_deviceTokenBlock) {
        _getDeviceTokenSuccess = YES;
        _deviceTokenBlock(_getDeviceTokenSuccess, _deviceTokenGranted, deviceToken);
    }
}

//注册消息推送失败
- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    CCLOG(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
    if (_deviceTokenBlock) {
        _getDeviceTokenSuccess = NO;
        _deviceTokenBlock(_getDeviceTokenSuccess, _deviceTokenGranted, nil);
    }
}

#pragma mark - iOS 10中收到推送消息
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)) {
    CCLOG(@"willPresentNotification：%@", notification.request.content.userInfo);
    self.launchedFromRemoteNotification = NO;
    NSDictionary *message = notification.request.content.userInfo;
    [self handlePushMessage:message];
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)) {
    self.launchedFromRemoteNotification = YES;
    CCLOG(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    NSDictionary *message = response.notification.request.content.userInfo;
    [self handlePushMessage:message];
    completionHandler();
}

// app打开状态收到通知,会调用 iOS10以前
- (void)cc_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    [self updateLaunchedFromRemoteNotification:application];
    [self handlePushMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - private
/**
 *  @brief ios10以前 判断是否是从通知回到前台还是点击app到前台
 *  @param application UIApplication
 */
- (void)updateLaunchedFromRemoteNotification:(UIApplication *)application {
    switch (application.applicationState) {
        case UIApplicationStateActive: {
            self.launchedFromRemoteNotification = NO;
        }
            break;
        case UIApplicationStateBackground: {
            self.launchedFromRemoteNotification = YES;
        }
            break;
        case UIApplicationStateInactive: {
            self.launchedFromRemoteNotification = YES;
        }
            break;
        default:
            break;
    }
}

- (void)handlePushMessage:(NSDictionary *)messageInfo {
    !_pushMessageBlock ? : _pushMessageBlock(messageInfo, self.launchedFromRemoteNotification);
    self.launchedFromRemoteNotification = NO;
}

- (void)updateTokenToServerWithDeviceToken:(NSData *)deviceToken domain:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId {
    if ([ccs.tool isEmpty:authedUserId] || !self.deviceToken) {
        return;
    }
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    CCLOG(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    if (_requestCycleCount > 15) return; // 控制循环次数
    _requestCycleCount ++;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"MOBILE_CLIENT_USER_NOTICE_KEY_UPDATE" forKey:@"service"];
    [dic setObject:token forKey:@"token"];
    
    [[CC_HttpTask shared] post:domainUrl params:dic model:nil finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            if (self.requestCycleCount>15) {
                [CC_Notice.shared showNotice:error];
            }
            CCLOG(@"token上传失败");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self updateTokenToServerWithDeviceToken:deviceToken domain:domainUrl authedUserId:authedUserId];
            });
        }else{
            CCLOG(@"token上传成功");
        }
    }];
}

@end
