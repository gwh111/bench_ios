//
//  CC_Label.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Label.h"

@interface CC_Label (){
    BOOL _hasBind;
}
@end

@implementation CC_Label

// UILabel property
- (__kindof CC_Label *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof CC_Label *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof CC_Label *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof CC_Label *(^)(UIColor *))cc_shadowColor{
    return ^(UIColor *shadowColor){
        self.shadowColor = shadowColor;
        return self;
    };
}

- (__kindof CC_Label *(^)(CGFloat, CGFloat))cc_shadowOffset{
    return ^(CGFloat w, CGFloat h){
        self.shadowOffset = CGSizeMake(w, h);
        return self;
    };
}

- (__kindof CC_Label *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (__kindof CC_Label *(^)(NSLineBreakMode))cc_lineBreakMode{
    return ^(NSLineBreakMode lineBreakMode){
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (__kindof CC_Label *(^)(NSAttributedString *))cc_attributedText{
    return ^(NSAttributedString *attributedText){
        self.attributedText = attributedText;
        return self;
    };
}

- (__kindof CC_Label *(^)(NSInteger))cc_numberOfLines{
    return ^(NSInteger numberOfLines){
        self.numberOfLines = numberOfLines;
        return self;
    };
}


// MARK: - Internal -
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

@implementation CC_Label (CCActions)

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

@implementation CC_Label (Deprecated)

//+ (CC_Label *)initOn:(id)obj{
//    CC_Label *label = [[CC_Label alloc]init];
//    if ([obj isKindOfClass:[UIView class]]) {
//        [obj addSubview:label];
//    }else if ([obj isKindOfClass:[UIViewController class]]){
//        [obj addSubview:label];
//    }
//    return label;
//}
//
//- (CC_Label *(^)(NSString *))cc_bindText{
//    return ^(NSString *text){
//        [self bindText:text];
//        return self;
//    };
//}
//
//- (CC_Label *(^)(NSAttributedString *))cc_bindAttText{
//    return ^(NSAttributedString *attText){
//        [self bindAttText:attText];
//        return self;
//    };
//}
//
//// UIView property
//- (CC_Label *(^)(NSString *))cc_name{
//    return (id)self.cc_name_id;
//}
//
//- (CC_Label *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
//    return (id)self.cc_frame_id;
//}
//
//- (CC_Label *(^)(CGFloat,CGFloat))cc_size{
//    return (id)self.cc_size_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_width {
//    return (id)self.cc_width_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_height {
//    return (id)self.cc_height_id;
//}
//
//- (CC_Label *(^)(CGFloat,CGFloat))cc_center{
//    return (id)self.cc_center_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_centerX{
//    return (id)self.cc_centerX_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_centerY{
//    return (id)self.cc_centerY_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_top{
//    return (id)self.cc_top_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_bottom{
//    return (id)self.cc_bottom_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_left{
//    return (id)self.cc_left_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_right{
//    return (id)self.cc_right_id;
//}
//
//- (CC_Label *(^)(UIColor *))cc_backgroundColor{
//    return (id)self.cc_backgroundColor_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_cornerRadius{
//    return (id)self.cc_cornerRadius_id;
//}
//
//- (CC_Label *(^)(CGFloat))cc_borderWidth{
//    return (id)self.cc_borderWidth_id;
//}
//
//- (CC_Label *(^)(UIColor *))cc_borderColor{
//    return (id)self.cc_borderColor_id;
//}
//
//- (CC_Label *(^)(BOOL))cc_userInteractionEnabled{
//    return (id)self.cc_userInteractionEnabled_id;
//}
//
//- (CC_Label *(^)(id))cc_addToView{
//    return (id)self.cc_addToView_id;
//}

@end

