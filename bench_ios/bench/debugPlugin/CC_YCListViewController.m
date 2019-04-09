//
//  YCListViewController.m
//  testPod
//
//  Created by admin on 2019/4/3.
//  Copyright © 2019 yc. All rights reserved.
//

#import "CC_YCListViewController.h"
#import "CC_RequestRecordViewController.h"
#import "CC_YCFPSButton.h"

@interface YCListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) YCFPSButton *fpsButton;

@end

@implementation YCListViewController
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.view.alpha = 0.7;
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 260, SelfWidth - 160, SelfHeight - 520) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.alpha = 0.8;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    if (cell) {
        cell.backgroundColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RequestRecordViewController *vc = [RequestRecordViewController new];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:nav animated:YES completion:nil];
        });
    }else if (indexPath.row == 1){
        if(_fpsButton&&_fpsButton.hidden){
            _fpsButton.hidden = NO;
        }else{
            _fpsButton.hidden = YES;
        }
        [[UIApplication sharedApplication].delegate.window addSubview:self.fpsButton];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    
}

#pragma mark - setter/getter

-(NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"requestRecord",@"fps-monitor",@"功能待添加"].mutableCopy;
    }
    return _dataArray;
    
}

-(YCFPSButton *)fpsButton {
    
    if (!_fpsButton) {
        _fpsButton = [[YCFPSButton alloc]initWithFrame:CGRectMake(0, 100, 80, 30)];
    }
    return _fpsButton;
    
}



@end
