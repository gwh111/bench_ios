//
//  CC_TextField.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextField.h"

@interface CC_TextField (){
    BOOL _hasBind;
}
@end

@implementation CC_TextField

- (__kindof CC_TextField *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (__kindof CC_TextField *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof CC_TextField *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof CC_TextField *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (__kindof CC_TextField *(^)(UITextBorderStyle))cc_borderStyle{
    return ^(UITextBorderStyle borderStyle){
        self.borderStyle = borderStyle;
        return self;
    };
}

- (__kindof CC_TextField *(^)(NSString *))cc_placeholder{
    return ^(NSString *placeholder){
        self.placeholder = placeholder;
        return self;
    };
}

- (__kindof CC_TextField *(^)(NSAttributedString *))cc_attributedPlaceholder{
    return ^(NSAttributedString *attributedPlaceholder){
        self.attributedPlaceholder = attributedPlaceholder;
        return self;
    };
}

- (__kindof CC_TextField *(^)(BOOL))cc_clearsOnBeginEditing{
    return ^(BOOL clearsOnBeginEditing){
        self.clearsOnBeginEditing = clearsOnBeginEditing;
        return self;
    };
}

- (__kindof CC_TextField *(^)(BOOL))cc_adjustsFontSizeToFitWidth{
    return ^(BOOL adjustsFontSizeToFitWidth){
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
        return self;
    };
}

- (__kindof CC_TextField *(^)(UIImage *))cc_background{
    return ^(UIImage *background){
        self.background = background;
        return self;
    };
}



#pragma mark private function
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

@implementation CC_TextField (CCActions)

- (void)bindText:(NSString *)text{
    _hasBind = YES;
    // bind text address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",text];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.text = text;
}

- (void)bindAttText:(NSAttributedString *)attText{
    _hasBind = YES;
    // bind attText address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",attText];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.attributedText = attText;
}

@end

@implementation CC_TextField (Deprecated)

- (CC_TextField *(^)(id<UITextFieldDelegate>))cc_delegate{
    return ^(id<UITextFieldDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (CC_TextField *(^)(NSString *))cc_bindText{
    return ^(NSString *text){
        [self bindText:text];
        return self;
    };
}

- (CC_TextField *(^)(NSAttributedString *))cc_bindAttText{
    return ^(NSAttributedString *attText){
        [self bindAttText:attText];
        return self;
    };
}

#pragma mark clase "CC_TextField" property extention
// UIView property
- (CC_TextField *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_TextField *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_TextField *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_TextField *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_TextField *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_TextField *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_TextField *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_TextField *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_TextField *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_TextField *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_TextField *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_TextField *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_TextField *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_TextField *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_TextField *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_TextField *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_TextField *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_TextField *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

@end
