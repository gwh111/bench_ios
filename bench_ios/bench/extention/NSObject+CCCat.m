//
//  NSObject+CCExtention.m
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import "NSObject+CCCat.h"
#import <objc/runtime.h>

@implementation NSObject(CCCat)

#pragma mark kv help

- (id)setClassKVDic:(NSDictionary *)dic{
    
    NSArray *names=[self getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name=names[i];
        id value=[dic valueForKey:name];
        if (!value) {
            continue;
        }
        [self setValue:value forKey:name];
    }
    return self;
}

- (NSDictionary *)getClassKVDic{
    
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]init];
    
    NSArray *names=[self getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name=names[i];
        id value=[self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    
    return mutDic;
}

- (NSDictionary *)getClassKVDic_equal{
    
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]init];
    
    NSArray *names=[self getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name=names[i];
        if (name.length>1) {
            name=[name substringFromIndex:1];
        }
        id value=[self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    
    return mutDic;
}

- (NSArray *)getClassNameList{
    
    NSMutableArray *mutArr=[[NSMutableArray alloc]init];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        
        NSString *name=[NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        
        [mutArr addObject:name];
    }
    
    // 释放
    free(ivars);
    
    return mutArr;
}

- (NSArray *)getClassTypeList{
    
    NSMutableArray *mutArr=[[NSMutableArray alloc]init];
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量类型
        Ivar ivar = *(ivars + i);
        
        NSString *name=[NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        
        [mutArr addObject:name];
    }
    
    // 释放
    free(ivars);
    
    return mutArr;
}

@end
