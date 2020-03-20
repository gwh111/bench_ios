//
//  AppDelegate.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "AppDelegate.h"
#import "ccs.h"
#import "TestViewController1.h"
#import "HomeVC.h"
#import "TestTabBarController.h"

// 在pch或指定位置导入组件化分类
#import "ccs+APNs.h"

#define YL_SUBTITLE_FONT     @"YL_SUBTITLE_FONT"
#define YL_SUBTITLE_COLOR    @"YL_SUBTITLE_COLOR"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load {
    [ccs registerAppDelegate:self];
}

- (void)cc_willInit {
    
    [ccs configureAppStandard:@{
                                @"退出按钮字体":RF(12),
                                YL_SUBTITLE_FONT  :RF(13),
                                YL_SUBTITLE_COLOR :UIColor.whiteColor
                                }];
    APP_STANDARD(@"退出按钮字体");
    
    // 组件化方法 调用推送库
    [ccs.APNs addReceiveDeviceTokenBlock:^(BOOL success, BOOL granted, NSData *deviceToken) {
        
    }];
    [ccs.APNs updateTokenToServerWithDomainUrl:[NSURL URLWithString:@"http://xxx.com"] authedUserId:@"123456" pushMessageBlock:^(NSDictionary *messageDic, BOOL lanchFromRemote) {
        
    }];
    
    CCLOG(@"%@",APP_STANDARD(YL_SUBTITLE_FONT));
    
    //入口单页面
//    [self cc_initViewController:HomeVC.class withNavigationBarHidden:NO block:^{
//        [self launch];
//    }];
    
    //入口TabBar
    [self cc_initTabbarViewController:TestTabBarController.class block:^{
        [self launch];
    }];
    
}

- (void)launch{
    
}

- (void)cc_applicationWillResignActive:(UIApplication *)application{
    
}

- (void)cc_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

}

@end
