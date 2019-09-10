//
//  CC_TableView.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_TableView.h"

@implementation CC_TableView

#pragma mark clase "CC_TableView" property extention
// UIView property
- (CC_TableView *(^)(NSString *))cc_name{
    return (id)self.cc_name_id;
}

- (CC_TableView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame{
    return (id)self.cc_frame_id;
}

- (CC_TableView *(^)(CGFloat,CGFloat))cc_size{
    return (id)self.cc_size_id;
}

- (CC_TableView *(^)(CGFloat))cc_width {
    return (id)self.cc_width_id;
}

- (CC_TableView *(^)(CGFloat))cc_height {
    return (id)self.cc_height_id;
}

- (CC_TableView *(^)(CGFloat,CGFloat))cc_center{
    return (id)self.cc_center_id;
}

- (CC_TableView *(^)(CGFloat))cc_centerX{
    return (id)self.cc_centerX_id;
}

- (CC_TableView *(^)(CGFloat))cc_centerY{
    return (id)self.cc_centerY_id;
}

- (CC_TableView *(^)(CGFloat))cc_top{
    return (id)self.cc_top_id;
}

- (CC_TableView *(^)(CGFloat))cc_bottom{
    return (id)self.cc_bottom_id;
}

- (CC_TableView *(^)(CGFloat))cc_left{
    return (id)self.cc_left_id;
}

- (CC_TableView *(^)(CGFloat))cc_right{
    return (id)self.cc_right_id;
}

- (CC_TableView *(^)(UIColor *))cc_backgroundColor{
    return (id)self.cc_backgroundColor_id;
}

- (CC_TableView *(^)(CGFloat))cc_cornerRadius{
    return (id)self.cc_cornerRadius_id;
}

- (CC_TableView *(^)(CGFloat))cc_borderWidth{
    return (id)self.cc_borderWidth_id;
}

- (CC_TableView *(^)(UIColor *))cc_borderColor{
    return (id)self.cc_borderColor_id;
}

- (CC_TableView *(^)(BOOL))cc_userInteractionEnabled{
    return (id)self.cc_userInteractionEnabled_id;
}

- (CC_TableView *(^)(id))cc_addToView{
    return (id)self.cc_addToView_id;
}

// UITableView property
- (CC_TableView *(^)(CGPoint))cc_contentOffset{
    return ^(CGPoint contentOffset){
        self.contentOffset = contentOffset;
        return self;
    };
}

- (CC_TableView *(^)(CGSize))cc_contentSize{
    return ^(CGSize contentSize){
        self.contentSize = contentSize;
        return self;
    };
}

- (CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate{
    return ^(id<UITableViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource{
    return ^(id<UITableViewDataSource> delegate){
        self.dataSource = delegate;
        return self;
    };
}

@end
