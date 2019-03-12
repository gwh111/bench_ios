//
//  bench_iosTests.m
//  bench_iosTests
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CC_Loading.h"

@interface bench_iosTests : XCTestCase

@end

@implementation bench_iosTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [CC_Loading getInstance];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
