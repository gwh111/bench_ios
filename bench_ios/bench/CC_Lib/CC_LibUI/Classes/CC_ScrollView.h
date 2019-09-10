//
//  CC_ScrollView.h
//  testbenchios
//
//  Created by gwh on 2019/8/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_ScrollView : UIScrollView

#pragma mark clase "CC_ScrollView" property extention
// UIView property
- (CC_ScrollView *(^)(NSString *))cc_name;
- (CC_ScrollView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_ScrollView *(^)(CGFloat,CGFloat))cc_size;
- (CC_ScrollView *(^)(CGFloat))cc_width;
- (CC_ScrollView *(^)(CGFloat))cc_height;

- (CC_ScrollView *(^)(CGFloat,CGFloat))cc_center;
- (CC_ScrollView *(^)(CGFloat))cc_centerX;
- (CC_ScrollView *(^)(CGFloat))cc_centerY;
- (CC_ScrollView *(^)(CGFloat))cc_top;
- (CC_ScrollView *(^)(CGFloat))cc_bottom;
- (CC_ScrollView *(^)(CGFloat))cc_left;
- (CC_ScrollView *(^)(CGFloat))cc_right;
- (CC_ScrollView *(^)(UIColor *))cc_backgroundColor;
- (CC_ScrollView *(^)(CGFloat))cc_cornerRadius;
- (CC_ScrollView *(^)(CGFloat))cc_borderWidth;
- (CC_ScrollView *(^)(UIColor *))cc_borderColor;
- (CC_ScrollView *(^)(BOOL))cc_userInteractionEnabled;
- (CC_ScrollView *(^)(id))cc_addToView;

// UIScrollView property
- (CC_ScrollView *(^)(CGPoint))cc_contentOffset;
- (CC_ScrollView *(^)(CGSize))cc_contentSize;
- (CC_ScrollView *(^)(id<UIScrollViewDelegate>))cc_delegate;

@end

NS_ASSUME_NONNULL_END
