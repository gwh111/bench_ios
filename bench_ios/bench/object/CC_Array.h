//
//  CC_Array.h
//  bench_ios
//
//  Created by gwh on 2017/8/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Array : NSArray

/**
 * 从小到大排序
 */
+ (NSArray *)arrayAscending:(NSArray *)arr;

/**
 * 从大到小排序
 */
+ (NSArray *)arrayDescending:(NSArray *)arr;

@end
