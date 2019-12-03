//
//  UIControl+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import "UIControl+CCUI.h"

@implementation UIControl (CCUI)

- (UIControl *(^)(BOOL))cc_enabled {
    return ^(BOOL _) { self.enabled = _; return self; };
}

- (UIControl *(^)(BOOL))cc_selected {
    return ^(BOOL _) { self.selected = _; return self; };
}

- (UIControl *(^)(BOOL))cc_highlighted {
    return ^(BOOL _) { self.highlighted = _; return self; };
}

@end
