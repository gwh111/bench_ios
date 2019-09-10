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
@property (nonatomic, assign) BOOL launchedFromRemoteNotification;
@property (nonatomic,assign) NSInteger requestCycleCount;  // 向服务端上传token循环次数.

@property (nonatomic, copy) CC_PushMessageBlock pushMessageBlock;

@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, copy) NSURL *domainUrl;
@property (nonatomic, copy) NSString *authedUserId;

@end

@implementation AppDelegate_APNs

+ (void)load{
    [ccs registerAppDelegate:self];
}

- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //判断是不是通过点击远程通知启动app
    NSDictionary*message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.launchedFromRemoteNotification = (message != nil);
    //注册远程通知
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                CCLOG(@"request authorization succeeded!");
                [ccs gotoMain:^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                }];
            }
        }];
    } else if (@available(iOS 8.0, *)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#pragma clang diagnostic pop
    }
    
    return YES;
}
//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    self.deviceToken=deviceToken;
    [self updateTokenToServerWithDeviceToken:_deviceToken domain:_domainUrl authedUserId:_authedUserId];
}
//注册消息推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    CCLOG(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

#pragma mark - iOS 10中收到推送消息
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    CCLOG(@"willPresentNotification：%@", notification.request.content.userInfo);
    self.launchedFromRemoteNotification = NO;
    NSDictionary *message = notification.request.content.userInfo;
    [self handlePushMessage:message];
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler  API_AVAILABLE(ios(10.0)) {
    self.launchedFromRemoteNotification = YES;
    CCLOG(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    NSDictionary *message = response.notification.request.content.userInfo;
    [self handlePushMessage:message];
    completionHandler();
}

// app打开状态收到通知,会调用 iOS10以前
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    [self updateLaunchedFromRemoteNotification:application];
    [self handlePushMessage:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - private
/**
 *  @brief ios10以前 判断是否是从通知回到前台还是点击app到前台
 *  @param application UIApplication
 */
-(void)updateLaunchedFromRemoteNotification:(UIApplication *)application {
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

-(void)handlePushMessage:(NSDictionary *)messageInfo {
    !_pushMessageBlock ? : _pushMessageBlock(messageInfo, self.launchedFromRemoteNotification);
    self.launchedFromRemoteNotification = NO;
}

- (void)updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(CC_PushMessageBlock)pushMessageBlock{
    self.domainUrl=domainUrl;
    self.authedUserId=authedUserId;
    self.pushMessageBlock=pushMessageBlock;
    [self updateTokenToServerWithDeviceToken:_deviceToken domain:domainUrl authedUserId:authedUserId];
}

-(void)updateTokenToServerWithDeviceToken:(NSData *)deviceToken domain:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId{
    if ([ccs function_isEmpty:authedUserId] || !self.deviceToken) {
        return;
    }
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
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
