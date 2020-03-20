//
//  TestPresentVC3.m
//  bench_ios
//
//  Created by gwh on 2020/1/9.
//

#import "TestPresentVC3.h"
#import "ccs.h"

@interface TestPresentVC3 ()

@end

@implementation TestPresentVC3

- (void)start {
    
//    [self.view addSubview:ccs.View];
    
}

- (void)cc_viewWillAppear {
    
    
}

- (void)cc_viewWillLoad {

   NSLog(@"cc_viewWillLoad");
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    // 从vc取tabbar
    id vc1 = self.cc_tabBarController;
    
    // 从view或vc地方取tabbar
    id vc2 = ccs.currentTabBarC;
    
    // 从view或vc地方取vc
    id vc3 = ccs.currentVC;
    
    // 拿导航
    id na = ccs.navigation;
    
    [ccs delay:3 block:^{
        [ccs popToRootViewControllerAnimated:NO];
    }];
}

- (void)config {
    
    NSLog(@"config");
}

@end
