//
//  UIButton+CCUI.m
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "UIButton+CCUI.h"

@implementation UIButton (CCUI)

- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setBackgroundColorForState {
    return ^(UIColor *backgroundColor,UIControlState state) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(NSString *text,UIControlState state))cc_setTitleForState {
    return ^(NSString *text,UIControlState state) {
        [self setTitle:text forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleColorForState {
    return ^(UIColor *color,UIControlState state) {
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(UIImage *image,UIControlState state))cc_setImageForState {
    return ^(UIImage *image,UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(UIImage *image,UIControlState state))cc_setBackgroundImageForState {
    return ^(UIImage *image,UIControlState state) {
        [self setBackgroundImage:image forState:state];
        return self;
    };
    
}

- (__kindof UIButton *(^)(NSAttributedString *attributed,UIControlState state))cc_setAttributedTitleForState {
    return ^(NSAttributedString *attributed,UIControlState state) {
        [self setAttributedTitle:attributed forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(UIColor *color,UIControlState state))cc_setTitleShadowColorForState {
    return ^(UIColor *color,UIControlState state) {
        [self setTitleShadowColor:color forState:state];
        return self;
    };
}

- (__kindof UIButton *(^)(UIFont  *))cc_font {
    return ^(UIFont *font) {
        self.titleLabel.font = font;
        return self;
    };
}

@end

@implementation UIButton (CCDeprecated)

- (void)cc_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    self.cc_setBackgroundColorForState(backgroundColor,state);
}

@end
