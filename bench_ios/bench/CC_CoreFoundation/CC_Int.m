//
//  CC_Int.m
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Int.h"
#import "CC_Base.h"

@implementation CC_Int

+ (CC_Int *)value:(double)value {
    CC_Int *d = [CC_Base.shared cc_init:[CC_Int class]];
    d.value = value;
    return d;
}

@end
