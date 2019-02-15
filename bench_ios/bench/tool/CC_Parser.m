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

+ (NSMutableArray *)sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc{
    if (desc) {
        //降序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i; j++) {
                if (key) {
                    if ([mutArr[j][key] intValue] < [mutArr[j + 1][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j] intValue] < [mutArr[j + 1] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    }else{
        //升序
        for (int i = 0; i < mutArr.count; i++) {
            for (int j = 0; j < mutArr.count - 1 - i;j++) {
                if (key) {
                    if ([mutArr[j+1][key]intValue] < [mutArr[j][key] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }else{
                    if ([mutArr[j+1]intValue] < [mutArr[j] intValue]) {
                        [mutArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
        }
    }
    
    return mutArr;
}

+ (int)safeCheckStart:(ResModel *)resModel{
    if (!resModel.serviceStr) {
        return 0;
    }
    NSDictionary *templateDic=[ccs getLocalKeyNamed:@"safeCheck" andKey:resModel.serviceStr];
    if (templateDic) {
        return [self parseDic:resModel.resultDic templateDic:templateDic pathArr:nil service:resModel.serviceStr];
    }
    return 0;
}

+ (void)safeCheckEnd:(ResModel *)resModel{
    if (!resModel.serviceStr) {
        return;
    }
    [ccs gotoThread:^{
        [ccs saveLocalKeyNamed:@"safeCheck" andKey:resModel.serviceStr andValue:resModel.resultDic];
    }];
}

+ (BOOL)parseDic:(NSDictionary *)dic templateDic:(NSDictionary *)templateDic pathArr:(NSMutableArray *)pathArr service:(NSString *)serviceStr{
    
    if (!pathArr) {
        pathArr=[[NSMutableArray alloc]init];
    }
    
    NSArray *allKeys=[templateDic allKeys];
    
    for (int i=0; i<allKeys.count; i++) {
        NSString *key=allKeys[i];
        
        id tempV=templateDic[key];
        id v=dic[key];
        
        if (!v&&pathArr.count>0&&![CC_Validate hasChinese:key]&&![CC_Validate isPureInt:key]) {
            NSString *pathStr=@"";
            for (int i=0; i<pathArr.count; i++) {
                pathStr=[NSString stringWithFormat:@"%@%@:",pathStr,pathArr[i]];
            }
            pathStr=[NSString stringWithFormat:@"%@\n%@%@",serviceStr,pathStr,key];
            [ccs gotoMain:^{
                [CC_Notice showNoticeStr:[NSString stringWithFormat:@"%@字段丢失",pathStr]];
            }];
            return 1;
        }
        
        if ([tempV isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resDic=[NSDictionary dictionaryWithDictionary:v];
            NSDictionary *tempDic=[NSDictionary dictionaryWithDictionary:tempV];
            NSMutableArray *mutArr=[NSMutableArray arrayWithArray:pathArr];
            [mutArr addObject:key];
            if ([self parseDic:resDic templateDic:tempDic pathArr:mutArr service:serviceStr]) {
                return 1;
            }
        }else if ([tempV isKindOfClass:[NSArray class]])
        {
            NSArray *resArr=[NSArray arrayWithArray:v];
            NSArray *tempArr=[NSArray arrayWithArray:tempV];
            NSMutableArray *mutArr=[NSMutableArray arrayWithArray:pathArr];
            [mutArr addObject:key];
            if ([self parseArr:resArr templateArr:tempArr pathArr:mutArr service:serviceStr]) {
                return 1;
            }
        }else{
        }
    }
    return 0;
}

+ (BOOL)parseArr:(NSArray *)arr templateArr:(NSArray *)templateArr pathArr:(NSMutableArray *)pathArr service:(NSString *)serviceStr{
    
    if (arr.count<=0) {
        return 0;
    }
    if (templateArr.count<=0) {
        return 0;
    }
    
    for (int i=0; i<1; i++) {
        
        id tempV=templateArr[i];
        id v=arr[i];
        if ([tempV isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *resDic=[NSDictionary dictionaryWithDictionary:v];
            NSDictionary *tempDic=[NSDictionary dictionaryWithDictionary:tempV];
            if ([self parseDic:resDic templateDic:tempDic pathArr:pathArr service:serviceStr]) {
                return 1;
            }
        }else if ([tempV isKindOfClass:[NSArray class]])
        {
            NSArray *resArr=[NSArray arrayWithArray:v];
            NSArray *tempArr=[NSArray arrayWithArray:tempV];
            if ([self parseArr:resArr templateArr:tempArr pathArr:pathArr service:serviceStr]) {
                return 1;
            }
        }
    }
    return 0;
}

@end
