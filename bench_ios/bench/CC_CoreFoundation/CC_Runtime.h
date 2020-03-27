//
//  CC_Runtime.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Runtime : CC_Object

+ (instancetype)shared;

+ (id)cc_getObject:(id)object key:(SEL)key;
+ (void)cc_setObject:(id)object key:(SEL)key value:(id)value;

// 交换方法 新方法只能被交换一次
+ (void)cc_exchangeInstance:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector;
+ (void)cc_exchangeClass:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector;

// 交换方法 新方法可以被多个旧方法交换
+ (void)cc_swizzlingInstance:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END
