//
//  CC_WebView.h
//  bench_ios
//
//  Created by gwh on 2019/8/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "CC_Lib+UIView.h"
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN


@interface CC_WebView : WKWebView

#pragma mark clase "CC_WebView" property extention
// UIView property
- (CC_WebView *(^)(NSString *))cc_name;
- (CC_WebView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_WebView *(^)(CGFloat,CGFloat))cc_size;
- (CC_WebView *(^)(CGFloat))cc_width;
- (CC_WebView *(^)(CGFloat))cc_height;

- (CC_WebView *(^)(CGFloat,CGFloat))cc_center;
- (CC_WebView *(^)(CGFloat))cc_centerX;
- (CC_WebView *(^)(CGFloat))cc_centerY;
- (CC_WebView *(^)(CGFloat))cc_top;
- (CC_WebView *(^)(CGFloat))cc_bottom;
- (CC_WebView *(^)(CGFloat))cc_left;
- (CC_WebView *(^)(CGFloat))cc_right;
- (CC_WebView *(^)(UIColor *))cc_backgroundColor;
- (CC_WebView *(^)(CGFloat))cc_cornerRadius;
- (CC_WebView *(^)(CGFloat))cc_borderWidth;
- (CC_WebView *(^)(UIColor *))cc_borderColor;
- (CC_WebView *(^)(BOOL))cc_userInteractionEnabled;
- (CC_WebView *(^)(id))cc_addToView;

// CC_WebView property
- (CC_WebView *(^)(id<WKNavigationDelegate>))cc_navigationDelegate;
- (CC_WebView *(^)(id<WKUIDelegate>))cc_UIDelegate;
- (CC_WebView *(^)(BOOL))cc_allowsBackForwardNavigationGestures;

@end

NS_ASSUME_NONNULL_END
