//
//  UIResponder+CC.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UIResponder+CC.h"

static __weak id currentFirstResponder;

@implementation UIResponder (CC)

+ (id)cc_currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder {
    currentFirstResponder = self;
}

@end
