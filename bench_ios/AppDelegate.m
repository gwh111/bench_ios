//
//  AppDelegate.m
//  bench_ios
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *iiii=[ccs getKeychainUUID];
    
    int v1=[CC_Logic compareV1:@"1.3" cutV2:@"1.2.1"];
//    int v2=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3.2"];
//    int v3=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3.3"];
    int v2=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.2"];
    int v3=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.3"];
    int v4=[CC_Logic compareV1:@"1.3.2" cutV2:@"1.4"];
    
    NSDate *d1=[NSDate date];
    CCLOG(@"d1=%@",d1);
    [ccs delay:.5 block:^{
        NSDate *d2=[NSDate date];
        CCLOG(@"d2=%@",d2);
        NSTimeInterval d3=[CC_Date compareDate:d2 cut:d1]*1000;
        CCLOG(@"d3=%f",d3);
    }];
    
    int i=[CC_Validate hasChinese:@""];
    
    float f1=1.25;
    float f2=1.24;
    float f3=1.26;
    float f4=1.35;
    float f5=1.34;
    float f6=1.36;
    CCLOG(@"%.1f %.1f %.1f    %.1f %.1f %.1f",f1,f2,f3,f4,f5,f6);
    NSDecimalNumberHandler *handel=[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:6 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:@"1.25"];
    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:@"2"];
    
    NSDecimalNumber *aDN = [[NSDecimalNumber alloc] initWithFloat:0.125532];
    NSDecimalNumber *resultDN = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *str=[NSString stringWithFormat:@"%@",resultDN];
    NSString *str1=[NSString stringWithFormat:@"1.254"];
    str1=[str1 getDecimalStrWithMode:NSRoundPlain scale:1];
    CCLOG(@"%@ %@ %@",resultDN,str,str1);
#pragma mark init
    //    [CC_Share getInstance].ccDebug=1;
    //设置基准 效果图的尺寸即可
    [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
    NSString *absoluteFilePath=CASAbsoluteFilePath(@"stylesheet.cas");
    [CC_ClassyExtend initSheet:absoluteFilePath];
    [CC_ClassyExtend parseCas];
    
    
    [ccs saveKeychainName:@"kkkd" str:@"zxca哦aaa"];
    NSString *get=[ccs getKeychainName:@"kkkd"];
    
//    [UIApplication hookUIApplication];
//    [UIViewController hookUIViewController];
    [UINavigationController hookUINavigationController_push];
    [UINavigationController hookUINavigationController_pop];
    
    ViewController *appStartController=[[ViewController alloc]init];
    UINavigationController *navController =[[UINavigationController alloc] initWithRootViewController:appStartController];
//    navController.navigationBarHidden=YES;
    self.window.rootViewController=navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
