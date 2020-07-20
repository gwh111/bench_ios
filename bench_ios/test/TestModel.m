//
//  TestModel.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestModel.h"
#import "ccs.h"

// 实例变量=特殊的成员变量（自定义类声明 id）

@implementation TestModel

- (void)addBlock:(void(^)(NSString *str))block {
//    NSLog(@"1");
    _robots = @"aaa";
    block(@"aa");
//    _block = block;
//    [ccs delay:3 block:^{
//        block(@"aa");
//    }];
    id arr = NSMutableArray.new;
    id __weak array2=arr;
    id __block array3=arr;
    void (^addBlockResult)(BOOL);
    addBlockResult = ^(BOOL isSuccess){
        array3=nil;
        NSLog(@"array2%@", array2);
        NSLog(@"%@", self->_robots);
        NSLog(@"%@", self.robots);
        
    };
    addBlockResult(YES);
}

- (void)cc_update{
    CCLOG(@"%@ %@",self.cc_modelDictionary,self.cc_modelDictionary[@"str1"]);
    
}

- (void)dealloc {
    CCLOG(@"TestModel dealloc");
}

@end

@implementation TestSubModel

@end

@implementation TestSubArrayModel

@end
