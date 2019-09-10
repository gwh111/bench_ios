//
//  testController.h
//  testbenchios
//
//  Created by gwh on 2019/8/19.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TestControllerDelegate

- (void)methd2withA:(NSString *)a b:(NSArray *)b;

@end

@interface TestController : CC_Controller


@end

NS_ASSUME_NONNULL_END
