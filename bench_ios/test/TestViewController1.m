//
//  ViewController.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestViewController1.h"
#import "TestViewController2.h"
#import "CC_Color.h"
#import "CC_Device.h"
#import "TestModel.h"
#import "TestView.h"
#import "TestController.h"
#import "ccs.h"

@interface TestViewController1 ()

@end

@implementation TestViewController1

+ (instancetype)shared{
    return [ccs registerSharedInstance:self block:^{
        // Do init things
    }];
}

- (void)cc_viewWillLoad{
    
    View(TestView.class);
    
    TestView *imgv=View(TestView.class);
    
    imgv
    .cc_addToView(self.view)
    .cc_frame(100, 200, 50, 50)
    .cc_backgroundColor(COLOR_LIGHT_ORANGE);
    [imgv cc_updateBadge:@"abc3"];
    [imgv cc_updateBadge:@"abc4"];
    
    [imgv test];
    
    CC_Color *c1=[[CC_Color alloc]init];
    [CC_Color colorWithWhite:1 alpha:2];
    
    id t1=[ccs model:[TestModel class]];
    [t1 cc_setProperty:@{@"st1":@"1",@"id":@"b",@"model1":@{@"st2":@"abc",@"st1":@"abcsd"}} modelKVDic:@{@"st2":@"id"}];
    [t1 cc_update];
    [@{@"st1":@"1",@"a":@"b"} cc_propertyCode];
    
    CCLOG(@"%@",APP_STANDARD(@"大标题"));
}

- (void)cc_viewDidLoad{
    
    
//    id vc1=[ccs get_vc:@"testVC"];
//    [ccs push_vc:vc1];
    
    TestViewController2 *vc1=[ccs viewController:TestViewController2.class];
    vc1.tests1=@"";
    [ccs pushViewController:vc1];
    
    
    NSMutableArray *arr=@[@"abc"].mutableCopy;
//    arr=[ccs get_shared:@"ab" obj:arr];
    
    CC_Button *bt;
    [bt setTitle:@"" forState:UIControlStateNormal];
    
    CC_View *v1=ccs.view;
    v1
    .cc_addToView(self.view)
    .cc_name(@"abc")
    .cc_frame(RH(10),RH(100),RH(100),RH(100))
    .cc_backgroundColor(UIColor.whiteColor)
    .cc_tappedInterval(3, ^(id view){
        
        [self cc_removeViewWithName:@"abc"];
    });
    
    CC_View *v2 = ccs.View;
    {typeof(v2) item = v2;
        item.cc_addToView(self.view)
            .cc_name(@"name")
            .cc_frame(RH(10),RH(100),RH(100),RH(100))
            .cc_backgroundColor(UIColor.whiteColor);
        
        [item cc_tappedInterval:3 block:^(id view) {
            [self cc_removeViewWithName:@"abc"];
        }];
    }
    
    
    
    
//    [v cc_tappedInterval:3 block:^(CC_View *view) {
//
//        CCLOG(@"v4=%@",view);
//    }];
    
}

- (void)cc_viewWillAppear{
//    NSArray *arr=[ccs get_shared:@"ab"];
//    CCLOG(@"aa=%@",arr);
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//
////    CC_UIViewController *vc=[[CC_UIViewController alloc]init];
////    [vc CC_Init:self];
//
//    id vc1=[ccs get_vc:@"testVC"];
//    [ccs push_vc:vc1];
//
//    UIViewController *vc2=[self change:vc1];
//    UIViewController *vc3=vc1;
//
//    [NSNotificationCenter defaultCenter];
//}

//Resolve warning: Incompatible pointer types initializing 'xxx *' with an expression of type 'xxx *'
- (id)change:(id)obj{
    return obj;
}

- (void)dealloc
{
    
}
@end
