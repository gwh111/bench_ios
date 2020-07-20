//
//  CC_Float.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_FLOAT(v) [CC_Float value:v]

@interface CC_Float : CC_Object

@property (nonatomic,assign) float value;

+ (CC_Float *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
