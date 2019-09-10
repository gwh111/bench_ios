//
//  CC_Array.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Array : NSObject

// 中文的排序
// 排序一层中文 如 sortMutArr=@[@"张三",@"李四"]; depthArr=nil;
// 排序嵌套字典的数组 如 sortMutArr=@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}]; depthArr=@[@"name"];
+ (NSMutableArray *)cc_sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr;

// 冒泡排序
// desc=1 降序
// key=nil 直接对mutArr取值排序
+ (NSMutableArray *)cc_sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc;

// 将map的数据移置list中
// NSMutableArray *parr=[CC_Parser getMapParser:result[@"response"][@"purchaseOrders"] idKey:@"order" keepKey:YES pathMap:result[@"response"][@"paidFeeMap"]];
// parr=[CC_Parser addMapParser:parr idKey:@"prize" keepKey:NO map:result[@"response"][@"prizeFeeMap"]];
// pathArr 需要获取的list路径 如result[@"response"][@"purchaseOrders"]
// idKey 要取的map字段key 如purchseNo
// keepKey 是否保留原字段 如purchseNo 本身含有意义要保留 会在key最后添加_map区分" 如xxxid 本身没有意义，为了取值而生成的id不保留 被map相应id的数据替换
// mapPath 要取的map的路径 如result[@"response"][@"paidFeeMap"] map中可以是nsstring 也可以是nsdictionary
+ (NSMutableArray *)cc_mapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap;

// 将map的数据移置list中 多个map时添加
+ (NSMutableArray *)cc_addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap;

@end

NS_ASSUME_NONNULL_END
