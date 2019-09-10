//
//  CC_NavigationController.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_Controller.h"

@interface CC_NavigationController : NSObject

@property (strong,nonatomic) UINavigationController *cc_UINav;

//@property (nonatomic,retain) NSMutableArray<CC_Controller *> *cc_controllers;

+ (instancetype)shared;

- (void)cc_willInit;

- (void)cc_pushViewController:(CC_ViewController *)viewController;
- (void)cc_pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)visible;

// Returns the popped controller.
- (CC_ViewController *)cc_popViewController;
- (void)cc_popToViewController:(Class)class;

- (void)cc_pushWebViewControllerWithUrl:(NSString *)urlStr;

@end

