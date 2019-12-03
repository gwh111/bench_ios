//
//  CC_WebView.h
//  bench_ios
//
//  Created by gwh on 2019/8/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "CC_CoreUI.h"
#import "UIView+CCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_WebView : WKWebView <CC_WebViewChainProtocol>

- (__kindof CC_WebView *(^)(id<WKNavigationDelegate>))cc_navigationDelegate;
- (__kindof CC_WebView *(^)(id<WKUIDelegate>))cc_UIDelegate;
- (__kindof CC_WebView *(^)(BOOL))cc_allowsBackForwardNavigationGestures;

@end

@interface CC_WebView (CCActions)

@end

NS_ASSUME_NONNULL_END
