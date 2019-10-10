//
//  HomeVC.m
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "HomeVC.h"
#import "ccs.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *testList;
}

@end

@implementation HomeVC

- (void)cc_viewWillLoad{
    self.cc_title = @"首页";
    testList = [ccs bundlePlistWithPath:@"testList"][@"list"];
}

- (void)cc_viewDidLoad {
    self.view.backgroundColor = UIColor.whiteColor;
    
//    self.cc_navigationBarHidden = YES;
    ccs.TableView
    .cc_addToView(self)
//    .cc_frame(0, STATUS_AND_NAV_BAR_HEIGHT, ccs.width, ccs.safeHeight - TABBAR_BAR_HEIGHT)
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor);
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [testList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.textLabel.text = [testList objectAtIndex:indexPath.section][@"title"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSDictionary *dic = testList[indexPath.section];
    NSString *name = dic[@"className"];
    Class cls = NSClassFromString(name);
    if (!cls) {
        CCLOG(@"找不到class");
        return;
    }
    if ([cls isSubclassOfClass:[UIViewController class]]) {
        [ccs pushViewController:[ccs anObject:cls]];
    }else{
        [cc_message cc_class:cls method:@selector(start)];
    }
    
}

@end
