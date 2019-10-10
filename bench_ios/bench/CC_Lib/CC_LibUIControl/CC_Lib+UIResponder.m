//
//  UIResponder+CCCat.m
//  bench_ios
//
//  Created by ml on 2019/6/3.
//  Copyright © 2019 liuyi. All rights reserved.
//

#import "CC_Lib+UIResponder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (CC_Lib)

+ (id)cc_currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
