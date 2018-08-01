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
 *  中文的排序
 *  proMutArr 需要排序的数组
 *  depthArr 字典深度的路径数组
 *  如排序一层中文 如@[@"张三",@"李四"];
    depthArr=nil;
 *  如排序嵌套字典的数组 如@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}];
    depthArr=@[@"name"];
 */
+ (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr;

/**
 * 从小到大排序
 */
+ (NSArray *)arrayAscending:(NSArray *)arr;

/**
 * 从大到小排序
 */
+ (NSArray *)arrayDescending:(NSArray *)arr;

@end
