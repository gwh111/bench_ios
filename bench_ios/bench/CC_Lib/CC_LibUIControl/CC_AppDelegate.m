//
//  CC_AppDelegate.m
//  testbenchios
//
//  Created by gwh on 2019/7/29.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_AppDelegate.h"
#import "CC_CoreUI.h"
#import "CC_LibNetwork.h"

@interface CC_AppDelegate ()

@end

@implementation CC_AppDelegate

+ (CC_AppDelegate *)shared {
    CC_AppDelegate *appDelegate = (CC_AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (void)cc_willInit {}

- (void)super_cc_willInit {
    
    // Foundation
//    [CC_Base cc_willInit];
    [CC_NavigationController.shared cc_willInit];
    
    // Lib
    [CC_HttpTask.shared start];
    [CC_CoreUI.shared start];
}

- (void)cc_initViewController:(Class)aClass withNavigationBarHidden:(BOOL)hidden block:(void (^)(void))block {
    id controller = [CC_Base.shared cc_init:aClass];
    if ([controller isKindOfClass:CC_ViewController.class]) {
        CC_ViewController *viewController =controller;
        viewController.cc_navigationBarHidden = hidden;
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [CC_NavigationController shared].cc_UINav = navController;
    [CC_NavigationController shared].cc_UINav.navigationBarHidden = YES;
    [CC_AppDelegate shared].window.rootViewController = [CC_NavigationController shared].cc_UINav;
    block();
}

- (void)cc_initViewController:(Class)aClass block:(void (^)(void))block {
    [self cc_initViewController:aClass withNavigationBarHidden:YES block:block];
}

- (void)cc_initTabbarViewController:(Class)aClass block:(void (^)(void))block {
    [self cc_initViewController:aClass withNavigationBarHidden:YES block:block];
}

#pragma mark life circle
- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self super_cc_willInit];
    [self cc_willInit];
    
    [cc_message cc_appDelegateMethod:@selector(cc_willInit) params:nil];
    [cc_message cc_appDelegateMethod:@selector(cc_application:didFinishLaunchingWithOptions:) params:application, launchOptions];
    
    CCLOG(@"<<<bench_ios init success");
    [CC_Monitor.shared reviewLaunchFinish];
    
    return YES;
}


- (void)cc_applicationWillResignActive:(UIApplication *)application {};

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [cc_message cc_appDelegateMethod:@selector(cc_applicationWillResignActive:) params:application];
    [self cc_applicationWillResignActive:application];
}


- (void)cc_applicationDidEnterBackground:(UIApplication *)application {};

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [cc_message cc_appDelegateMethod:@selector(cc_applicationDidEnterBackground:) params:application];
    [self cc_applicationDidEnterBackground:application];
}


- (void)cc_applicationWillEnterForeground:(UIApplication *)application {};

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    if (CC_HttpHelper.shared.stopSession) {
        [CC_HttpHelper.shared cancelAllSession];
    }
    [cc_message cc_appDelegateMethod:@selector(cc_applicationWillEnterForeground:) params:application];
    [self cc_applicationWillEnterForeground:application];
}


- (void)cc_applicationDidBecomeActive:(UIApplication *)application {};

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [cc_message cc_appDelegateMethod:@selector(cc_applicationDidBecomeActive:) params:application];
    
    [self cc_applicationDidBecomeActive:application];
}


- (void)cc_applicationWillTerminate:(UIApplication *)application {};

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [cc_message cc_appDelegateMethod:@selector(cc_applicationWillTerminate:) params:application];
    
    [self cc_applicationWillTerminate:application];
}

#pragma mark open URL
- (BOOL)cc_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0) {
    return YES;
};

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0) {
    [cc_message cc_appDelegateMethod:@selector(cc_application:openURL:options:) params:app,url,options];
    return [self cc_application:app openURL:url options:options];
}

#pragma mark notification
- (void)cc_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {};

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    CCLOG(@"\n>>>DeviceToken Success:%@\n", token);
    
    [cc_message cc_appDelegateMethod:@selector(cc_application:didRegisterForRemoteNotificationsWithDeviceToken:) params:application,deviceToken];
    [self cc_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}


- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    CCLOG(@"\n>>>DeviceToken Error:%@\n", error.description);
    [cc_message cc_appDelegateMethod:@selector(cc_application:didFailToRegisterForRemoteNotificationsWithError:) params:application,error];
    [self cc_application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

@end
