//
//  testServerURLVC.m
//  bench_ios
//
//  Created by ml on 2019/6/5.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "testServerURLVC.h"
#import "CC_ServerURLManager.h"
#import "UIScrollView+CCCat.h"

@interface testServerURLVC ()

@end

@implementation testServerURLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self dynamicURL];
    
    UIScrollView *scrollView = ({
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [s cc_kdAdapterWithOffset:CGPointMake(0, 20)];
        s;
    });
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:scrollView];
    for (int i = 0; i < 5; ++i) {
        UITextField *textField = ({
            CGRect rect = CGRectMake(100 + arc4random() % 99, 100 + (100 * i) + arc4random() % 40, 160, 40);
            UITextField *td = [[UITextField alloc] initWithFrame:rect];
            td.borderStyle = UITextBorderStyleRoundedRect;
            td;
        });
        [scrollView addSubview:textField];
        // scrollView.contentSize = CGSizeMake(375, CGRectGetMaxY(textField.frame));
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingAction:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)dynamicURL {
    CC_ServerURLManager *mg = [CC_ServerURLManager cc_defaultManager];
    mg.keyword = @"A";
    
    NSDictionary *urlDic = @{
                             @"分支环境":@{
                                            @"xjq_url":@"https://www.google.com",
                                            @"IM_url":@"https://www.baidu.com",
                                            @"jjx_url":@"https://www.baidu23.com",
                                            @"bt_url":@"https://developer.apple.com",
                                            @"ft_url":@"https://developer.apple123.com"
                                        },
                             @"测试环境":@{
                                            @"xjq_url":@"https://www.google.com",
                                            @"IM_url":@"https://www.baidu.com",
                                            @"jjx_url":@"https://www.baidu23.com",
                                            @"bt_url":@"https://developer.apple.com",
                                            @"ft_url":@"https://developer.apple999.com"
                                        },
                             @"线上环境":@{
                                            @"xjq_url":@"https://www.google.com",
                                            @"IM_url":@"https://developer.apple.com",
                                            @"jjx_url":@"https://www.baidu23.com",
                                            @"bt_url":@"https://developer.apple.com",
                                            @"ft_url":@"https://developer.apple.com",
                                        }
                             };
    
    [mg cc_setupWithURLDic:urlDic];
    
    [mg cc_setCompletion:^(NSArray * _Nonnull servers) {
        NSLog(@"%@",servers);
    }];
}

- (void)endEditingAction:(UITapGestureRecognizer *)sender {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

@end
