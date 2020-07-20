//
//  CC_Bool.h
//  bench_ios
//
//  Created by gwh on 2020/4/20.
//

#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Bool : CC_Object

#define CC_BOOL(v) [CC_Bool value:v]
@property (nonatomic,assign) BOOL value;

+ (CC_Bool *)value:(BOOL)value;

@end

NS_ASSUME_NONNULL_END
