//
//  Test_LibUIViewController.m
//  bench_ios
//
//  Created by relax on 2019/9/5.
//

#import "Test_LibUIViewController.h"
#import "ccs.h"

@interface Test_LibUIViewController ()
{
    CC_LabelGroup *_group;
}
@end

@implementation Test_LibUIViewController

- (void)cc_viewWillLoad {
    self.cc_displayView.cc_backgroundColor(UIColor.whiteColor);
    self.cc_title = @"Test_LibUIViewController";
    
//    [self test_Alert];
//    [self test_mask];
    [self test_notice];
//    [self test_labelGroup];
}

- (void)test_Alert
{
    [ccs showAltOn:self title:@"haha" msg:@"你猜" bts:@[@"取消",@"确定"] block:^(int index, NSString *name) {
        CCLOG(@"showAlert index = %d btn name = %@",index,name);
    }];

    [ccs showTextFieldAltOn:self title:@"haha" msg:@"你猜" placeholder:@"猜不着" bts:@[@"取消",@"确定",@"ok"] block:^(int index, NSString *name, NSString *text) {
        CCLOG(@"showTextFieldsAlert index = %d btn name = %@",index,name);
    }];

    [ccs showTextFieldsAltOn:self title:@"haha" msg:@"你猜" placeholders:@[@"猜",@"不",@"着"] bts:@[@"取消",@"确定",@"ok"] block:^(int index, NSString *name, NSArray *texts) {
        CCLOG(@"showTextFieldsAlert index = %d btn name = %@ textFields text array = %@",index,name,texts);
    }];
}

- (void)test_mask
{
    //loading
    [ccs maskStart];
    [ccs delay:2 block:^{
        [ccs maskStop];
    }];
}

- (void)test_notice
{
    //toast
//    [ccs showNotice:@"haha"];
//    [ccs showNotice:@"haha" atView:self.cc_baseView];
    [ccs showNotice:@"haha" atView:self.cc_displayView delay:4];
}

- (void)test_labelGroup
{
    _group = [ccs LabelGroup];
    _group.backgroundColor = UIColor.blueColor;
    [_group updateType:CCLabelAlignmentTypeCenter
                 width:WIDTH()
             stepWidth:RH(10)
                 sideX:RH(10)
                 sideY:RH(10)
            itemHeight:RH(30)
                margin:RH(5)];
    
    [_group updateLabels:@[@"ha",@"haha",@"hahaha",@"hahahaha",@"hahahahaha"] selected:@[@(1),@(0),@(1),@(0),@(0)]];
    
    [self.cc_displayView addSubview:_group];
    
}

@end
