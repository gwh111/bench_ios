//
//  UISwitch+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/18.
//

#import "UISwitch+CCUI.h"

@implementation UISwitch (CCUI)

- (UISwitch *(^)(UIColor *))cc_onTintColor {
    return ^(UIColor *_) { self.onTintColor = _; return self; };
}

- (UISwitch *(^)(UIColor *))cc_tintColor {
    return ^(UIColor *_) { self.tintColor = _; return self; };
}

- (UISwitch *(^)(UIColor *))cc_thumbTintColor {
    return ^(UIColor *_) { self.thumbTintColor = _; return self; };
}

- (UISwitch *(^)(UIImage *))cc_onImage {
    return ^(UIImage *_) { self.onImage = _; return self; };
}

- (UISwitch *(^)(UIImage *))cc_offImage {
    return ^(UIImage *_) { self.offImage = _; return self; };
}

- (UISwitch *(^)(BOOL))cc_on {
    return ^(BOOL _) { self.on = _; return self; };
}

@end
