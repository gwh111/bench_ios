//
//  CC_WebView.m
//  bench_ios
//
//  Created by gwh on 2019/8/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_WebView.h"

@implementation CC_WebView

// CC_WebView property
- (__kindof CC_WebView *(^)(id<WKNavigationDelegate>))cc_navigationDelegate{
    return ^(id<WKNavigationDelegate> navigationDelegate){
        self.navigationDelegate = navigationDelegate;
        return self;
    };
}

- (__kindof CC_WebView *(^)(id<WKUIDelegate>))cc_UIDelegate{
    return ^(id<WKUIDelegate> UIDelegate){
        self.UIDelegate = UIDelegate;
        return self;
    };
}

- (__kindof CC_WebView *(^)(BOOL))cc_allowsBackForwardNavigationGestures{
    return ^(BOOL allowsBackForwardNavigationGestures){
        self.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures;
        return self;
    };
}

@end

@implementation CC_WebView (CCActions)

@end
