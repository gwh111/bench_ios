//
//  NSData+CC_Lib.m
//  testbenchios
//
//  Created by gwh on 2019/8/22.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "NSData+CC_Foundation.h"

@implementation NSData (CC_Foundation)

- (NSString *)cc_convertToUTF8String {
    return [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSString *)cc_convertToBase64String {
    return [self base64EncodedStringWithOptions:0];
}

- (NSDictionary *)cc_convertToDictionary {
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:nil];
    return dictionary;
}

@end
