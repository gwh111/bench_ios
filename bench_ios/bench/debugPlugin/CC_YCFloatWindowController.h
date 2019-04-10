//
//  YCFloatWindowController.h
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCDraggableButton;
@interface YCFloatWindowController : UIViewController

- (void)setRootView; 
- (void)setHideWindow:(BOOL)hide;
- (void)setWindowSize:(float)size; // 默认button宽度

@end

