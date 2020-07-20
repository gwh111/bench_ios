//
//  CC_Int.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_INT(v) [CC_Int value:v]

@interface CC_Int : CC_Object

@property (nonatomic,assign) int value;

+ (CC_Int *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
