//
//  CC_ImageView.m
//  bench_ios
//
//  Created by gwh on 2018/10/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CC_ImageView.h"

@implementation CC_ImageView

#pragma mark clase "CC_ImageView" property extention
// UIView property
- (CC_ImageView *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_ImageView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_ImageView *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_ImageView *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_ImageView *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_ImageView *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_ImageView *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_ImageView *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_ImageView *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_ImageView *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_ImageView *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_ImageView *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_ImageView *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_ImageView *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_ImageView *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_ImageView *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_ImageView *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_ImageView *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

// UIImageView property
- (CC_ImageView *(^)(UIImage *))cc_image{
    return ^(UIImage *image){
        self.image = image;
        return self;
    };
}

- (CC_ImageView *(^)(NSArray<UIImage *> *))cc_animationImages{
    return ^(NSArray<UIImage *> *animationImages){
        self.animationImages = animationImages;
        return self;
    };
}

- (CC_ImageView *(^)(NSTimeInterval))cc_animationDuration{
    return ^(NSTimeInterval animationDuration){
        self.animationDuration = animationDuration;
        return self;
    };
}

- (CC_ImageView *(^)(NSInteger))cc_animationRepeatCount{
    return ^(NSInteger animationRepeatCount){
        self.animationRepeatCount = animationRepeatCount;
        return self;
    };
}

@end
