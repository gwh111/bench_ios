//
//  CC_AppDelegate.h
//  testbenchios
//
//  Created by gwh on 2019/7/29.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_NavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_AppDelegate : UIResponder<UIApplicationDelegate>

@property (strong,nonatomic) UIWindow *window;
//@property (strong,nonatomic) UINavigationController *cc_uiNav;
@property (strong,nonatomic) CC_NavigationController *cc_nav;

+ (CC_AppDelegate *)shared;

// Startup sequence as: cc_willInit, cc_init, cc_didFinishLaunchingWithOptions
// 启动顺序为cc_willInit, cc_launch, cc_didFinishLaunchingWithOptions

// Configuration function, adds configuration to this function
// 配置函数 在此函数中添加配置
- (void)cc_willInit;

/** Set up the startup controller
    设置启动的控制器 */

- (void)cc_initViewController:(Class)aClass block:(void (^)(void))block;

- (void)cc_initViewController:(Class)aClass withNavigationBarHidden:(BOOL)hidden block:(void (^)(void))block;

- (void)cc_initTabbarViewController:(Class)aClass block:(void (^)(void))block;

#pragma mark life circle
- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)cc_applicationWillResignActive:(UIApplication *)application;

- (void)cc_applicationDidEnterBackground:(UIApplication *)application;

- (void)cc_applicationWillEnterForeground:(UIApplication *)application;

- (void)cc_applicationDidBecomeActive:(UIApplication *)application;

- (void)cc_applicationWillTerminate:(UIApplication *)application;

#pragma mark open URL
- (BOOL)cc_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0);

#pragma mark notification
- (void)cc_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
