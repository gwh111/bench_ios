//
//  CC_ServerURLController.m
//  ServerChange
//
//  Created by ml on 2019/5/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_ServerURLController.h"
#import "UIResponder+CCCat.h"
#import "UIScrollView+CCCat.h"
#import "CC_UIHelper.h"
#import "CC_UIViewExt.h"
#import <objc/message.h>

@interface CC_ServerURLController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) NSUInteger selectIndex;

@end

@implementation CC_ServerURLController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"🔧  网络环境设置  🔧";
    CGFloat y = [ccui getSY] + 44;
    _tableView = ({
        UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(0, y, CC_SCREEN_WIDTH , CC_SCREEN_HEIGHT - y) style:UITableViewStyleGrouped];
        t.dataSource = self;
        t.delegate = self;
        t;
    });
    
    [_tableView cc_kdAdapterWithOffset:CGPointMake(0, 20)];
    
    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        item;
    });
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
    UIBarButtonItem *resetItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(resetAction:)];
    
    self.navigationItem.rightBarButtonItems = ({
        @[doneItem,resetItem];
    });
    
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)dealloc {
    [_tableView cc_removeKdAdapter];
}

#pragma mark - UITableView -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.info.count;
    }else if (section == 1) {
        return [[[self.info objectAtIndex:self.selectIndex] objectForKey:@"items"] count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (self.selectIndex == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            NSString *mode = [self.info[indexPath.row] objectForKey:@"mode"];
            cell.textLabel.text = mode;
        }
            break;
        case 1: {
            NSDictionary *item = [self.info[self.selectIndex] objectForKey:@"items"][indexPath.row];
            UITextField *td = [[UITextField alloc] initWithFrame:CGRectMake(15, 9, CC_SCREEN_WIDTH - 60, 30)];
            td.tag = 1;
            td.clearButtonMode = UITextFieldViewModeWhileEditing;
            td.borderStyle = UITextBorderStyleRoundedRect;
            td.keyboardType = UIKeyboardTypeURL;
            
//            if ([[item objectForKey:@"enable"] boolValue] == NO) {
//                td.enabled = NO;
//            }
            
            if (td.top == 9) {
                td.centerY = cell.contentView.centerY;
            }
            
            td.text = [item objectForKey:@"url"];
            [cell.contentView addSubview:td];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
            break;
        case 2: {
            UITextField *td = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CC_SCREEN_WIDTH - 60, 30)];
            td.borderStyle = UITextBorderStyleRoundedRect;
            td.clearButtonMode = UITextFieldViewModeWhileEditing;
            td.keyboardType = UIKeyboardTypeURL;
            td.centerY = cell.contentView.centerY;
            [cell.contentView addSubview:td];
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
#pragma warning
//        if (indexPath.row == 2) {
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectIndex = indexPath.row;
        NSInteger rowCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        for (int i = 0; i < rowCount; i++) {
            if (i != indexPath.row) {
                NSIndexPath *otherIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                UITableViewCell *other_cell = [tableView cellForRowAtIndexPath:otherIndexPath];
                other_cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UITextField *td = [cell.contentView subviews].lastObject;
        if ([td isKindOfClass:[UITextField class]] && td.text.length > 0) {
            NSString *urlString = td.text;
            if(![urlString hasPrefix:@"http"]) {
                urlString = [@"http://" stringByAppendingString:td.text];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        /**
         if (![url hasPrefix:@"http"]) {
         url = [@"http://" stringByAppendingString:url];
         
         HHBaseWebDelegate *delegate = [[HHBaseWebDelegate alloc]init];
         HHBaseWebViewController *webVC = [[HHBaseWebViewController alloc]initWithUrl:url Delegate:delegate];
         [self.navigationController pushViewController:webVC animated:YES];
         
         }
         */
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"服务器地址";
    }else if (section == 1) {
        return @"日志";
    }else {
        return @"其它";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 2) {
        return 60;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || indexPath.section == 2) {
        if (indexPath.section == 2) {
            self.navigationItem.titleView = ({
                UILabel *l = [UILabel new];
                l.text = [NSString stringWithFormat:@"%@",@"打开指定URL"];
                l.textAlignment = NSTextAlignmentCenter;
                l.numberOfLines = 2;
                [l sizeToFit];
                l;
            });
            return;
        }
        
        NSDictionary *item = [self.info[self.selectIndex] objectForKey:@"items"][indexPath.row];
        self.navigationItem.titleView = ({
            UILabel *l = [UILabel new];
            l.text = [item objectForKey:@"name"];
            l.textAlignment = NSTextAlignmentCenter;
            l.numberOfLines = 2;
            [l sizeToFit];
            l;
        });
    }
}

#pragma mark - UIScrollView -
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView endEditing:YES];
}

#pragma mark - Actions -
- (void)backAction:(UIBarButtonItem *)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)doneAction:(UIBarButtonItem *)sender {
    // NSArray *items = [[self.info objectAtIndex:self.selectIndex] objectForKey:@"items"];
    NSInteger section = 1;
    NSMutableArray *itemsM = [NSMutableArray array];
    for (int i = 0; i < [_tableView numberOfRowsInSection:section]; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
        UITextField *td = [cell viewWithTag:1];
        if(td) {
//            NSString *name = [items[i] objectForKey:@"name"];
            NSString *url = td.text;
            [itemsM addObject:@{
//                                @"name":name,
                                @"url":url ? : @""
                                }];
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CCServerURLDoneNotification object:itemsM.copy];
    [self backAction:nil];
}

- (void)resetAction:(UIBarButtonItem *)sender {
    [_tableView reloadData];
}

#pragma mark -
- (UILabel *)textLabelWithText:(NSString *)text {
    return ({
        UILabel *l = [UILabel new];
        l.text = text;
        l.font = [ccui getRFS:14];
        [l sizeToFit];
        l.left = 15;
        l.top = 5;
        l;
    });
}

- (UILabel *)detailLabelWithText:(NSString *)text leftWithView:(UIView *)leftView {
    return ({
        UILabel *l = [UILabel new];
        l.text = text;
        l.font = [ccui getRFS:14];
        [l sizeToFit];
        l.left = CGRectGetMaxX(leftView.frame) + 5;
        l.top = 5;
        l;
    });
}

@end

NSNotificationName const CCServerURLDoneNotification = @"CCServerURLDoneNotification";
