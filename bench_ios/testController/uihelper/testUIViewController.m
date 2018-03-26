//
//  testUIViewController.m
//  bench_ios
//
//  Created by gwh on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "testUIViewController.h"
#import <objc/runtime.h>

@interface testUIViewController ()

@end

@implementation testUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 300, 300)];
    v.backgroundColor=[UIColor greenColor];
    [self.view addSubview:v];
    
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    v2.backgroundColor=[UIColor yellowColor];
    [v addSubview:v2];
    
    [CC_Label createWithFrame:CGRectMake([ccui getRH:50], [ccui getRH:30], [ccui getRH:200], [ccui getRH:20]) andTitleString:@"2017-06-20" andAttributedString:nil andTitleColor:[UIColor grayColor] andBackGroundColor:nil andFont:[ccui getRelativeFont:nil fontSize:12] andTextAlignment:0 atView:v];
    
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(50, 30, 30, 30)];
    imgv.backgroundColor=[UIColor yellowColor];
    [v addSubview:imgv];
    
    UIScrollView *scro=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 39, 122, 34)];
    scro.backgroundColor=[UIColor orangeColor];
    [v addSubview:scro];
    
    
    
}




@end
