//
//  TestDates.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

@interface DateTests : XCTestCase

@end

@implementation DateTests

- (void)testExample {

}

- (void)testDateConvert {
    
    NSString *str = @"Sun, 05 Jan 2020 01:56:43 GMT";
    NSDate *date = [str cc_convertToDateWithformatter:@"E, dd MM yyyy HH:mm:ss z"];
    NSLog(@"%@",date);
    
    float w = PH(1);

}

- (void)testDateConvert2 {
    
    NSString *str = @"2020-02-30 05:15:09";
    NSDate *date = [str cc_convertToDateWithformatter:@"YYYY-MM-dd HH:mm:ss"];
    NSLog(@"%@",date);
    

}

@end

