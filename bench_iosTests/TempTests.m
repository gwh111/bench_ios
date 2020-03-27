//
//  TempTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/10.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

@interface TempTests : XCTestCase

@end

@implementation TempTests

- (void)testEncode {
    
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
    [allowed addCharactersInString:@"!*'();:@&=+$,/?%#[]<>&\\"];
    
    NSString *tempString = [@"!abc1" stringByAddingPercentEncodingWithAllowedCharacters:[allowed invertedSet]];
    
}

- (void)testExample {
    
    NSString *input = @"10030";
    NSString *output = [self output:input];
    NSLog(@"%@",output);
    
}

- (NSString *)output:(NSString *)input {
    NSDictionary *map = @{@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六",@"7":@"七",@"8":@"八",@"9":@"九",@"0":@"零",};
    NSArray *names = @[@"",@"十",@"百",@"千",@"万"];
    NSString *output = @"";
    
    NSArray *cs = [input cc_convertToWord];
    if (cs.count == 1) {
        output = map[[ccs string:cs[0]]];
    } else {
        for (int i = 0; i < cs.count; i++) {
            NSString *word = map[cs[i]];
            if ([output hasSuffix:@"零"] && [word isEqualToString:@"零"]) {
            } else {
                output = [ccs string:@"%@%@",output,word];
            }
            if (![word isEqualToString:@"零"]) {
                NSString *name = names[cs.count - i - 1];
                output = [ccs string:@"%@%@",output,name];
            }
        }
    }
    
    return output;
}

@end
