//
//  TestModel.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (void)cc_update{
    CCLOG(@"%@ %@",self.cc_modelDic,self.cc_modelDic[@"str1"]);
}

@end
