//
//  UIView+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_View,CC_Label,CC_ImageView,CC_Button,CC_ScrollView,CC_TextField,CC_TextView,
CC_TableView,CC_CollectionView,CC_WebView;

// MARK: - UI -
@interface UIView (CCUI)

/// 添加到父视图
- (UIView *(^)(id))cc_addToView;

/// 设置视图背景色
- (UIView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (UIView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (UIView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (UIView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度
- (UIView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (UIView *(^)(BOOL))cc_hidden;

/// 透明度
- (UIView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (UIView *(^)(NSString *))cc_name;

/// 设置视图tag
- (UIView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (UIView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (UIView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (UIView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (UIView *(^)(BOOL))cc_userInteractionEnabled;

@end

// MARK: - Layout -

@interface UIView (CCLayout)

/// 设置frame
- (UIView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (UIView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (UIView *(^)(CGFloat))cc_w;

/// 设置高度
- (UIView *(^)(CGFloat))cc_h;

/// 设置y值
- (UIView *(^)(CGFloat))cc_top;

/// 设置x值
- (UIView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (UIView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (UIView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (UIView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (UIView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (UIView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (UIView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (UIView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY
- (UIView *(^)(void))cc_centerYSuper;

@end

// MARK: - Actions -

@interface UIView (CCActions)

- (void)cc_addSubview:(id)view;

- (void)cc_removeViewWithName:(NSString *)name;

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
- (nullable __kindof UIView *)cc_tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id view))block;

- (void)cc_setShadow:(UIColor *)color;

- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity;

- (void)cc_setFade:(int)deep;

@end

// MARK: - UIView属性链式协议 -
@protocol CC_ViewChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_View *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_View *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_View *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_View *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_View *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_View *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_View *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_View *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_View *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_View *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_View *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_View *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_View *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_View *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_View *(^)(CGFloat))cc_top;

/// 设置x值 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_View *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_View *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_View *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_View *(^)(CGFloat))cc_centerX;

/// 设置centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_View *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_View *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_View *(^)(void))cc_centerYSuper;

@end

@protocol CC_LabelChainProtocol <NSObject>

@optional
/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_Label *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_Label *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_Label *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_Label *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_Label *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_Label *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_Label *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_Label *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_Label *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_Label *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_Label *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_Label *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_Label *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_Label *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_Label *(^)(CGFloat))cc_top;

/// 设置x值 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_Label *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_Label *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_Label *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_Label *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_Label *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_Label *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_Label *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Label *(^)(void))cc_centerYSuper;

@end

@protocol CC_ImageViewChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_ImageView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_ImageView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_ImageView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_ImageView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_ImageView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_ImageView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_ImageView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_ImageView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_ImageView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_ImageView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_ImageView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_ImageView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_ImageView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_ImageView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_ImageView *(^)(CGFloat))cc_top;

/// 设置x值 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_ImageView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_ImageView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_ImageView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_ImageView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_ImageView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_ImageView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_ImageView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ImageView *(^)(void))cc_centerYSuper;

@end

@protocol CC_ButtonChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_Button *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_Button *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_Button *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_Button *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_Button *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_Button *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_Button *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_Button *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_Button *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_Button *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_Button *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_Button *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_Button *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_Button *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_Button *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_Button *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_Button *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_Button *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_Button *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_Button *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_Button *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_Button *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_Button *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_Button *(^)(void))cc_centerYSuper;

@end

@protocol CC_TextFieldChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextField *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_TextField *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_TextField *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_TextField *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_TextField *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextField *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_TextField *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_TextField *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_TextField *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextField *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_TextField *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_TextField *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_TextField *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_TextField *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextField *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_TextField *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_TextField *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_TextField *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_TextField *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_TextField *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_TextField *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_TextField *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_TextField *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_TextField *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_TextField *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_TextField *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_TextField *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextField *(^)(void))cc_centerYSuper;

@end

@protocol CC_TextViewChainProtocol <NSObject>

@optional
/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_TextView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_TextView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_TextView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_TextView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_TextView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_TextView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_TextView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_TextView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_TextView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_TextView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_TextView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_TextView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_TextView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_TextView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_TextView *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_TextView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_TextView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_TextView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_TextView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_TextView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_TextView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_TextView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_TextView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TextView *(^)(void))cc_centerYSuper;

@end

@protocol CC_ScrollViewChainProtocol <NSObject>

@optional
/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ScrollView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_ScrollView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_ScrollView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_ScrollView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_ScrollView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ScrollView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_ScrollView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_ScrollView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_ScrollView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ScrollView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_ScrollView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_ScrollView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_ScrollView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_ScrollView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ScrollView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_ScrollView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_ScrollView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_ScrollView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_ScrollView *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_ScrollView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_ScrollView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_ScrollView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_ScrollView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_ScrollView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_ScrollView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_ScrollView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_ScrollView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_ScrollView *(^)(void))cc_centerYSuper;

@end

@protocol CC_TableViewViewChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TableView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_TableView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_TableView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_TableView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_TableView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TableView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_TableView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_TableView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_TableView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TableView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_TableView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_TableView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_TableView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_TableView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TableView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_TableView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_TableView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_TableView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_TableView *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_TableView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_TableView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_TableView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_TableView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_TableView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_TableView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_TableView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_TableView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_TableView *(^)(void))cc_centerYSuper;

@end

@protocol CC_CollectionViewChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_CollectionView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_CollectionView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_CollectionView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_CollectionView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_CollectionView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_CollectionView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_CollectionView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_CollectionView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_CollectionView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_CollectionView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_CollectionView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_CollectionView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_CollectionView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_CollectionView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_CollectionView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_CollectionView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_CollectionView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_CollectionView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_CollectionView *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_CollectionView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_CollectionView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_CollectionView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_CollectionView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_CollectionView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_CollectionView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_CollectionView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_CollectionView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_CollectionView *(^)(void))cc_centerYSuper;

@end

@protocol CC_WebViewChainProtocol <NSObject>

@optional

/// 添加到父视图 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_WebView *(^)(id))cc_addToView;

/// 设置视图背景色
- (__kindof CC_WebView *(^)(UIColor *))cc_backgroundColor;

/// 设置圆角及maskToBounds为YES
- (__kindof CC_WebView *(^)(CGFloat))cc_cornerRadius;

/// 单独设置maskToBounds
- (__kindof CC_WebView *(^)(BOOL))cc_masksToBounds;

/// 设置边框颜色[UIColor]
- (__kindof CC_WebView *(^)(UIColor *))cc_borderColor;

/// 设置边框宽度 [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_WebView *(^)(CGFloat))cc_borderWidth;

/// 是否隐藏
- (__kindof CC_WebView *(^)(BOOL))cc_hidden;

/// 透明度
- (__kindof CC_WebView *(^)(CGFloat))cc_alpha;

/// 设置视图名称类似tag
- (__kindof CC_WebView *(^)(NSString *))cc_name;

/// 设置视图tag [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_WebView *(^)(CGFloat))cc_tag;

/// 设置视图内容模式
- (__kindof CC_WebView *(^)(UIViewContentMode))cc_contentMode;

/// 等价于使用视图bounds去调用sizeThatFits:
- (__kindof CC_WebView *(^)(void))cc_sizeToFit;

/// 子视图超过边缘是否裁剪
- (__kindof CC_WebView *(^)(BOOL))cc_clipsToBounds;

/// 手势是否可用
- (__kindof CC_WebView *(^)(BOOL))cc_userInteractionEnabled;

/// 设置frame [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_WebView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame;

/// 设置尺寸
- (__kindof CC_WebView *(^)(CGFloat w,CGFloat h))cc_size;

/// 设置宽度
- (__kindof CC_WebView *(^)(CGFloat))cc_w;

/// 设置高度
- (__kindof CC_WebView *(^)(CGFloat))cc_h;

/// 设置y值
- (__kindof CC_WebView *(^)(CGFloat))cc_top;

/// 设置x值
- (__kindof CC_WebView *(^)(CGFloat))cc_left;

/// 右间距 view.left = superview.width + right - view.width;
/// @warning 请先设置父视图与自身的宽度
- (__kindof CC_WebView *(^)(CGFloat right))cc_right;

/// 下间距 view.top = superview.height + bottom - view.height;
/// @warning 请先设置父视图与自身的高度
- (__kindof CC_WebView *(^)(CGFloat bottom))cc_bottom;

/// 设置center
- (__kindof CC_WebView *(^)(CGFloat,CGFloat))cc_center;

/// 设置centerX
- (__kindof CC_WebView *(^)(CGFloat))cc_centerX;

/// 设置centerY
- (__kindof CC_WebView *(^)(CGFloat))cc_centerY;

/// 用于处理父视图x/y值非空时,设置
/// view.center = superview.center
/// 无法居中的问题
/// @warning 请先设置父视图与自身的宽高
- (__kindof CC_WebView *(^)(void))cc_centerSuper;

/// 设置centerX等于父视图的centerX
- (__kindof CC_WebView *(^)(void))cc_centerXSuper;

/// 设置centerY等于父视图的centerY [ctrl + ⌘ + ↑] 定位到.m查看实现
- (__kindof CC_WebView *(^)(void))cc_centerYSuper;

@end

@interface UIView (CCGetter)

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

NS_ASSUME_NONNULL_END
