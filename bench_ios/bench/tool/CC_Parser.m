//
//  CC_Parser.m
//  bench_ios
//
//  Created by gwh on 2018/4/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Parser.h"
#import "CC_Share.h"

@implementation CC_Parser

+ (NSMutableArray *)addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap{
    for (int i=0; i<pathArr.count;i++) {
        NSMutableDictionary *itemDic=[[NSMutableDictionary alloc]initWithDictionary:pathArr[i]];
        if (!itemDic[idKey]) {
            CCLOG(@"%@", ccstr(@"%@ not found in arr",idKey));
            continue ;
        }
        NSString *idV=ccstr(@"%@",itemDic[idKey]);
        if (!getMap[idV]) {
            CCLOG(@"%@", ccstr(@"%@ not found in map",idV));
            continue ;
        }
        id mapV=getMap[idV];
        if (keepKey) {
            [itemDic setObject:mapV forKey:ccstr(@"%@_map",idKey)];
        }else{
            [itemDic setObject:mapV forKey:idKey];
        }
        [pathArr replaceObjectAtIndex:i withObject:itemDic];
    }
    return pathArr;
}

+ (NSMutableArray *)getMapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap{
    NSMutableArray *mutArr;
    NSDictionary *getMap;
    
    mutArr=[[NSMutableArray alloc]initWithArray:pathArr];
    getMap=pathMap;
    for (int i=0; i<mutArr.count; i++) {
        NSMutableDictionary *itemDic=[[NSMutableDictionary alloc]initWithDictionary:mutArr[i]];
        if (!itemDic[idKey]) {
            CCLOG(@"%@", ccstr(@"%@ not found in arr",idKey));
            continue ;
        }
        NSString *idV=ccstr(@"%@",itemDic[idKey]);
        if (!getMap[idV]) {
            CCLOG(@"%@", ccstr(@"%@ not found in map",idV));
            continue ;
        }
        id mapV=getMap[idV];
        if (keepKey) {
            [itemDic setObject:mapV forKey:ccstr(@"%@_map",idKey)];
        }else{
            [itemDic setObject:mapV forKey:idKey];
        }
        [mutArr replaceObjectAtIndex:i withObject:itemDic];
    }
    return mutArr;
}

@end
