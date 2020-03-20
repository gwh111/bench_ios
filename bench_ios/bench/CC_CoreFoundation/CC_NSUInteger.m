//
//  CC_NSUInterge.m
//  bench_ios
//
//  Created by gwh on 2020/1/7.
//

#import "CC_NSUInteger.h"
#import "CC_Base.h"

@implementation CC_NSUInteger

+ (CC_NSUInteger *)value:(double)value {
    CC_NSUInteger *d = [CC_Base.shared cc_init:[CC_NSUInteger class]];
    d.value = value;
    return d;
}

@end
