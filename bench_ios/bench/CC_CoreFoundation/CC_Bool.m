//
//  CC_Bool.m
//  bench_ios
//
//  Created by gwh on 2020/4/20.
//

#import "CC_Bool.h"
#import "CC_Base.h"

@implementation CC_Bool

+ (CC_Bool *)value:(BOOL)value {
    CC_Bool *d = [CC_Base.shared cc_init:[CC_Bool class]];
    d.value = value;
    return d;
}

@end
