//
//  CC_TableView.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUIScaffold.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_TableView : UITableView <CC_TableView>

- (__kindof CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate;
- (__kindof CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource;

@end

NS_ASSUME_NONNULL_END
