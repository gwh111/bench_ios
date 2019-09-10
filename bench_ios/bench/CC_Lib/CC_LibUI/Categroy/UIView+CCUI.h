//
//  UIView+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CCUILayoutPosition) {
    CCUILayoutPostionTop,
    CCUILayoutPositionLeft,
    CCUILayoutPositionBottom,
    CCUILayoutPositionRight,
};

@protocol CCObservableObject <NSObject>



@end

@interface UIView (CCUI) 

- (__kindof UIView *(^)(UIView *))cc_addToView;
- (__kindof UIView *(^)(UIColor *))cc_backgroundColor;

/**
 Usage:
 
 view.cc_cornerRadius(raidus)
 
 before
 
 view.layer.cornerRadius = raius;
 view.layer.maskToBounds = YES;
 */
- (__kindof UIView *(^)(CGFloat))cc_cornerRadius;
- (__kindof UIView *(^)(BOOL))cc_userInteractionEnabled;

/**
 Usage:
 
 view.cc_borderColor(borderColor)
 
 before
    view.layer.borderColor = borderColor.CGColor
 */
- (__kindof UIView *(^)(UIColor *))cc_borderColor;

/**
 Usage:
 
 view.cc_BorderWidth(borderWidth)
 
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

#warning TODO The method name is too long
/**
 
 用于处理父视图x/y值非空时,设置
 view.center = superview.center
 无法居中的问题
 
 @warning 请先设置父视图与自身的宽高
 */
- (__kindof UIView *(^)(void))cc_centerEqualSuperview;
- (__kindof UIView *(^)(void))cc_centerXEqualSuperview;
- (__kindof UIView *(^)(void))cc_centerYEqualSuperview;

///-------------------------------
/// @name Relative Postion
///-------------------------------
#warning TODO Layout
/**
 
 */
- (__kindof UIView *(^)(UIView *relateView,CCUILayoutPosition position,...))cc_alignment;

@end

@interface UIView (CCActions)

/// Combine ObservableObject
- (__kindof UIView *(^)(id<CCObservableObject>))cc_bind;

- (nullable __kindof UIView *)cc_viewWithName:(NSString *)name;

- (nullable UIViewController *)cc_viewControllerByResponder;
- (nullable UIViewController *)cc_viewControllerByWindow;

- (__kindof UIView *(^)(NSTimeInterval,void (^)(__kindof UIView *sender)))cc_tappedIntervalWithBlock;

- (void)cc_tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id view))block;

#warning TODO
/// Custom
- (void)cc_setShadow:(UIColor *)color;
- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity;
- (void)cc_setFade:(int)deep;

@end

/// 防重复点击 默认0.1s
UIKIT_EXTERN CGFloat CCDefaultTapInterval;

NS_ASSUME_NONNULL_END
