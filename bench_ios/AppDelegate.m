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

+ (void)load{
    [ccs registerAppDelegate:self];
}

- (void)cc_willInit{
    
    [ccs configureAppStandard:@{
                                YL_SUBTITLE_FONT  :RF(13),
                                YL_SUBTITLE_COLOR :UIColor.whiteColor
                                }];
    
    // 组件化方法 调用推送库
    [ccs APNs_updateTokenToServerWithDomainUrl:[NSURL URLWithString:@"http://xxx.com"] authedUserId:@"123456" pushMessageBlock:^(NSDictionary * _Nonnull messageDic, BOOL lanchFromRemote) {
        
    }];
    
    CCLOG(@"%@",APP_STANDARD(YL_SUBTITLE_FONT));
    
    //入口单页面
    [self cc_init:HomeVC.class withNavigationBarHidden:NO block:^{
        [self launch];
    }];
    
    //入口TabBar
//    [self cc_init:TestTabBarController.class withNavigationBarHidden:YES block:^{
//        [self launch];
//    }];
    
}

- (void)launch{
    
}

- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return YES;
}

- (void)cc_applicationWillResignActive:(UIApplication *)application{
    
}

@end
