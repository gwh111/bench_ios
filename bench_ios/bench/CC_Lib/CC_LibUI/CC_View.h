//
//  CC_View.h
//  testbenchios
//
//  Created by gwh on 2019/8/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"

NS_ASSUME_NONNULL_BEGIN

@class CC_ViewController;

@interface CC_View : UIView

#pragma mark clase "CC_View" property extention
// UIView property
- (CC_View *(^)(NSString *))cc_name;
- (CC_View *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_View *(^)(CGFloat,CGFloat))cc_size;
- (CC_View *(^)(CGFloat))cc_width;
- (CC_View *(^)(CGFloat))cc_height;

- (CC_View *(^)(CGFloat,CGFloat))cc_center;
- (CC_View *(^)(CGFloat))cc_centerX;
- (CC_View *(^)(CGFloat))cc_centerY;
- (CC_View *(^)(CGFloat))cc_top;
- (CC_View *(^)(CGFloat))cc_bottom;
- (CC_View *(^)(CGFloat))cc_left;
- (CC_View *(^)(CGFloat))cc_right;
- (CC_View *(^)(UIColor *))cc_backgroundColor;
- (CC_View *(^)(CGFloat))cc_cornerRadius;
- (CC_View *(^)(CGFloat))cc_borderWidth;
- (CC_View *(^)(UIColor *))cc_borderColor;
- (CC_View *(^)(BOOL))cc_userInteractionEnabled;
- (CC_View *(^)(id))cc_addToView;

#pragma mark function
- (CC_ViewController *)cc_viewController;

@end

NS_ASSUME_NONNULL_END
