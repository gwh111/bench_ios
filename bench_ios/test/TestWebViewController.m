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
    
    [ccs pushWebViewControllerWithUrl:@"https://juejin.im/post/5d64de36e51d45620d2cb91c"];
    
    [ccs showNotice:@"hello"];
}

@end
