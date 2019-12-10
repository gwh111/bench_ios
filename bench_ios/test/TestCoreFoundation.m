//
//  testCoreFoundation.m
//  testbenchios
//
//  Created by gwh on 2019/8/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestCoreFoundation.h"

@implementation TestCoreFoundation

+ (void)start{
    
    [CC_Runtime shared];
    
    // 共享数据 重复设置一个字段会断言
    if ((1)) {
        [ccs setShared:@"userName" value:@"a"];
//        [ccs setShared:@"userName" obj:@"a"];// assert
        [ccs resetShared:@"userName" value:@"a"];
        CCLOG(@"%@",[ccs sharedValueForKey:@"userName"]);
    }
}

@end
