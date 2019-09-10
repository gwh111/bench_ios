//
//  UIView+CC.h
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_Lib+UIView.h"
#import "CC_Label.h"
#import "CC_ViewController.h"
#import "CC_TapGestureRecognizer.h"
#import "CC_Color.h"
#import "CC_CoreUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CC_Lib)

@property (nonatomic, retain) NSString *name;

#pragma mark frame property
@property CGSize size;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

#pragma mark clase "UIView" property extention
- (UIView *(^)(NSString *))cc_name_id;
- (UIView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame_id;
- (UIView *(^)(CGFloat,CGFloat))cc_size_id;
- (UIView *(^)(CGFloat))cc_width_id;
- (UIView *(^)(CGFloat))cc_height_id;

- (UIView *(^)(CGFloat,CGFloat))cc_center_id;
- (UIView *(^)(CGFloat))cc_centerX_id;
- (UIView *(^)(CGFloat))cc_centerY_id;
- (UIView *(^)(CGFloat))cc_top_id;
- (UIView *(^)(CGFloat))cc_bottom_id;
- (UIView *(^)(CGFloat))cc_left_id;
- (UIView *(^)(CGFloat))cc_right_id;
- (UIView *(^)(UIColor *))cc_backgroundColor_id;
- (UIView *(^)(CGFloat))cc_cornerRadius_id;
- (UIView *(^)(CGFloat))cc_borderWidth_id;
- (UIView *(^)(UIColor *))cc_borderColor_id;
- (UIView *(^)(BOOL))cc_userInteractionEnabled_id;
- (UIView *(^)(id))cc_addToView_id;
- (UIView *(^)(void (^)(id view)))cc_tapped;
- (UIView *(^)(float interval, void (^)(id view)))cc_tappedInterval;

#pragma mark function
- (void)cc_addSubview:(id)view;
- (void)cc_removeViewWithName:(NSString *)name;

// extentation like 'view withTag:', so that you can get view with name, scan from view to subview.
// 如果对view设置了name，可根据name获取view 包括子视图
- (nullable __kindof id)cc_viewWithName:(NSString *)name;

// scan all the views & subviews on vc
// warning: time consuming, use 'cc_viewWithName:' as recommand.
- (nullable __kindof id)cc_viewWithNameOnVC:(NSString *)name;

// 添加tap点击的block
// @param interval 下次点击需要间隔多久, 不小于0
- (void)cc_tappedInterval:(float)interval block:(void (^)(id view))block;
//- (void)cc_stopTap;

// @param badge msg number
- (void)cc_updateBadge:(NSString *)badge;
- (void)cc_updateBadgeBackgroundColor:(UIColor *)backgroundColor;
- (void)cc_updateBadgeTextColor:(UIColor *)textColor;

- (void)cc_setShadow:(UIColor *)color;
- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity;

// 设置底部渐变消失
- (void)cc_setFade:(int)deep;

- (UIViewController *)cc_viewController;
- (UIWindow *)cc_lastWindow;

@end

NS_ASSUME_NONNULL_END
