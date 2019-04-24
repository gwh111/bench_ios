//
//  testCommomVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testCommomVC.h"

@interface testCommomVC ()

@end

@implementation testCommomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR_WHITE;
    
    {
        UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, RH(200), RH(40))];
        l.font=RF(14);
        [self.view addSubview:l];
    }
    
    //设置主色调和辅助色调
    [CC_UIHelper getInstance].mainColor=ccRGBA(88, 149, 247, 1);
    [CC_UIHelper getInstance].subColor=ccRGBA(111, 111, 111, 1);
    
    float step=RH(10);
    float width=RH(320);
    float height=RH(40);
    
    UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 40)];
    l.backgroundColor=[UIColor brownColor];
    l.text=@"普通 不放大";
    [self.view addSubview:l];
    
    UILabel *l2=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l.bottom+step, RH(200), height)];
    l2.backgroundColor=[UIColor greenColor];
    l2.text=@"自适应大小";
    [self.view addSubview:l2];
    
    UILabel *l3=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l2.bottom+step, width, height)];
    l3.font=UI_BIG_TITLE_FONT;
    l3.textColor=UI_BIG_TITLE_FONT_COLOR;
    l3.text=@"app通用默认字体-大标题";
    [self.view addSubview:l3];
    
    UILabel *l4=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l3.bottom+step, width, height)];
    l4.font=UI_TITLE_FONT;
    l4.textColor=UI_TITLE_FONT_COLOR;
    l4.text=@"app通用默认字体-标题（详情内容）";
    [self.view addSubview:l4];
    
    UILabel *l5=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l4.bottom+step, width, height)];
    l5.font=UI_CONTENT_FONT;
    l5.textColor=UI_CONTENT_FONT_COLOR;
    l5.text=@"app通用默认字体-内容";
    [self.view addSubview:l5];
    
    UILabel *l6=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l5.bottom+step, width, height)];
    l6.font=UI_DATE_FONT;
    l6.textColor=UI_DATE_FONT_COLOR;
    l6.text=@"app通用默认字体-日期";
    [self.view addSubview:l6];
    
    UILabel *l7=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l6.bottom+step, width, height)];
    l7.font=UI_CONTENT_FONT;
    l7.textColor=COLOR_WHITE;
    l7.backgroundColor=UI_MAIN_COLOR;
    l7.text=@"主色调";
    [self.view addSubview:l7];
    
    UILabel *l8=[[UILabel alloc]initWithFrame:CGRectMake(RH(10), l7.bottom+step, width, height)];
    l8.font=UI_CONTENT_FONT;
    l8.textColor=COLOR_WHITE;
    l8.backgroundColor=UI_SUB_COLOR;
    l8.text=@"辅色调";
    [self.view addSubview:l8];
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
