//
//  YCFloatWindowSingleton.h
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//typedef void(^CallBack)();

@class YCFloatWindowController;
@interface YCFloatWindowSingleton : NSObject

//@property (nullable, nonatomic, copy)CallBack floatWindowCallBack;

- (void)yc_addWindowOnTarget:(nonnull id)target;
//- (void)yc_addWindowOnTarget:(nonnull id)target onClick:(nullable void(^)())block;
- (void)yc_setWindowSize:(float)size;
- (void)yc_setHideWindow:(BOOL)hide;

+ (nonnull instancetype)sharedInstance;

@end

