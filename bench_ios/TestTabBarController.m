//
//  TestTabBarController.m
//  bench_ios
//
//  Created by relax on 2019/9/9.
//

#import "TestTabBarController.h"
#import "HomeVC.h"
#import "ccs.h"
#import <objc/runtime.h>

@interface TestTabBarController ()

@end

@implementation TestTabBarController

- (void)cc_viewWillLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    // 纯图片 tabbar
    //    [self cc_initWithClasses:@[HomeVC.class,UIViewController.class]
    //                      images:@[@"tabbar_mine_high",@"tabbar_mine_high"]
    //              selectedImages:@[@"tabbar_mine_high",@"tabbar_mine_high"]];
    // 图片 + 文字 tabbar
    [self cc_initWithClasses:@[HomeVC.class,HomeVC.class]
                      titles:@[@"首页",@"首页"]
                      images:@[@"tabbar_mine_high",@"tabbar_mine_high"]
              selectedImages:@[@"tabbar_mine_high",@"tabbar_mine_high"]
                  titleColor:UIColor.blackColor
          selectedTitleColor:UIColor.blueColor];
    
    //    [self cc_addTabBarItemWithClass:UIViewController.class
    //                              image:@"tabbar_mine_high"
    //                      selectedImage:@"tabbar_mine_high"
    //                              index:2];
    
    [self cc_addTabBarItemWithClass:CC_ViewController.class
                              title:@"我的"
                              image:@"tabbar_mine_high"
                      selectedImage:@"tabbar_mine_high"
                              index:2];
    
    [self cc_updateBadgeNumber:200 atIndex:2];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
