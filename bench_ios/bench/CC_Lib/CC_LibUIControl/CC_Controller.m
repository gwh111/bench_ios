//
//  CC_Controller.m
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Controller.h"

@interface CC_Controller ()

@end

@implementation CC_Controller
@synthesize cc_delegate;

- (void)cc_willInit {
    
}

- (void)cc_setup {
    
}

- (void)cc_setup:(void(^)(id c))block {
    
    [self cc_setup];
    if (block) {
        block(self);
    }
}

@end
