//
//  CC_NSUInterge.h
//  bench_ios
//
//  Created by gwh on 2020/1/7.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_NSUINTEGER(v) [CC_NSUInteger value:v]

@interface CC_NSUInteger : CC_Object

@property (nonatomic,assign) NSUInteger value;

+ (CC_NSUInteger *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
