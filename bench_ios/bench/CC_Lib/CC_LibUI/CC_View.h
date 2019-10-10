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

NS_ASSUME_NONNULL_BEGIN

@interface CC_View : UIView <CC_View>

@property (nonatomic,readonly) CC_Label *badgeLabel;

/// 是否可拖拽 默认不可拖拽
- (__kindof CC_View *(^)(BOOL dragable))cc_dragable;

/// 角标
- (__kindof CC_View *(^)(NSString *))cc_badgeValue;
- (__kindof CC_View *(^)(UIColor  *))cc_badgeColor;
- (__kindof CC_View *(^)(UIColor  *))cc_badgeBgColor;

// @param badge msg number
//- (void)cc_updateBadge:(NSString *)badge;
//- (void)cc_updateBadgeBackgroundColor:(UIColor *)backgroundColor;
//- (void)cc_updateBadgeTextColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
