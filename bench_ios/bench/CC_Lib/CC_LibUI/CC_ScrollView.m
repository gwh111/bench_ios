//
//  CC_ScrollView.m
//  testbenchios
//
//  Created by gwh on 2019/8/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_ScrollView.h"

@implementation CC_ScrollView

#pragma mark clase "CC_ScrollView" property extention
// UIView property
- (CC_ScrollView *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_ScrollView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_ScrollView *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_ScrollView *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_ScrollView *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_ScrollView *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_ScrollView *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_ScrollView *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_ScrollView *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

// UIScrollView property
- (CC_ScrollView *(^)(CGPoint))cc_contentOffset{
    return ^(CGPoint contentOffset){
        self.contentOffset = contentOffset;
        return self;
    };
}

- (CC_ScrollView *(^)(CGSize))cc_contentSize{
    return ^(CGSize contentSize){
        self.contentSize = contentSize;
        return self;
    };
}

- (CC_ScrollView *(^)(id<UIScrollViewDelegate>))cc_delegate{
    return ^(id<UIScrollViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

@end
