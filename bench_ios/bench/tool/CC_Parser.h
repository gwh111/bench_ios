//
//  CC_Parser.h
//  bench_ios
//
//  Created by gwh on 2018/4/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_HttpResponseModel.h"

@interface CC_Parser : NSObject

/**
 * 将map的数据移置list中
 *
 * NSMutableArray *parr=[CC_Parser getMapParser:result[@"response"][@"purchaseOrders"] idKey:@"order" keepKey:YES pathMap:result[@"response"][@"paidFeeMap"]];
 * parr=[CC_Parser addMapParser:parr idKey:@"prize" keepKey:NO map:result[@"response"][@"prizeFeeMap"]];
 *
 * pathArr 需要获取的list路径 如result[@"response"][@"purchaseOrders"]
 * idKey 要取的map字段key 如purchseNo
 * keepKey 是否保留原字段 如purchseNo 本身含有意义要保留 会在key最后添加_map区分" 如xxxid 本身没有意义，为了取值而生成的id不保留 被map相应id的数据替换
 * mapPath 要取的map的路径 如result[@"response"][@"paidFeeMap"] map中可以是nsstring 也可以是nsdictionary
 */
+ (NSMutableArray *)getMapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap;

/**
 * 将map的数据移置list中 多个map时添加
 */
+ (NSMutableArray *)addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap;

/**
 *  冒泡排序
 *  desc=1 降序
    key=nil 直接对mutArr取值排序
 */
+ (NSMutableArray *)sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc;

/**
 *  根据上一次缓存验证请求结果是否少字段
    适用于必须有固定字段的请求
    不适用于多变结果、如类型很多，不同类型返回不同结构的请求
    返回 1 不成功
    if ([CC_Parser safeCheckStart:result]) {
        return;
    }
    [CC_Parser safeCheckEnd:result];
 */
+ (int)safeCheckStart:(ResModel *)resModel;
+ (void)safeCheckEnd:(ResModel *)resModel;

@end
