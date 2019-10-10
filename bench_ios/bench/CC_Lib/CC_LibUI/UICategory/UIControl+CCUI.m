//
//  UIControl+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import "UIControl+CCUI.h"

@implementation UIControl (CCUI)

- (__kindof UIControl *(^)(BOOL))cc_enabled {
    return ^(BOOL enabled) {
        self.enabled = enabled;
        return self;
    };
}

- (__kindof UIControl *(^)(BOOL))cc_selected {
    return ^(BOOL selected) {
        self.selected = selected;
        return self;
    };
}

- (__kindof UIControl *(^)(BOOL))cc_highlighted {
    return ^(BOOL highlighted) {
        self.highlighted = highlighted;
        return self;
    };
}

@end
