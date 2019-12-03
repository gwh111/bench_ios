//
//  CC_UiHelper.m
//  NewWord
//
//  Created by gwh on 2017/12/15.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import "CC_CoreUI.h"
#import "UIColor+CC.h"
#import "CC_NavigationController.h"

@interface CC_CoreUI(){
    NSMutableDictionary *fontMutDic;
}

@end
@implementation CC_CoreUI
@synthesize uiDemoWidth,uiDemoHeight,uiNavBarHeight,uiTabBarHeight;

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_CoreUI.shared start];
    }];
}

- (void)start {
    
    uiDemoWidth = 375;
    uiDemoHeight = 568;
    
    uiNavBarHeight = [self relativeHeight:44];
    uiTabBarHeight = 49;
    
    NSDictionary *defaultFontDic = @{HEADLINE_FONT  :RF(24),
                                     HEADLINE_COLOR :UIColor.blackColor,
                                     TITLE_FONT     :RF(18),
                                     TITLE_COLOR    :RGBA(51, 51, 51, 1),
                                     CONTENT_FONT   :RF(16),
                                     CONTENT_COLOR  :RGBA(102, 102, 102, 1),
                                     DATE_FONT      :RF(12),
                                     DATE_COLOR     :RGBA(153, 153, 153, 1),
                                     MASTER_COLOR   :RGBA(88, 149, 247, 1),
                                     AUXILIARY_COLOR:RGBA(111, 111, 111, 1),
                                     };
    fontMutDic = defaultFontDic.mutableCopy;
}

- (void)initAppFontAndColorStandard:(NSDictionary *)defaultDic{
    [fontMutDic addEntriesFromDictionary:defaultDic];
}

- (id)appStandard:(NSString *)name {
    return fontMutDic[name];
}

- (UIFont *)relativeFont:(float)fontSize {
    return [self relativeFont:nil fontSize:fontSize];
}

- (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize {
    if (WIDTH() < 375) {
        fontSize = fontSize - 2;
    }else if (WIDTH() == 375) {
        fontSize = fontSize;
    }else{
        float rate = [self width]/uiDemoWidth;
        if (fontSize <= 10) {
            fontSize = fontSize * rate;
            return [UIFont fontWithName:fontName size:fontSize];
        }
        fontSize = 10 + (fontSize - 10) * rate;
    }
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}

- (float)relativeHeight:(float)height {
    return (int)(height * [self width]/uiDemoWidth);
}

- (float)statusBarHeight {
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (statusRect.size.height == 0) {
        return IPHONE_X ? 44 : 20;
    }
    return statusRect.size.height;
}

- (float)x {
    return 0;
}

- (float)y {
    return [self statusBarHeight];
}

- (float)width {
    return [UIScreen mainScreen].bounds.size.width;
}

- (float)height {
    return [UIScreen mainScreen].bounds.size.height;
}

- (float)safeHeight {
    return [self height] - [self y] - [self safeBottom];
}

- (float)safeBottom {
    return IPHONE_X ? 44 : 0;
}

- (id)getAView {
    UIView *showV = CC_NavigationController.shared.cc_UINav.view;
    if (!showV) {
        showV = [self getLastWindow];
    }
    return showV;
}

- (UIWindow *)getLastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window.hidden == NO){
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}

- (BOOL)isDarkMode {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return YES;
        } else if (mode == UIUserInterfaceStyleLight) {
            
        }
    }
    return NO;
}

@end

