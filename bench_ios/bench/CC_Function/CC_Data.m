//
//  CC_Data.m
//  testbenchios
//
//  Created by gwh on 2019/8/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Data.h"

@implementation CC_Data

+ (NSData *)cc_archivedDataWithObject:(id)object{
    if (!object) {
        return nil;
    }
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:object];
    return tempArchive;
}

+ (id)cc_unarchivedObjectWithData:(id)data{
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
