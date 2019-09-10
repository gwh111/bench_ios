//
//  CC_WebView.m
//  bench_ios
//
//  Created by gwh on 2019/8/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_WebView.h"

@implementation CC_WebView

#pragma mark clase "CC_WebView" property extention
// UIView property
- (CC_WebView *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_WebView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_WebView *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_WebView *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_WebView *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_WebView *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_WebView *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_WebView *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_WebView *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_WebView *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_WebView *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_WebView *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_WebView *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_WebView *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_WebView *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_WebView *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_WebView *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_WebView *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

// CC_WebView property
- (CC_WebView *(^)(id<WKNavigationDelegate>))cc_navigationDelegate{
    return ^(id<WKNavigationDelegate> navigationDelegate){
        self.navigationDelegate = navigationDelegate;
        return self;
    };
}

- (CC_WebView *(^)(id<WKUIDelegate>))cc_UIDelegate{
    return ^(id<WKUIDelegate> UIDelegate){
        self.UIDelegate = UIDelegate;
        return self;
    };
}

- (CC_WebView *(^)(BOOL))cc_allowsBackForwardNavigationGestures{
    return ^(BOOL allowsBackForwardNavigationGestures){
        self.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures;
        return self;
    };
}

@end
