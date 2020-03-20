//
//  CC_TableView.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_TableView.h"
#import "CC_CoreUI.h"

@interface CC_TableView () <UITableViewDelegate, UITableViewDataSource>

@property (strong) void (^tappedBlock)(NSUInteger index);
@property (nonatomic, retain) NSArray *list;

@end

@implementation CC_TableView

- (__kindof CC_TableView * (^)(Class))cc_registerCellClass {
    return ^(Class _) { [self registerClass:_ forCellReuseIdentifier:NSStringFromClass(_)]; return self; };
}

- (__kindof CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate{
    return ^(id<UITableViewDelegate> _) { self.delegate = _; return self; };
}

- (__kindof CC_TableView *(^)(id<UITableViewDataSource>))cc_dataSource{
    return ^(id<UITableViewDataSource> _) { self.dataSource = _; return self; };
}

- (void)cc_addTextList:(NSArray *)list withTappedBlock:(void(^)(NSUInteger index))block {
    _list = list;
    _tappedBlock = block;
    self.backgroundColor = UIColor.clearColor;
    self.dataSource = self;
    self.delegate = self;
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RH(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.textColor = UIColor.blackColor;
    cell.textLabel.text = _list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    _tappedBlock(indexPath.row);
}

@end
