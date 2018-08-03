//
//  testColorViewController.m
//  bench_ios
//
//  Created by gwh on 2017/8/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "testColorViewController.h"
#import "CC_Share.h"

@interface testColorViewController ()

@end

@implementation testColorViewController
- (void)bbb{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor blackColor];
    
    CC_Button *button=[[CC_Button alloc]init];
    button.frame=CGRectMake(100, 100, 100, 100);
    button.backgroundColor=[UIColor brownColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(bbb) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *zsImg=[UIImage imageNamed:@"nyyh.jpg"];
    
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 90, 90)];
    img.image=zsImg;
    [self.view addSubview:img];
    
    UIImageView *zsv=[[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 90, 90)];
    [self.view addSubview:zsv];
    zsv.backgroundColor=[CC_GColor getPixelColorAtLocation:CGPointMake(50, 10) inImage:zsImg];
    
    UIImageView *zsv2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 300, 90, 90)];
    [self.view addSubview:zsv2];
    zsv2.backgroundColor=[CC_GColor getImageMayColor:zsImg];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
