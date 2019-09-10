//
//  CC_Float.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Float(v) [CC_Float value:v]

@interface CC_Float : NSObject

@property (nonatomic,assign) float value;

+ (CC_Float *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
