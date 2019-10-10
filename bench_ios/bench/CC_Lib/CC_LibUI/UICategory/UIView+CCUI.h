//
//  UIView+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// unuse
typedef NS_ENUM(NSInteger,CCUILayout) {
    CCUILayoutTop,
    CCUILayoutLeft,
    CCUILayoutBottom,
    CCUILayoutRight,
};

@interface UIView (CCUI)

///-------------------------------
/// @name Chain
///-------------------------------

- (__kindof UIView *(^)(id))cc_addToView;
- (__kindof UIView *(^)(UIColor *))cc_backgroundColor;

/**
 Usage:
 
 view.cc_cornerRadius(raidus)
 
 before
 
 view.layer.cornerRadius = raius;
 view.layer.maskToBounds = YES;
 */
- (__kindof UIView *(^)(CGFloat))cc_cornerRadius;

/**
 Usage:
 
 view.cc_borderColor(borderColor)
 
 before
    view.layer.borderColor = borderColor.CGColor
 */
- (__kindof UIView *(^)(UIColor *))cc_borderColor;

/**
 Usage:
 
 view.cc_borderWidth(borderWidth)
 
 before
    view.layer.borderWidth = borderWidth
 */
- (__kindof UIView *(^)(CGFloat))cc_borderWidth;
- (__kindof UIView *(^)(BOOL))cc_hidden;
- (__kindof UIView *(^)(CGFloat))cc_alpha;
- (__kindof UIView *(^)(NSString *))cc_name;
- (__kindof UIView *(^)(CGFloat))cc_tag;
- (__kindof UIView *(^)(UIViewContentMode))cc_contentMode;
- (__kindof UIView *(^)(void))cc_sizeToFit;
- (__kindof UIView *(^)(BOOL))cc_clipsToBounds;
- (__kindof UIView *(^)(BOOL))cc_userInteractionEnabled;

///-------------------------------
/// @name Older Frame Extension
///-------------------------------
@property (nonatomic, copy) NSString *name;
@property CGSize size;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@end

@interface UIView (CCLayout)

///-------------------------------
/// @name Self Postion
///-------------------------------

- (__kindof UIView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;
- (__kindof UIView *(^)(CGFloat w,CGFloat h))cc_size;
- (__kindof UIView *(^)(CGFloat))cc_w;
- (__kindof UIView *(^)(CGFloat))cc_h;
- (__kindof UIView *(^)(CGFloat))cc_top;
- (__kindof UIView *(^)(CGFloat))cc_left;

/**
 
 右间距
 
 view.left = superview.width + right - view.width;
 
 @warning 请先设置父视图与自身的宽度
 */
- (__kindof UIView *(^)(CGFloat right))cc_right;

/**
 下间距
 
 view.top = superview.height + bottom - view.height;
 
 @warning 请先设置父视图与自身的高度
 */
- (__kindof UIView *(^)(CGFloat bottom))cc_bottom;
- (__kindof UIView *(^)(CGFloat,CGFloat))cc_center;
- (__kindof UIView *(^)(CGFloat))cc_centerX;
- (__kindof UIView *(^)(CGFloat))cc_centerY;

/**
 
 用于处理父视图x/y值非空时,设置
 view.center = superview.center
 无法居中的问题
 
 @warning 请先设置父视图与自身的宽高
 */
- (__kindof UIView *(^)(void))cc_centerSuper;
- (__kindof UIView *(^)(void))cc_centerXSuper;
- (__kindof UIView *(^)(void))cc_centerYSuper;

///-------------------------------
/// @name Relative Postion
///-------------------------------

/// - (__kindof UIView *(^)(UIView *relateView,CCUILayoutPosition position,...))cc_alignment;

@end

@interface UIView (CCActions)

/// unimplement Combine ObservableObject
/// - (__kindof UIView *(^)(id<CCObservableObject>))cc_bind;

- (void)cc_addSubview:(id)view;
- (void)cc_removeViewWithName:(NSString *)name;

//- (__kindof UIView *(^)(void (^)(id view)))cc_tapped;
//- (__kindof UIView *(^)(NSTimeInterval,void (^)(__kindof UIView *sender)))cc_tappedInterval;

// extentation like 'view withTag:', so that you can get view with name, scan from view to subview.
// 如果对view设置了name，可根据name获取view 包括子视图
- (nullable __kindof UIView *)cc_viewWithName:(NSString *)name;

- (nullable __kindof UIView *)cc_viewWithName:(NSString *)name inView:(UIView *)inView;

// scan all the views & subviews on vc
// warning: time consuming, use 'cc_viewWithName:' as recommand.
- (nullable __kindof id)cc_viewWithNameOnVC:(NSString *)name;

/// 通过响应链自底向上查找,找到包含当前视图的控制器
- (nullable UIViewController *)cc_viewController;

/// 通过keyWindow自顶向下查找,找到包含当前视图的控制器
+ (nullable UIViewController *)cc_viewControllerByWindow;

// 添加tap点击的block
// @param interval 下次点击需要间隔多久, 不小于0
- (void)cc_tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id view))block;

- (void)cc_setShadow:(UIColor *)color;

- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity;

- (void)cc_setFade:(int)deep;

@end

NS_ASSUME_NONNULL_END
