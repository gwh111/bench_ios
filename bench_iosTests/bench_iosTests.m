//
//  bench_iosTests.m
//  bench_iosTests
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import "CC_Loading.h"
//#import "CC_DES.h"
#import "ccs.h"
#import "CC_SandboxStore.h"

@interface bench_iosTests : XCTestCase

@end

@implementation bench_iosTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    [CC_Loading getInstance];
    
    id nilVal = nil;
    id nilKey = nil;
    id nonNilKey = @"non-nil-key";
    id nonNilVal = @"non-nil-val";
    NSDictionary *dict = @{
        nonNilKey: nilVal,
        nilKey: nonNilVal,
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *expectedString = @"{\"non-nil-key\":null}";
    XCTAssertEqualObjects(jsonString, expectedString);
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
//    NSString *desEncryptStr = [CC_DES cc_encryptUseDES:@"testString" key:@"xxxxxxxxxx"];
//    NSString *desDecryptStr = [CC_DES cc_decryptUseDES:desEncryptStr key:@"xxxxxxxxx"];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *outputName = @"xxx.mp4";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentPaths objectAtIndex:0];
    
//    [CC_SandboxStore cc_createSandboxDocWithName:@"record"];
//    documentDirectory = [documentDirectory stringByAppendingPathComponent:@"record"];
//    documentDirectory = [documentDirectory stringByAppendingPathComponent:outputName];
//    [CC_SandboxStore cc_deleteSandboxFileWithName:[ccs string:@"record/%@",outputName]];
//    NSLog(@"finish%@",documentDirectory);
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
