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

@interface RequestRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *keysArray;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)UIButton *backBtn;

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
    
    [self.view addSubview:self.tableView];
    
    NSString *plistPath = [[CCReqRecord getInstance]pathForPlist];
    self.dic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    self.keysArray = _dic.allKeys;
    [self.tableView reloadData];
        
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

}

- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
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

-(NSArray *)keysArray
{
    
    if (!_keysArray) {
        _keysArray = [NSMutableArray array];
    }
    return _keysArray;
    
}

-(NSMutableDictionary *)dic {
    
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
    
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
    
    return _keysArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RequestRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RequestRecordCell class]) forIndexPath:indexPath];
    if (cell) {
        cell.domainLabel.text = _keysArray[indexPath.row];
        if (_keysArray[indexPath.row]) {
            NSDictionary *subDic = self.dic[_keysArray[indexPath.row]];
            NSString *params = subDic[@"parameters"];
            cell.paramsLabel.text = [NSString stringWithFormat:@"%@(%@)",params.length > 0?params:@"no params",subDic[@"requestUrl"]];
        }
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RequestRecordDetailViewController *detailVC = [[RequestRecordDetailViewController alloc]init];
    NSDictionary *subDic = self.dic[_keysArray[indexPath.row]];
    detailVC.resultDic = subDic;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
