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

#include <malloc/malloc.h>
#import <AVKit/AVKit.h>
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load {
    [ccs registerAppDelegate:self];
}

- (void)cc_willInit {
    
//    int a=0;
//    void (^bloc)(void)=^{a;};
//    NSLog(@"%@",bloc);
//    NSLog(@"%@",^{a;});
//
//    __block NSObject *obj1=NSObject.new;
//    void (^bloc2)(void)=^{
//        NSLog(@"%@",obj1);
//        NSLog(@"%@",obj1);
//
//    };
//    bloc2();
//    return;
//    NSObject *ob = NSObject.new;
//    NSMutableDictionary *mutDic = ccs.mutDictionary;
//    [mutDic setValue:@"1" forKey:ob];
//    [mutDic setValue:@"2" forKey:ob];
    
    dispatch_queue_t queue = dispatch_queue_create("aaa", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue2 = dispatch_queue_create("aac", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue3 = dispatch_queue_create("aab", DISPATCH_QUEUE_CONCURRENT);
    
    ccs_timeCost(^{
        NSArray *array = [UIFont familyNames];
            NSString *familyName ;
            NSMutableArray *fontNames = [[NSMutableArray alloc] init];
            for(familyName in array)  {
            NSArray *names = [UIFont fontNamesForFamilyName:familyName];
                [fontNames addObjectsFromArray:names];
            }
            if ([ccs getDefault:@"fontNames"]) {
                
                for (int i = 0; i < fontNames.count; i++) {
                    NSArray *getf = [ccs getDefault:@"fontNames"];
                    NSString *current = fontNames[i];
                    BOOL has = NO;
                    for (int m = 0; m < getf.count; m++) {
                        NSString *get = getf[m];
                        if ([current is:get]) {
                            has = YES;
                        }
                    }
                    
                    if (has == NO) {
                        CCLOG(@"current%@",current);
        //                break;
                    }
                }
            }
            [ccs saveDefaultKey:@"fontNames" value:fontNames];
            NSLog(@"fontNames=%@ %lu",fontNames , (unsigned long)fontNames.count);
    }, ^(double ms) {
        
    });
    
    NSObject *obj = NSObject.new;
    int ss = class_getInstanceSize(obj.class);
    NSNumber *size = @(malloc_size((__bridge const void *)obj));
    
    float i  = 0.45 * 0.1;
    NSString *s = [ccs string:@"%.2f",i];
    CC_Money *m = [CC_Money moneyWithFloat:0.10];
    
    
    NSLog(@"%f",HEIGHT());
    [ccs configureAppStandard:@{
                                @"退出按钮字体":RF(12),
                                }];
    APP_STANDARD(@"退出按钮字体");
    
    // 组件化方法 调用推送库
//    [ccs.APNs addReceiveDeviceTokenBlock:^(BOOL success, BOOL granted, NSData *deviceToken) {
//        
//    }];
//    [ccs.APNs updateTokenToServerWithDomainUrl:[NSURL URLWithString:@"http://xxx.com"] authedUserId:@"123456" pushMessageBlock:^(NSDictionary *messageDic, BOOL lanchFromRemote) {
//        
//    }];
    
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
