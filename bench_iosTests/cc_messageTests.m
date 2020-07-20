//
//  TestRuntime.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/6.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

#import "Father.h"

@interface cc_messageTests : XCTestCase

@end

@implementation cc_messageTests

- (void)testExample {
    
}

- (void)testGetProperty {
    
    Father *f = Father.new;
    NSLog(@"%@",f.name);
    id name = [cc_message cc_targetInstance:f method:@"name" params:nil];
    NSLog(@"%@",name);
    id x = [cc_message cc_targetInstance:f method:@"x" params:nil];
    NSLog(@"%@",x);
    
}

- (void)testSetProperty {
    
    Father *f = Father.new;
    NSLog(@"%@",f.name);
    f.name = @"new name0";
    NSLog(@"%@",f.name);
    [f setName:@"new name1"];
    NSLog(@"%@",f.name);
    id name = [cc_message cc_targetInstance:f method:@"setName:" params:@"new name2"];
    NSLog(@"%@",f.name);
//    id x = [cc_message cc_targetInstance:f method:@"setX:" params:CC_Int(100)];
//    NSLog(@"%d",f.x);
    
}

@end
