//
//  AppDelegate.m
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load {
    [ccs registerAppDelegate:self];
}

- (void)cc_willInit {
    
    //入口页面
    [self cc_initViewController:ViewController.class withNavigationBarHidden:NO block:^{
        CCLOG(@"ViewController finish");
    }];
}

- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)cc_applicationWillResignActive:(UIApplication *)application {

}

- (void)cc_applicationDidEnterBackground:(UIApplication *)application {

}

- (void)cc_applicationWillEnterForeground:(UIApplication *)application {

}

- (void)cc_applicationDidBecomeActive:(UIApplication *)application {

}

- (void)cc_applicationWillTerminate:(UIApplication *)application {

}

@end
