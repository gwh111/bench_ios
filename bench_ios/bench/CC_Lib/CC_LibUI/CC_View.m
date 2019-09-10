//
//  CC_View.m
//  testbenchios
//
//  Created by gwh on 2019/8/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_View.h"

@implementation CC_View

+ (id)initOn:(id)obj{
    id view = [[self alloc]init];
    if ([obj isKindOfClass:[UIView class]]) {
        [obj addSubview:view];
    }else if ([obj isKindOfClass:[UIViewController class]]){
        [obj cc_addSubview:view];
    }
    return view;
}

#pragma mark clase "UIView" property extention
// UIView property
- (CC_View *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_View *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_View *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_View *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_View *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_View *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_View *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_View *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_View *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_View *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_View *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_View *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_View *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_View *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_View *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_View *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_View *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_View *(^)(id))cc_addToView{
    return ^(id view){
        [view cc_addSubview:self];
        return self;
    };
}

#pragma mark function
- (CC_ViewController *)cc_viewController{
    for (UIView *next=[self superview]; next; next=next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (CC_ViewController *)nextResponder;
        }
    }
    return nil;
}

@end
