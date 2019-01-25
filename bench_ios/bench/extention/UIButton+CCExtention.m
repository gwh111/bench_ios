//
//  UIButton+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIButton+CCExtention.h"
#import <objc/runtime.h>

@interface UIButton()


@end

@implementation UIButton(CCExtention)

static const NSString *key_cs_backgroundColor = @"key_cs_backgroundColor";
static NSString *cs_stringForUIControlStateNormal = @"cs_stringForUIControlStateNormal";
static NSString *cs_stringForUIControlStateHighlighted = @"cs_stringForUIControlStateHighlighted";
static NSString *cs_stringForUIControlStateDisabled = @"cs_stringForUIControlStateDisabled";
static NSString *cs_stringForUIControlStateSelected = @"cs_stringForUIControlStateSelected";

#pragma mark - cs_dictBackgroundColor
- (NSMutableDictionary *)cs_dictBackgroundColor {
    return objc_getAssociatedObject(self, &key_cs_backgroundColor);
}
- (void)setCs_dictBackgroundColor:(NSMutableDictionary *)cs_dictBackgroundColor {
    objc_setAssociatedObject(self, &key_cs_backgroundColor, cs_dictBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (!self.cs_dictBackgroundColor) {
        self.cs_dictBackgroundColor = [[NSMutableDictionary alloc] init];
    }
    [self.cs_dictBackgroundColor setObject:backgroundColor forKey:[self cs_stringForUIControlState:state]];
}
- (NSString *)cs_stringForUIControlState:(UIControlState)state {
    NSString *cs_string;
    switch (state) {
        case UIControlStateNormal: cs_string = cs_stringForUIControlStateNormal; break;
        case UIControlStateHighlighted: cs_string = cs_stringForUIControlStateHighlighted; break;
        case UIControlStateDisabled: cs_string = cs_stringForUIControlStateDisabled; break;
        case UIControlStateSelected: cs_string = cs_stringForUIControlStateSelected; break;
        default: cs_string = cs_stringForUIControlStateNormal; break;
    }
    return cs_string;
}

#pragma mark - ccselected
- (void)setccSelected:(BOOL)selected{
    if (selected) {
        self.backgroundColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateSelected];
    } else {
        self.backgroundColor = (UIColor *)[self.cs_dictBackgroundColor objectForKey:cs_stringForUIControlStateNormal];
    }
}

#pragma mark - 防重复
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)cs_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setCs_acceptEventInterval:(NSTimeInterval)cs_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.cs_acceptEventInterval==0) {
        self.cs_acceptEventInterval=1;
    }
    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_acceptEventInterval) {
        return;
    }
    
    if (self.cs_acceptEventInterval > 0) {
        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self cs_sendAction:action to:target forEvent:event];
}

@end
