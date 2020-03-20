//
//  PresentVC.m
//  bench_ios
//
//  Created by gwh on 2020/1/9.
//

#import "TestPresentVC.h"
#import "ccs.h"
#import "TestPresentVC2.h"

@interface TestPresentVC ()

@end

@implementation TestPresentVC

- (void)cc_viewWillLoad {
   
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    [ccs delay:3 block:^{
        
        id vc = [ccs init:TestPresentVC2.class];
        [ccs presentViewController:vc];
    }];
}

@end
