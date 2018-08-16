//
//  testAutoLabelGroupVC.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "testAutoLabelGroupVC.h"
#import "CC_AutoLabelGroup.h"

@interface testAutoLabelGroupVC (){
    CC_AutoLabelGroup *group;
}

@end

@implementation testAutoLabelGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    group=[[CC_AutoLabelGroup alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    group.delegate=self;
    [group updateType:Center width:[ccui getW] stepWidth:[ccui getRH:10] sideX:[ccui getRH:10] sideY:[ccui getRH:10] itemHeight:[ccui getRH:30]];
    
    //单元样本创建
    CC_Button *sampleBt=[[CC_Button alloc]init];
    [sampleBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sampleBt setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [sampleBt setBackgroundColor:[UIColor brownColor]];
    [sampleBt setBackgroundColor:[UIColor brownColor] forState:UIControlStateNormal];
    [sampleBt setBackgroundColor:[UIColor grayColor] forState:UIControlStateSelected];
    sampleBt.titleLabel.font=[ccui getRFS:16];
    sampleBt.selected=YES;
    group.sampleBt=sampleBt;
    
    [group updateLabels:@[@"s大萨达",@"该数据库",@"请问骨灰盒",@"而我则是",@"功夫鸡排行"] selected:@[@(1),@(0),@(1),@(0),@(0)]];
    [self.view addSubview:group];
    
}

- (void)buttonTappedwithIndex:(int)index button:(UIButton *)button{
    if (index==0) {
        [group updateLabels:@[@"s大萨达d",@"该数据库",@"请问是的骨的灰盒",@"而我则是",@"功夫鸡排行sfew",@"功夫鸡排第三方行"] selected:@[@(1),@(1),@(0),@(0),@(0),@(1)]];
    }else if (index==1){
        [group updateLabels:@[@"s大萨达d",@"该数据库",@"请问是的骨的灰盒",@"而我则是xxx",@"功夫鸡排行sfew",] selected:@[@(1),@(1),@(0),@(0),@(0)]];
    }else{
        [group updateLabels:@[@"萨达",@"该数据库问是的骨的",] selected:@[@(1),@(1)]];
    }
    
}

@end
