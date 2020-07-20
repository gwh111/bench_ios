//
//  CC_Double.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_DOUBLE(v) [CC_Double value:v]

@interface CC_Double : CC_Object

@property (nonatomic,assign) double value;

+ (CC_Double *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
