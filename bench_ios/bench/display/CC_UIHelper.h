//
//  CC_UiHelper.h
//  NewWord
//
//  Created by gwh on 2017/12/15.
//  Copyright © 2017年 gwh. All rights reserved.
//

#define CC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CC_UIHelper : NSObject

@property (nonatomic,retain) UIView *toolV;
@property (nonatomic,retain) UIView *lastV;

+ (instancetype)getInstance;
/*
 * 初始化 必须放入ui图尺寸 整个app以后的效果图全部以这个为尺寸
 * [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:568];
 */
- (void)initUIDemoWidth:(float)width andHeight:(float)height;
- (float)getUIDemoWith;
- (float)getUIDemoHeight;

- (void)initToolV;

@end

@interface ccui : NSObject

+ (float)getX;
+ (float)getY;
+ (float)getW;
+ (float)getH;

/*
 * height ui图标注的值
 * 获取根据效果图标注的适配其他机型的尺寸
 */
+ (float)getRH:(float)height;
+ (float)getRelativeHeight:(float)height;

/*
 * 如果ui图和初始化的不一样 比如以前规定用iphone6尺寸 但是这张效果图是iphone7plus尺寸时
 */
//+ (float)getRelativeHeight:(float)height withTempUIDemoWidth:(float)width andHeight:(float)height;

/*
 * obj 要调整的控件
 * 原来frame里必须是绝对值
 * x不居中
 */
+ (CGRect)adjustRelativeRect:(UIView *)obj;
/*
 * arr = @[@x @y @width @height]
 */
+ (CGRect)adjustRelativeRect:(UIView *)obj withFrameArr:(NSArray *)arr;


+ (UIFont *)getRFS:(float)fontSize;
/*
 * fontName 字体名 默认字体传nil
 * fontSize 字体标注尺寸
 * 获取根据效果图标注的适配其他机型的字体
 */
+ (UIFont *)getRelativeFont:(NSString *)fontName fontSize:(float)fontSize;
/*
 * fontName 字体名 默认字体传nil
 * fontSize 字体标注尺寸
 * baseFontSize 如果在其他机型的放大比例不适合 通过baseFontSize调整
 */
+ (UIFont *)getRelativeFont:(NSString *)fontName fontSize:(float)fontSize baseFontSize:(float)baseFontSize;

@end
