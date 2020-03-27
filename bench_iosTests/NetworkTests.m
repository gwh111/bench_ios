//
//  NetworkTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/17.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

@interface NetworkTests : XCTestCase

@end

@implementation NetworkTests

- (void)testExample {
    
//    https://apple@huored.gicp.net:8088/svn/bench_ios/trunk/bench_ios_net/bench_ios
}

- (void)testSVN {
    
    [ccs.httpTask post:@"https://apple@huored.gicp.net:8088/svn/bench_ios/trunk/bench_ios_net/bench_ios" params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
        
        NSLog(@"error");
        
        
    }];
    
}

@end
