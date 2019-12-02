//
//  CC_ShareUI.m
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "CC_ShareUI.h"

@implementation CC_ShareUI

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

@end
