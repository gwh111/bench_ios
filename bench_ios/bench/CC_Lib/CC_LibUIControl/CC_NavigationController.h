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

@interface CC_NavigationController : NSObject

@property (strong,nonatomic) UINavigationController *cc_UINav;
@property (strong,nonatomic) CC_NavigationBarConfig *cc_navigationBarConfig;

+ (instancetype)shared;

- (void)cc_willInit;

- (void)cc_initNavigationBarWithTitleFont:(UIFont *)font
                               titleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                          backgroundImage:(UIImage *)backgroundImage;

- (void)cc_pushViewController:(CC_ViewController *)viewController;
- (void)cc_pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)visible;

// Returns the popped controller.
- (CC_ViewController *)cc_popViewController;
- (void)cc_popToViewController:(Class)aClass;

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr;

@end

