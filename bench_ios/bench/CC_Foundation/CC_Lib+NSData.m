//
//  NSData+CC_Lib.m
//  testbenchios
//
//  Created by gwh on 2019/8/22.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Lib+NSData.h"

@implementation NSData (CC_Lib)

- (NSString *)cc_convertToUTF8String{
    return [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSString *)cc_convertToBase64String{
    return [self base64EncodedStringWithOptions:0];
}

@end
