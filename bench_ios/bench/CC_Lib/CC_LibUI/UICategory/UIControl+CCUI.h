//
//  UIControl+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (CCUI)

/// default is YES. if NO, ignores touch events and subclasses may draw differently
- (UIControl *(^)(BOOL))cc_enabled;

/// default is NO may be used by some subclasses or by application
- (UIControl *(^)(BOOL))cc_selected;

/// default is NO. this gets set/cleared automatically when touch enters/exits during tracking and cleared on up
- (UIControl *(^)(BOOL))cc_highlighted;

@end

NS_ASSUME_NONNULL_END
