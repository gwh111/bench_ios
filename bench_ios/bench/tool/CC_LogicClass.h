//
//  CC_LogicClass.h
//  bench_ios
//
//  Created by gwh on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_LogicClass : NSObject

/**
 *  1 v1>v2
 *  0 v1=v2
 * -1 v1<v2
 */
- (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2;

@end
