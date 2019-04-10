//
//  YCListViewController.m
//  testPod
//
//  Created by admin on 2019/4/3.
//  Copyright © 2019 yc. All rights reserved.
//

#import "CC_YCListViewController.h"

@interface YCListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
//@property (nonatomic ,strong) YCFPSButton *fpsButton;

@end

@implementation YCListViewController
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height
{
    NSMutableDictionary *_indexContainDic;//储存indexPath需要持久化状态的控件
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.view.alpha = 0.7;
    _indexContainDic = [NSMutableDictionary dictionary];
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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        NSDictionary *dic = self.dataArray[indexPath.row];
        cell.textLabel.text = dic[@"title"];

    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *type = dic[@"type"];
    if ([type isEqualToString:@"vc"]) {
        //控制器类型
        NSString *name = dic[@"className"];
        Class cls = NSClassFromString(name);
        UIViewController *vc = [[cls alloc]init];
        UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:nv animated:YES completion:nil];
        });
    }else if ([type isEqualToString:@"bt"]){
        //按钮类型
        if (![_indexContainDic valueForKey:@(indexPath.row).stringValue]) {
            //需要持久化控件还没有创建
            NSString *name = dic[@"className"];
            Class cls = NSClassFromString(name);
            UIButton *btn = [[cls alloc] init];
            //保存
            [_indexContainDic setObject:btn forKey:@(indexPath.row).stringValue];
            //展示
            btn.hidden = NO;
            [[UIApplication sharedApplication].delegate.window addSubview:btn];
        }else{
            UIButton *button = [_indexContainDic objectForKey:@(indexPath.row).stringValue];
            button.hidden = !button.hidden;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    }else{
        //未定义类型
        [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[NSNotificationCenter defaultCenter]postNotificationName:@"yc_HideListWindowNow" object:nil];
    
}

#pragma mark - setter/getter

-(NSMutableArray *)dataArray {
    
    if (!_dataArray) {
//        _dataArray = @[@"requestRecord",@"fps-monitor",@"功能待添加"].mutableCopy;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"debug_function" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:path].mutableCopy;
    }
    return _dataArray;
    
}

//-(YCFPSButton *)fpsButton {
//
//    if (!_fpsButton) {
//        _fpsButton = [[YCFPSButton alloc]initWithFrame:CGRectMake(0, 100, 80, 30)];
//    }
//    return _fpsButton;
//
//}



@end
