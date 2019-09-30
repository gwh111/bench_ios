//
//  testNetwork.m
//  testbenchios
//
//  Created by gwh on 2019/8/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestNetwork.h"

@implementation TestNetwork

+ (void)start {
    HttpModel *model = [[HttpModel alloc]init];
    model.forbiddenJSONParseError = YES;
    [ccs.httpTask get:@"https://blog.csdn.net/gwh111/article/details/100700830" params:@{@"key":@"value"} model:model finishBlock:^(NSString *error, HttpModel *result) {
        
    }];
    
//    [ccs.imageView cc_setImageWithURL:[NSURL URLWithString:@""]];
}

@end
