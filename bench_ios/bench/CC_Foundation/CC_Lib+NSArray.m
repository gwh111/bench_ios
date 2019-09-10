//
//  NSArray+CC_Lib.m
//  testbenchios
//
//  Created by gwh on 2019/8/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Lib+NSArray.h"

@implementation NSMutableArray (CC_Lib)

- (void)cc_addObject:(id)obj{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)cc_ascending
{
    [self sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
    {
        if ([obj1 integerValue] > [obj2 integerValue])
        {
            return NSOrderedDescending;
        }
        else
        {
            return NSOrderedAscending;
        }
    }];
}

- (void)cc_descending
{
    [self sortUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2)
     {
         if ([obj1 integerValue] < [obj2 integerValue])
         {
             return NSOrderedDescending;
         }
         else
         {
             return NSOrderedAscending;
         }
     }];
}

@end
