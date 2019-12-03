//
//  CC_UiHelper.h
//  NewWord
//
//  Created by gwh on 2017/12/15.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

//App Font And Color Standard
#define HEADLINE_FONT     @"HEADLINE_FONT"
#define HEADLINE_COLOR    @"HEADLINE_COLOR"
#define TITLE_FONT        @"TITLE_FONT"
#define TITLE_COLOR       @"TITLE_COLOR"
#define CONTENT_FONT      @"CONTENT_FONT"
#define CONTENT_COLOR     @"CONTENT_COLOR"
#define DATE_FONT         @"DATE_FONT"
#define DATE_COLOR        @"DATE_COLOR"
#define MASTER_COLOR      @"MASTER_COLOR"
#define AUXILIARY_COLOR   @"AUXILIARY_COLOR"

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//导航栏 状态栏
#define NAV_BAR_HEIGHT CC_CoreUI.shared.uiNavBarHeight
#define STATUS_BAR_HEIGHT [CC_CoreUI.shared statusBarHeight]
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
#define TABBAR_BAR_HEIGHT CC_CoreUI.shared.uiTabBarHeight

#define RH(f) [CC_CoreUI.shared relativeHeight:f]
#define RF(f) [CC_CoreUI.shared relativeFont:f]
#define BRF(f) [CC_CoreUI.shared relativeFont:@"Helvetica-Bold" fontSize:f]

#define X() [CC_CoreUI.shared x]
#define Y() [CC_CoreUI.shared y]
#define WIDTH() [CC_CoreUI.shared width]
#define HEIGHT() [CC_CoreUI.shared height]
#define SAFE_HEIGHT() [CC_CoreUI.shared safeHeight]

@interface CC_CoreUI : NSObject

// Init base UI frame, default is 375/568 (iphone6)
// 初始化 必须放入ui图尺寸 整个app以后的效果图全部以这个为尺寸
@property(nonatomic,assign) float uiDemoWidth;
@property(nonatomic,assign) float uiDemoHeight;

// Default is 'RH(44)'
@property(nonatomic,assign) float uiNavBarHeight;
@property(nonatomic,assign) float uiTabBarHeight;

+ (instancetype)shared;

- (void)start;

/** init app ui standard */
- (void)initAppFontAndColorStandard:(NSDictionary *)defaultDic;

/** get app ui standard with specific name, default is:
@"大标题":RF(24),
@"大标题颜色":COLOR_BLACK,
@"标题":RF(18),
@"标题颜色":RGBA(51, 51, 51, 1),
@"内容":RF(16),
@"内容颜色":RGBA(102, 102, 102, 1),
@"日期":RF(12),
@"日期颜色":RGBA(153, 153, 153, 1),
@"主色":RGBA(88, 149, 247, 1),
@"辅色":RGBA(111, 111, 111, 1), */
- (id)appStandard:(NSString *)name;

- (float)statusBarHeight;

- (float)x;
// consider safe area y, =cc_statusBarHeight
- (float)y;
- (float)width;
- (float)height;

/** height cut safe area and status bar */
- (float)safeHeight;
- (float)safeBottom;

/* get width based on ui demo width&height */
- (float)relativeHeight:(float)height;

/* get font based on ui demo width&height, also can use thd font */
- (UIFont *)relativeFont:(float)fontSize;
- (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize;

- (id)getAView;

- (BOOL)isDarkMode;

@end

