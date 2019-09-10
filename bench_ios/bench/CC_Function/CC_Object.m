//
//  CC_Object.m
//  testbenchios
//
//  Created by gwh on 2019/8/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Object.h"

@implementation CC_Object

+ (id)cc_copyObject:(id)object{
    if (!object) {
        return nil;
    }
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:object];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


@end
