//
//  AppButton.m
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Button.h"

@interface CC_Button () {
    BOOL _hasBind;
}

@end

@implementation CC_Button
@synthesize forbiddenEnlargeTapFrame;

- (__kindof CC_Button *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}

- (__kindof CC_Button *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.titleLabel.textColor = textColor;
        return self;
    };
}

#pragma mark private function
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event{
    if (forbiddenEnlargeTapFrame) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect bounds = self.bounds;
    float v = [[CC_CoreUI shared]relativeHeight:44];
    if (self.width >= v && self.height >= v) {
        return [super pointInside:point withEvent:event];
    }else if (self.width >= v && self.height < v){
        bounds = CGRectInset(bounds, 0, -(v - self.height)/2.0);
    }else if (self.width < v && self.height >= v){
        bounds = CGRectInset(bounds,-(v - self.width)/2.0,0);
    }else if (self.width < v && self.height < v){
        bounds = CGRectInset(bounds,-(v-self.width)/2.0,-(v-self.height)/2.0);
    }
    return CGRectContainsPoint(bounds, point);
}

- (void)dealloc{
    if (_hasBind == NO) {
        return;
    }
    
    // unbind text address from object address
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    NSString *bindAddress = [CC_Base.shared cc_shared:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:nil];
    [CC_Base.shared cc_setBind:bindAddress value:nil];
}

@end

@implementation CC_Button (CCActions)

- (void)bindText:(NSString *)text state:(UIControlState)state{
    _hasBind = YES;
    // bind text address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",text];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    [self setTitle:text forState:state];
}

- (void)bindAttText:(NSAttributedString *)attText state:(UIControlState)state{
    _hasBind=YES;
    // bind attText address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",attText];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    [self setAttributedTitle:attText forState:state];
}

@end

@implementation CC_Button (Deprecated)

#pragma mark clase "CC_Button" property extention
// UIView property
- (CC_Button *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_Button *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_Button *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_Button *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_Button *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_Button *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_Button *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_Button *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_Button *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_Button *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_Button *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_Button *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_Button *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_Button *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_Button *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_Button *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_Button *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_Button *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

// UIButton property
- (CC_Button *(^)(NSString *, UIControlState))cc_setTitleForState{
    return ^(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (CC_Button *(^)(UIColor *, UIControlState))cc_setTitleColorForState{
    return ^(UIColor *titleColor, UIControlState state){
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

- (CC_Button *(^)(UIColor *, UIControlState))cc_setTitleShadowColorForState{
    return ^(UIColor *titleShadowColor, UIControlState state){
        [self setTitleShadowColor:titleShadowColor forState:state];
        return self;
    };
}

- (CC_Button *(^)(UIImage *, UIControlState))cc_setImageForState{
    return ^(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}

- (CC_Button *(^)(UIImage *, UIControlState))cc_setBackgroundImageForState{
    return ^(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (CC_Button *(^)(NSAttributedString *, UIControlState))cc_setAttributedTitleForState{
    return ^(NSAttributedString *att, UIControlState state){
        [self setAttributedTitle:att forState:state];
        return self;
    };
}

- (CC_Button *(^)(NSString *, UIControlState))cc_bindText{
    return ^(NSString *text, UIControlState state){
        [self bindText:text state:state];
        return self;
    };
}

- (CC_Button *(^)(NSAttributedString *, UIControlState))cc_bindAttText{
    return ^(NSAttributedString *attText, UIControlState state){
        [self bindAttText:attText state:state];
        return self;
    };
}

@end
