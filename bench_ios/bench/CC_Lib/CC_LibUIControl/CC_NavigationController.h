//
//  CC_NavigationController.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_Controller.h"
#import "CC_NavigationBarConfig.h"

@interface CC_NavigationController : CC_Object

@property (strong,nonatomic) UINavigationController *cc_UINav;
@property (nonatomic,retain) NSMutableArray *cc_UINavList;
@property (strong,nonatomic) CC_NavigationBarConfig *cc_navigationBarConfig;

+ (instancetype)shared;

- (void)cc_willInit;

- (CC_ViewController *)currentVC;
- (CC_TabBarController *)currentTabBarC;

- (void)cc_initNavigationBarWithTitleFont:(UIFont *)font
                               titleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                          backgroundImage:(UIImage *)backgroundImage;

- (void)cc_pushViewController:(id)viewController animated:(BOOL)animated;
- (void)cc_pushViewController:(id)viewController;
- (void)cc_pushViewController:(id)viewController withDismissVisible:(BOOL)visible;

- (void)cc_presentViewController:(id)viewController;
- (void)cc_presentViewController:(id)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style;

// Returns the popped controller.
- (CC_ViewController *)cc_popViewController;
- (CC_ViewController *)cc_popViewControllerFrom:(id)viewController userInfo:(id)userInfo;

- (void)cc_dismissViewController;
- (void)cc_popToViewController:(Class)aClass;
- (void)cc_popToRootViewControllerAnimated:(BOOL)animated;
- (CC_ViewController *)cc_popViewControllerAnimated:(BOOL)animated;

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr;

@end

