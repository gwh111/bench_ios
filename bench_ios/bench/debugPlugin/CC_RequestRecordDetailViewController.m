//
//  RequestRecordDetailViewController.m
//  bench_ios
//
//  Created by admin on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_RequestRecordDetailViewController.h"

@interface RequestRecordDetailViewController ()

@property (nonatomic, strong)UIButton *backBtn;

@end

@implementation RequestRecordDetailViewController

#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
}

- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(YCTextView *)urlTV {
    
    if (!_urlTV) {
        _urlTV = [[YCTextView alloc]initWithFrame:CGRectMake(10, 100, SelfWidth - 20, 100)];
        _urlTV.editable = NO;
        [self.view addSubview:_urlTV];
    }
    return _urlTV;
    
}

-(YCTextView *)resultTV {
    
    if (!_resultTV) {
        _resultTV = [[YCTextView alloc]initWithFrame:CGRectMake(10, 280, SelfWidth - 20, 350)];
        _resultTV.editable = NO;
        [self.view addSubview:_resultTV];
        
    }
    return _resultTV;
}

-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, 60, 40)];
        [_backBtn setTitle:@"back" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}

@end

@implementation YCTextView

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if ([UIMenuController sharedMenuController] ) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return YES;
    
}

@end
