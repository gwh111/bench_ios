//
//  CC_Double.m
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Double.h"
#import "CC_Base.h"

@implementation CC_Double

+ (CC_Double *)value:(double)value {
    CC_Double *d = [CC_Base.shared cc_init:[CC_Double class]];
    d.value = value;
    return d;
}

@end
