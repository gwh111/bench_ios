//
//  CC_TableView.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CCUI.h"
#import "UIScrollView+CCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_TableView : UITableView <CC_TableViewViewChainProtocol,CC_TableViewViewChainExtProtocol, UITableViewDataSource, UITableViewDelegate>

- (__kindof CC_TableView *(^)(Class cls))cc_registerCellClass;
- (__kindof CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate;
- (__kindof CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource;

- (void)cc_addTextList:(NSArray *)list withTappedBlock:(void(^)(NSUInteger index))block;

@end

NS_ASSUME_NONNULL_END
