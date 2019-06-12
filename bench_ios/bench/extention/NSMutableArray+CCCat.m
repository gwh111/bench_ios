//
//  NSMutableArray+CCCat.m
//  Doctor
//
//  Created by 路飞 on 2019/6/10.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "NSMutableArray+CCCat.h"

@implementation NSMutableArray (CCCat)

- (void)safe_addObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)safe_insertObject:(id)object withIndex:(NSInteger)index
{
    
    if (index > self.count || !object) {
        return; // 过滤到异常部分
    }
    return [self insertObject:object atIndex:index];
}

@end
