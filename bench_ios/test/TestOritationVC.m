//
//  TestOritationVC.m
//  bench_ios
//
//  Created by gwh on 2019/12/10.
//

#import "TestOritationVC.h"
#import "ccs.h"

@interface TestOritationVC ()

@end

@implementation TestOritationVC

- (void)cc_viewWillDisappear {
    [ccs setDeviceOrientation:UIDeviceOrientationPortrait];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    CC_TableView *tableView = ccs.TableView
    .cc_addToView(self.cc_displayView)
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_backgroundColor(UIColor.whiteColor);
    [tableView cc_addTextList:@[@"UIDeviceOrientationPortrait",@"UIDeviceOrientationLandscapeLeft",@"UIDeviceOrientationLandscapeRight"] withTappedBlock:^(NSUInteger index) {

        if (index == 0) {
            [ccs setDeviceOrientation:UIDeviceOrientationPortrait];
        }
        if (index == 1) {
            [ccs setDeviceOrientation:UIDeviceOrientationLandscapeLeft];
        }
        if (index == 2) {
            [ccs setDeviceOrientation:UIDeviceOrientationLandscapeRight];
        }
    }];
}

@end
