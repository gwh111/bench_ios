//
//  YCFloatWindow.h
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_FloatWindow : NSObject

/**
 *  添加debug tool到视图
    add the floaitng window to the target and the callback block will be excuted when click the button
 */
+ (void)addWindowOnTarget:(nonnull id)target;

/**
 *  you can resize the view's size, 50 by default if you don't set it
 */
+ (void)setWindowSize:(float)size;

/**
 *  you can hide the view or show it again
 */
+ (void)setHideWindow:(BOOL)hide;

@end

