//
//  testCasVC.m
//  bench_ios
//
//  Created by gwh on 2018/7/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "testCasVC.h"

@interface testCasVC ()

@end

@implementation testCasVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(250, 100, 100, 40)];
    l.backgroundColor=[UIColor yellowColor];
    l.text=@"普通label";
    [self.view addSubview:l];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_v_figure1" type:CCView finishBlock:^(CC_View *atom) {
    }];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_b_box1" type:CCButton finishBlock:^(CC_Button *atom) {
        [atom setBackgroundColor:[UIColor brownColor]];
        [atom addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            CCLOG(@"tapped");
        }];
    }];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_l_box2" type:CCLabel finishBlock:^(CC_Label *atom) {
        //        atom.text=@"数据刷新";
        //        [atom sizeToFit];
    }];
    
    [CC_UIAtom initAt:self.view name:@"MainVC_tv_box1" type:CCTextView finishBlock:^(CC_TextView *atom) {
    }];
    
    CC_TextField *textField=[CC_UIAtom initAt:self.view name:@"MainVC_tf_box1" type:CCTextField finishBlock:^(id atom) {
    }];
    [CC_CodeClass setLineColorR:0 andG:0 andB:0 andA:1 width:2 view:textField];
    [CC_CodeClass setBoundsWithRadius:10 view:textField];
    
}

@end
