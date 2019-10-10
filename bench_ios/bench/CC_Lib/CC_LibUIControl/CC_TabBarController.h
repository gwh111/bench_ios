//
//  CC_TabBarController.h
//  bench_ios
//
//  Created by gwh on 2019/9/3.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_View.h"
#import "CC_Controller.h"

@class CC_View,CC_Controller;

@interface CC_TabBarController : UITabBarController

@property (nonatomic,retain) NSMutableArray *cc_controllers;
@property (nonatomic,retain) NSMutableArray<CC_ViewController *> *cc_viewControllers;

// Configuration function, adds configuration to this function
// 配置函数 在此函数中添加配置
- (void)cc_viewWillLoad;
- (void)cc_registerController:(CC_Controller *)controller;
- (void)cc_initWithClasses:(NSArray *)classes
                    images:(NSArray *)images
            selectedImages:(NSArray *)selectedImages;

- (void)cc_initWithClasses:(NSArray *)classes
                    titles:(NSArray *)titles
                    images:(NSArray *)images
            selectedImages:(NSArray *)selectedImages
                titleColor:(UIColor *)titleColor
        selectedTitleColor:(UIColor *)selectedTitleColor;

// Function used in controller
// 功能函数 在控制器使用
- (CC_Controller *)cc_controllerWithName:(NSString *)name;

- (void)cc_addTabBarItemWithClass:(id)cls
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            index:(NSInteger)index;

- (void)cc_addTabBarItemWithClass:(id)cls
                            title:(NSString *)title
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            index:(NSInteger)index;

- (void)cc_deleteItemAtIndex:(NSInteger)index;
// if number > '99' will show '99+' as result.
- (void)cc_updateBadgeNumber:(NSUInteger)badgeNumber atIndex:(NSInteger)index;

// Trigger function, triggering after the condition of trigger function is reached
// 触发函数 条件达到后触发
- (void)cc_viewDidLoad;
- (void)cc_viewWillAppear;
- (void)cc_viewWillDisappear;
- (void)cc_didReceiveMemoryWarning;
- (void)cc_dealloc;

@end
