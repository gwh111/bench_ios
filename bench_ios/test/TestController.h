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

@property (nonatomic, retain) NSString *n;

- (void)methd2withA:(NSString *)a b:(NSArray *)b;

@end

@interface TestController : CC_Controller

- (void)cc_setup:(void (^)(TestController *c))block;

@end

@interface ExtensionClass : NSObject //类的声明
@property (assign,nonatomic) float value; //声明公开只读属性
- (void)m1;

@end

NS_ASSUME_NONNULL_END
