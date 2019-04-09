//
//  YCFloatWindow.h
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCFloatWindow : NSObject

+ (void)yc_addWindowOnTarget:(nonnull id)target;
/* add the floaitng window to the target and the callback block will be excuted when click the button */
//+ (void)yc_addWindowOnTarget:(nonnull id)target onClick:(nullable void(^)())callback;
/* you can resize the view's size, 50 by default if you don't set it */
+ (void)yc_setWindowSize:(float)size;
/* you can hide the view or show it again */
+ (void)yc_setHideWindow:(BOOL)hide;

@end

