//
//  CC_AppDelegate+APNs.m
//  bench_ios
//
//  Created by gwh on 2020/3/18.
//

#import "CC_AppDelegate+APNs.h"

@implementation CC_AppDelegate (APNs)

//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [cc_message cc_appDelegateMethod:@selector(cc_application:didRegisterForRemoteNotificationsWithDeviceToken:) params:application,deviceToken];
    [self cc_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)cc_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

}

//注册消息推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    CCLOG(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
    [cc_message cc_appDelegateMethod:@selector(cc_application:didFailToRegisterForRemoteNotificationsWithError:) params:application,error];
    [self cc_application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    [cc_message cc_appDelegateMethod:@selector(cc_application:continueUserActivity:restorationHandler:) params:application,userActivity,restorationHandler];
    return [self cc_application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (BOOL)cc_application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings {
     [cc_message cc_appDelegateMethod:@selector(cc_application:didRegisterUserNotificationSettings:) params:application,notificationSettings];
    [self cc_application:application didRegisterUserNotificationSettings:notificationSettings];
}

- (void)cc_application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings {
     
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    [cc_message cc_appDelegateMethod:@selector(cc_application:didReceiveRemoteNotification:fetchCompletionHandler:) params:application,userInfo,completionHandler];
    [self cc_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

- (void)cc_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [cc_message cc_appDelegateMethod:@selector(cc_application:didReceiveLocalNotification:) params:application,notification];
    [self cc_application:application didReceiveLocalNotification:notification];
}

- (void)cc_application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

}

@end
