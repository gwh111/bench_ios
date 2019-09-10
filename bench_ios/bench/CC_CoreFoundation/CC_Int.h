//
//  CC_Int.h
//  testbenchios
//
//  Created by gwh on 2019/8/23.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Int(v) [CC_Int value:v]

@interface CC_Int : NSObject

@property (nonatomic,assign) int value;

+ (CC_Int *)value:(double)value;

@end

NS_ASSUME_NONNULL_END
