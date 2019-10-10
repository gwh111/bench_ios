//
//  UISwitch+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/18.
//

#import "UISwitch+CCUI.h"

@implementation UISwitch (CCUI)

- (__kindof UISwitch *(^)(UIColor *))cc_onTintColor {
    return ^(UIColor *tintColor) {
        self.onTintColor = tintColor;
        return self;
    };
}

- (__kindof UISwitch *(^)(UIColor *))cc_tintColor {
    return ^(UIColor *tintColor) {
        self.tintColor = tintColor;
        return self;
    };
}

- (__kindof UISwitch *(^)(UIColor *))cc_thumbTintColor {
    return ^(UIColor *thmbTintColor) {
        self.thumbTintColor = thmbTintColor;
        return self;
    };
}

- (__kindof UISwitch *(^)(UIImage *))cc_onImage {
    return ^(UIImage *image) {
        self.onImage = image;
        return self;
    };
}

- (__kindof UISwitch *(^)(UIImage *))cc_offImage {
    return ^(UIImage *image) {
        self.offImage = image;
        return self;
    };
}

- (__kindof UISwitch *(^)(BOOL))cc_on {
    return ^(BOOL on) {
        self.on = on;
        return self;
    };
}

@end
