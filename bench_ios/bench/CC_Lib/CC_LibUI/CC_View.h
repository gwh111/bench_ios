//
//  CC_View.h
//  testbenchios
//
//  Created by gwh on 2019/8/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "UIView+CCUI.h"

#import "CCUIScaffold.h"

// #import "CC_Lib+UIView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_View : UIView <CC_View>

/// 是否可拖拽 默认不可拖拽
- (__kindof CC_View *(^)(BOOL dragable))cc_dragable;

- (void)cc_updateBadge:(NSString *)badge;
- (void)cc_updateBadgeBackgroundColor:(UIColor *)backgroundColor;
- (void)cc_updateBadgeTextColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
