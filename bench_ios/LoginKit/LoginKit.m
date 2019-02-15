//
//  LoginKit.m
//  bench_ios
//
//  Created by gwh on 2019/2/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginKit.h"

@interface LoginKit(){
    NSString *urlStr;
}

@end

@implementation LoginKit

static LoginKit *userManager=nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[LoginKit alloc]init];
    });
    return userManager;
}

- (void)setUrlStr:(NSString *)str{
    urlStr=str;
}

- (NSURL *)getUrl{
    if (urlStr.length<0) {
        CCLOG(@"urlStr=nil");
    }
    return [NSURL URLWithString:urlStr];
}

- (CC_HttpTask *)getHttpTask{
    if (_httpTask) {
        return _httpTask;
    }
    return [CC_HttpTask getInstance];
}

@end
