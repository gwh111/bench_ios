//
//  CC_LogicClass.h
//  bench_ios
//
//  Created by gwh on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Logic : NSObject

/**
 *  版本号对比 如1.3.1 比 1.4.2版本低 返回-1
 *  1 v1>v2
 *  0 v1=v2
 * -1 v1<v2
 */
+ (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2;

@end
