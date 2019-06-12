//
//  RequestRecordViewController.m
//  bench_ios
//
//  Created by admin on 2019/4/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_RequestRecordViewController.h"
#import "CC_RequestRecordDetailViewController.h"
#import "CC_RequestRecordTool.h"
#import "CC_RequestRecordCell.h"
#import "CC_Notice.h"

@interface RequestRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *clearBtn;
@end

@implementation RequestRecordViewController
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height
{
    UITableView *_tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.clearBtn];
    
    [self.view addSubview:self.tableView];
    
    NSString *plistPath = [[CCReqRecord getInstance]pathForPlist];
    
    //文件过大防卡顿
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        [self.tableView reloadData];
    });
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    }];
    
}

- (void)clearAction {
    
    //清楚plist文件
    __weak typeof(self) weakSelf = self;
    [[CCReqRecord getInstance] clearPlistWithcompletion:^(BOOL isSussecc, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (isSussecc) {
            [strongSelf.dataArray removeAllObjects];
            [strongSelf.tableView reloadData];
        }else{
            [CC_Notice show:@"clear error" atView:strongSelf.view];
        }
    }];
    
}

#pragma mark - setter/getter

-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        [_backBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}

-(UIButton *)clearBtn {
    
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 85, 40)];
        [_clearBtn setTitle:@"ClearAll" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
    
}

-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SelfWidth, SelfHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[RequestRecordCell class] forCellReuseIdentifier:NSStringFromClass([RequestRecordCell class])];
    }
    return _tableView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RequestRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestRecordCell class]) forIndexPath:indexPath];
    if (cell) {
        NSDictionary *dic = _dataArray[indexPath.row];
        NSURL *url = [NSURL URLWithString:dic[@"requestUrl"]];
        cell.domainLabel.text = url.host;
        cell.paramsLabel.text = [NSString stringWithFormat:@"%@",dic[@"resultDic"][@"_serviceStr"]?dic[@"resultDic"][@"_serviceStr"] : @"not find serviceStr"];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@",dic[@"resultDic"][@"_responseLocalDate"]?dic[@"resultDic"][@"_responseLocalDate"]:@"no time record"];
        __weak typeof(self)weakSelf = self;
        cell.block = ^{
            __strong typeof(self) strongSelf = weakSelf;
            RequestRecordDetailViewController *detailVC = [[RequestRecordDetailViewController alloc]init];
            NSDictionary *subDic = self.dataArray[indexPath.row];
            detailVC.resultDic = subDic[@"resultDic"];
            [strongSelf.navigationController pushViewController:detailVC animated:YES];
        };
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    RequestRecordDetailViewController *detailVC = [[RequestRecordDetailViewController alloc]init];
//    NSDictionary *subDic = self.dataArray[indexPath.row];
//    detailVC.resultDic = subDic[@"resultDic"];
//    [self.navigationController pushViewController:detailVC animated:YES];
//
//}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //删除操作
        __weak typeof(self) weakSelf = self;
        [[CCReqRecord getInstance]clearPlistAtIndex:indexPath.row Withcompletion:^(BOOL isSussecc, NSError *error) {
            __strong typeof(self) strongSelf = weakSelf;
            if (isSussecc) {
                [strongSelf.dataArray removeObjectAtIndex:indexPath.row];
                [strongSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [CC_Notice show:@"delete error" atView:strongSelf.view];
            }
        }];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}

@end
