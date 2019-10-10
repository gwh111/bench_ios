//
//  CC_TableView.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_TableView.h"

@implementation CC_TableView

- (__kindof CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate{
    return ^(id<UITableViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
}

- (__kindof CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource{
    return ^(id<UITableViewDataSource> delegate){
        self.dataSource = delegate;
        return self;
    };
}

@end
