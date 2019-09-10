//
//  UIControl+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (CCUI)

- (UIControl *(^)(BOOL))cc_enabled;
- (UIControl *(^)(BOOL))cc_selected;
- (UIControl *(^)(BOOL))cc_highlighted;
- (UIControl *(^)(UIControlState))cc_state;
- (UIControl *(^)(BOOL))cc_tracking;
- (UIControl *(^)(BOOL))cc_touchInside;

@end

NS_ASSUME_NONNULL_END
