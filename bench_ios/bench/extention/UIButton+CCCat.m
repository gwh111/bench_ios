//
//  UIButton+CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIButton+CCCat.h"
#import <objc/runtime.h>

@interface UIButton()


@end

@implementation UIButton(CCCat)

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

@end
