//
//  CC_TextView.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextView.h"

@interface CC_TextView (){
    BOOL _hasBind;
}
@end

@implementation CC_TextView

- (__kindof CC_TextView *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof CC_TextView *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof CC_TextView *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof CC_TextView *(^)(NSRange))cc_selectedRange{
    return ^(NSRange selectedRange){
        self.selectedRange = selectedRange;
        return self;
    };
}

- (__kindof CC_TextView *(^)(BOOL))cc_editable{
    return ^(BOOL editable){
        self.editable = editable;
        return self;
    };
}

- (__kindof CC_TextView *(^)(BOOL))cc_selectable{
    return ^(BOOL selectable){
        self.selectable = selectable;
        return self;
    };
}

- (__kindof CC_TextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes{
    return ^(UIDataDetectorTypes dataDetectorTypes){
        self.dataDetectorTypes = dataDetectorTypes;
        return self;
    };
}

- (__kindof CC_TextView *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}


#pragma mark private function
- (void)dealloc{
    if (_hasBind==NO) {
        return;
    }
    // unbind text address from object address
    NSString *objAddress=[NSString stringWithFormat:@"%p",self];
    NSString *bindAddress=[CC_Base.shared cc_shared:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:nil];
    [CC_Base.shared cc_setBind:bindAddress value:nil];
}

@end

@implementation CC_TextView (CCActions)

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
    _hasBind=YES;
    // bind attText address to object address
    NSString *textAddress=[NSString stringWithFormat:@"%p",attText];
    NSString *objAddress=[NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.attributedText=attText;
}

@end


@implementation CC_TextView (Deprecated)

- (CC_TextView *(^)(id<UITextViewDelegate>))cc_delegate{
    return ^(id<UITextViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (CC_TextView *(^)(NSString *))cc_bindText{
    return ^(NSString *text){
        [self bindText:text];
        return self;
    };
}

- (CC_TextView *(^)(NSAttributedString *))cc_bindAttText{
    return ^(NSAttributedString *attText){
        [self bindAttText:attText];
        return self;
    };
}

// UIView property
- (CC_TextView *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_TextView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_TextView *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_TextView *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_TextView *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_TextView *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_TextView *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_TextView *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_TextView *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_TextView *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_TextView *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_TextView *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_TextView *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_TextView *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_TextView *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_TextView *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_TextView *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_TextView *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

@end
