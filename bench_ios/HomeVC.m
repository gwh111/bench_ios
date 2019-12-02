//
//  HomeVC.m
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "HomeVC.h"
#import "ccs.h"

@interface HomeVC ()

@property (nonatomic, retain) NSArray *testList;
@property (nonatomic, retain) NSMutableArray *testNameList;

@end

@implementation HomeVC

- (void)cc_viewWillLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    self.cc_title = @"首页";
    _testList = [ccs bundlePlistWithPath:@"testList"][@"list"];
    _testNameList = ccs.mutArray;
    for (int i = 0; i < _testList.count; i++) {
        [_testNameList cc_addObject:_testList[i][@"title"]];
    }
    
}

- (void)cc_viewDidLoad {
    
//    self.cc_navigationBarHidden = YES;
    CC_TableView *tableView = ccs.TableView
    .cc_addToView(self)
//    .cc_frame(0, STATUS_AND_NAV_BAR_HEIGHT, ccs.width, ccs.safeHeight - TABBAR_BAR_HEIGHT)
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_backgroundColor(UIColor.whiteColor);
    [tableView cc_addTextList:_testNameList withTappedBlock:^(NSUInteger index) {
        
        NSDictionary *dic = self.testList[index];
        NSString *name = dic[@"className"];
        Class cls = NSClassFromString(name);
        if (!cls) {
            CCLOG(@"找不到class");
            return;
        }
        if ([cls isSubclassOfClass:[UIViewController class]]) {
            [ccs pushViewController:[ccs init:cls]];
        } else {
            [cc_message cc_class:cls method:@selector(start)];
        }
    }];
    
    ccs.ui.dateLabel
    .cc_text(@"2019/09/10 10:13:41")
    .cc_top(RH(10))
    .cc_addToView(self);
    
    ccs.ui.grayLine
    .cc_top(RH(30))
    .cc_addToView(self);
}

@end
