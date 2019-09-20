//
//  CC_CoreBase.m
//  bench_ios
//
//  Created by gwh on 2019/8/30.
//

#import "CC_CoreBase.h"

@implementation CC_CoreBase

static CC_CoreBase *userManager = nil;
static dispatch_once_t onceToken;

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[CC_CoreBase alloc]init];
        
        userManager.cc_sharedAppDelegate = [[NSMutableDictionary alloc]init];
        userManager.sharedInstanceDic = [[NSMutableDictionary alloc]init];
        userManager.sharedObjDic = [[NSMutableDictionary alloc]init];
        userManager.sharedObjBindDic = [[NSMutableDictionary alloc]init];
    });
    return userManager;
}

@end
