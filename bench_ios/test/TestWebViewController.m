//
//  testWebViewController.m
//  bench_ios
//
//  Created by gwh on 2019/8/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "TestWebViewController.h"
#import "ccs.h"

@implementation TestWebViewController

+ (void)start {
    
    [ccs pushWebViewControllerWithUrl:@"https://blog.csdn.net/gwh111/article/details/100700830"];
    
    [ccs maskStart];
    [ccs showNotice:@"hello"];
    [ccs delay:3 block:^{
        [ccs maskStop];
    }];
}

@end
