//
//  CC_Tool.m
//  bench_ios
//
//  Created by gwh on 2020/2/3.
//

#import "CC_Tool.h"

@implementation CC_Tool

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

@end
