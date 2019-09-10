//
//  CC_Double.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Double(v) [CC_Double value:v]

@interface CC_Double : NSObject

@property (nonatomic,assign) double value;

+ (CC_Double *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
