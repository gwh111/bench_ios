//
//  CC_Float.m
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Float.h"
#import "CC_Base.h"

@implementation CC_Float

+ (CC_Float *)value:(double)value {
    CC_Float *d = [CC_Base.shared cc_init:[CC_Float class]];
    d.value = value;
    return d;
}

@end
