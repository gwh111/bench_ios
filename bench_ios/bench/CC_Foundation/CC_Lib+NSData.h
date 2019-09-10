//
//  NSData+CC_Lib.h
//  testbenchios
//
//  Created by gwh on 2019/8/22.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CC_Lib)

// data to string, utf8编码
- (NSString *)cc_convertToUTF8String;

// data to string, base64
- (NSString *)cc_convertToBase64String;

@end

