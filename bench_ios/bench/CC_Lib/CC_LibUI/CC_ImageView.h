//
//  CC_ImageView.h
//  bench_ios
//
//  Created by gwh on 2018/10/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Lib+UIImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_ImageView : UIImageView

#pragma mark clase "CC_ImageView" property extention
// UIView property
- (CC_ImageView *(^)(NSString *))cc_name;
- (CC_ImageView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_ImageView *(^)(CGFloat,CGFloat))cc_size;
- (CC_ImageView *(^)(CGFloat))cc_width;
- (CC_ImageView *(^)(CGFloat))cc_height;

- (CC_ImageView *(^)(CGFloat,CGFloat))cc_center;
- (CC_ImageView *(^)(CGFloat))cc_centerX;
- (CC_ImageView *(^)(CGFloat))cc_centerY;
- (CC_ImageView *(^)(CGFloat))cc_top;
- (CC_ImageView *(^)(CGFloat))cc_bottom;
- (CC_ImageView *(^)(CGFloat))cc_left;
- (CC_ImageView *(^)(CGFloat))cc_right;
- (CC_ImageView *(^)(UIColor *))cc_backgroundColor;
- (CC_ImageView *(^)(CGFloat))cc_cornerRadius;
- (CC_ImageView *(^)(CGFloat))cc_borderWidth;
- (CC_ImageView *(^)(UIColor *))cc_borderColor;
- (CC_ImageView *(^)(BOOL))cc_userInteractionEnabled;
- (CC_ImageView *(^)(id))cc_addToView;

// UIImageView property
- (CC_ImageView *(^)(UIImage *))cc_image;
- (CC_ImageView *(^)(NSArray<UIImage *> *))cc_animationImages;
- (CC_ImageView *(^)(NSTimeInterval))cc_animationDuration;
- (CC_ImageView *(^)(NSInteger))cc_animationRepeatCount;

@end

NS_ASSUME_NONNULL_END
