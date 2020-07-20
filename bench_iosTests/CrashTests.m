//
//  CrashTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/15.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

@interface CrashTests : XCTestCase

@end

@implementation CrashTests

- (void)testExample {
    
    
    
}

- (void)testCatchException {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    // 只能在appdeleage里注册
    [ccs.coreCrash setupUncaughtExceptionHandler];
    id arr = @[];
    [arr rangeAtIndex:4];
    
}

- (void)testArr {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    NSArray *arr = @[@"1"];
    id idadd = arr;
    [idadd addObject:@"1"];
    id i = arr[5];
    [arr objectAtIndex:3];
    
}

- (void)testMutArr {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    NSMutableArray *arr = ccs.mutArray;
    [arr removeObject:nil];
    [arr cc_addObject:@"1"];
    id i = arr[5];
    [arr objectAtIndex:3];
    
}

- (void)testDic {
    
    id dic = NSDictionary.new;
    [dic setObject:@"1" forKey:@"2"];
    
}

- (void)testMutDic {
    
    id mutDic = NSMutableDictionary.new;
    [mutDic setObject:@"1" forKey:nil];
    
}

@end
