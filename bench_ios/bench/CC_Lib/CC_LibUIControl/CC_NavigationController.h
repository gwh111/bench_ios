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
@property (nonatomic,retain) NSMutableArray *cc_UINavList;
@property (strong,nonatomic) CC_NavigationBarConfig *cc_navigationBarConfig;

+ (instancetype)shared;

- (void)cc_willInit;

- (void)cc_initNavigationBarWithTitleFont:(UIFont *)font
                               titleColor:(UIColor *)titleColor
                          backgroundColor:(UIColor *)backgroundColor
                          backgroundImage:(UIImage *)backgroundImage;

- (void)cc_pushViewController:(CC_ViewController *)viewController;
- (void)cc_pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)visible;

- (void)cc_presentViewController:(CC_ViewController *)viewController;
- (void)cc_presentViewController:(CC_ViewController *)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style;

// Returns the popped controller.
- (CC_ViewController *)cc_popViewController;
- (CC_ViewController *)cc_popViewControllerFrom:(CC_ViewController *)viewController userInfo:(id)userInfo;

- (void)cc_dismissViewController;
- (void)cc_popToViewController:(Class)aClass;

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr;

@end

