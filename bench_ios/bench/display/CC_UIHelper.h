//
//  CC_UiHelper.h
//  NewWord
//
//  Created by gwh on 2017/12/15.
//  Copyright © 2017年 gwh. All rights reserved.
//

#define CC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//导航栏 状态栏
#define CC_NAV_BAR_HEIGHT (44.f)
#define CC_STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define CC_STATUS_AND_NAV_BAR_HEIGHT (CC_STATUS_BAR_HEIGHT + CC_NAV_BAR_HEIGHT)
//iPhoneX
#define CC_iPhoneX (MAX(CC_SCREEN_WIDTH, CC_SCREEN_HEIGHT) >= 812)
// tabBar高度
#define CC_TAB_BAR_HEIGHT (CC_iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define CC_HOME_INDICATOR_HEIGHT (CC_iPhoneX ? 34.f : 0.f)

#define RH(f) [ccui getRH:f]
#define RF(f) [ccui getRFS:f]

#define UI_BIG_TITLE_FONT [CC_UIHelper getInstance].bigTitleFont
#define UI_BIG_TITLE_FONT_COLOR [CC_UIHelper getInstance].bigTitleFontColor

#define UI_TITLE_FONT [CC_UIHelper getInstance].titleFont
#define UI_TITLE_FONT_COLOR [CC_UIHelper getInstance].titleFontColor

#define UI_CONTENT_FONT [CC_UIHelper getInstance].contentFont
#define UI_CONTENT_FONT_COLOR [CC_UIHelper getInstance].contentFontColor

#define UI_DATE_FONT [CC_UIHelper getInstance].dateFont
#define UI_DATE_FONT_COLOR [CC_UIHelper getInstance].dateFontColor

#define UI_MAIN_COLOR [CC_UIHelper getInstance].mainColor
#define UI_SUB_COLOR [CC_UIHelper getInstance].subColor

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CC_UIHelper : NSObject

/**
 *  效果图的尺寸
 */
@property(nonatomic,assign) float uiDemoWidth;
@property(nonatomic,assign) float uiDemoHeight;

/**
 *  app大标题的字体
 */
@property(nonatomic,retain) UIFont *bigTitleFont;

/**
 *  app常规标题的字体
 */
@property(nonatomic,retain) UIFont *titleFont;

/**
 *  app常规内容的字体
 */
@property(nonatomic,retain) UIFont *contentFont;

/**
 *  app常规日期的字体
 */
@property(nonatomic,retain) UIFont *dateFont;

/**
 *  app主色调
 */
@property(nonatomic,retain) UIColor *mainColor;

/**
 *  app辅色调
 */
@property(nonatomic,retain) UIColor *subColor;

/**
 *  app大标题字体颜色
 */
@property(nonatomic,retain) UIColor *bigTitleFontColor;

/**
 *  app常规标题字体颜色
 */
@property(nonatomic,retain) UIColor *titleFontColor;

/**
 *  app常规内容字体颜色
 */
@property(nonatomic,retain) UIColor *contentFontColor;

/**
 *  app常规日期字体颜色
 */
@property(nonatomic,retain) UIColor *dateFontColor;


#pragma mark 模型文件处理
/**
 *  模型文件路径列表
 */
@property(nonatomic,retain) NSMutableArray *modelPaths;

/**
 *  模型路径对应模型名称的字典
 */
@property(nonatomic,retain) NSMutableDictionary *modelsDic;

+ (instancetype)getInstance;
/*
 * 初始化 必须放入ui图尺寸 整个app以后的效果图全部以这个为尺寸
 * [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:568];
 */
- (void)initUIDemoWidth:(float)width andHeight:(float)height;

- (float)getUIDemoWith;
- (float)getUIDemoHeight;

/**
 *  添加app用的到的模型文件夹路径
    可添加多个 建议1个app用1个管理
    return 返回该路径下模型个数
 */
- (int)addModelDocument:(NSString *)path;

/**
 *  添加完路径 把路径加载到内存
    这里不读取文件加载到内存 防止浪费内存
 */
- (int)initModels;

@end

/**
 *  写成动态方法方便后期出现新设备随时更改
 */
@interface ccui : NSObject

/**
 *  获取规范字体
 */
+ (UIFont *)getUIFontWithType:(NSString *)type;
/**
 *  使用其他自定义字体
 */
+ (UIFont *)getUIFontWithName:(NSString *)name type:(NSString *)type;

/**
 *  oc代码获取的状态栏高度
 */
+ (float)getStatusH;
+ (float)getX;
/**
 *  刘海的高度
 */
+ (float)getY;
/**
 *  状态栏高度
 */
+ (float)getSY;
/**
 *  设备宽度
 */
+ (float)getW;
/**
 *  去掉刘海的高度
 */
+ (float)getH;
/**
 *  减去状态栏的高度
 */
+ (float)getSH;

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

@end
