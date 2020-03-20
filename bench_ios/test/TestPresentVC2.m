//
//  PresentVC2.m
//  bench_ios
//
//  Created by gwh on 2020/1/9.
//

#import "TestPresentVC2.h"
#import "ccs.h"
#import "TestPresentVC3.h"

@interface TestPresentVC2 ()

@end

@implementation TestPresentVC2

- (void)cc_viewWillLoad {
   
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [ccs delay:3 block:^{
        
        TestPresentVC3 *vc = [ccs init:TestPresentVC3.class];
        vc.name = @"aa";
        [vc config];
        [vc loadViewIfNeeded];
        [ccs pushViewController:vc];
        
    }];
    
    CC_Button *close =
    ccs.ui.closeButton
    .cc_top(RH(100))
    .cc_addToView(self);
    [close cc_addTappedOnceDelay:0 withBlock:^(CC_Button *btn) {
       
        [ccs dismissViewController];
    }];
    
    self.tabBarController;
}

@end
