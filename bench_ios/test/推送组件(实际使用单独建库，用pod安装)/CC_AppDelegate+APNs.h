//
//  CC_AppDelegate+APNs.h
//  bench_ios
//
//  Created by gwh on 2020/3/18.
//

#import "CC_AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_AppDelegate (APNs)

- (void)cc_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (BOOL)cc_application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler;

- (void)cc_application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings;

- (void)cc_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

- (void)cc_application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

@end

NS_ASSUME_NONNULL_END
