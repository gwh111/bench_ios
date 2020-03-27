//
//  CC_ShareUI.m
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "CC_UI.h"

@implementation CC_UI

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

@end
