//
//  CC_TableView.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Lib+UIView.h"
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_TableView : UITableView

#pragma mark clase "CC_TableView" property extention
// UIView property
- (CC_TableView *(^)(NSString *))cc_name;
- (CC_TableView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame;
- (CC_TableView *(^)(CGFloat,CGFloat))cc_size;
- (CC_TableView *(^)(CGFloat))cc_width;
- (CC_TableView *(^)(CGFloat))cc_height;

- (CC_TableView *(^)(CGFloat,CGFloat))cc_center;
- (CC_TableView *(^)(CGFloat))cc_centerX;
- (CC_TableView *(^)(CGFloat))cc_centerY;
- (CC_TableView *(^)(CGFloat))cc_top;
- (CC_TableView *(^)(CGFloat))cc_bottom;
- (CC_TableView *(^)(CGFloat))cc_left;
- (CC_TableView *(^)(CGFloat))cc_right;
- (CC_TableView *(^)(UIColor *))cc_backgroundColor;
- (CC_TableView *(^)(CGFloat))cc_cornerRadius;
- (CC_TableView *(^)(CGFloat))cc_borderWidth;
- (CC_TableView *(^)(UIColor *))cc_borderColor;
- (CC_TableView *(^)(BOOL))cc_userInteractionEnabled;
- (CC_TableView *(^)(id))cc_addToView;

// UITableView property
- (CC_TableView *(^)(CGPoint))cc_contentOffset;
- (CC_TableView *(^)(CGSize))cc_contentSize;
- (CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate;
- (CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource;

@end

NS_ASSUME_NONNULL_END
