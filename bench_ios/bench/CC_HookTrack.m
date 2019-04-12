//
//  CC_HookTrack.m
//  bench_ios
//
//  Created by gwh on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_HookTrack.h"
#import "CC_CodeClass.h"
#import "CC_Share.h"

@implementation CC_HookTrack

static CC_HookTrack *userManager=nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[CC_HookTrack alloc]init];
    });
    return userManager;
}

+ (void)catchTrack{
    NSInteger max=5;
    NSInteger count=[NSThread callStackSymbols].count;
    if (count<max) {
        max=count;
    }
    NSString *popDetailInfo;
    if (max>3) {
        for (NSInteger i=max-1; i>2; i--) {
            popDetailInfo=ccstr(@"%@%@-",popDetailInfo?popDetailInfo:@"",[CC_Convert parseLabel:[NSThread callStackSymbols][i] start:@"[" end:@"]" includeStartEnd:YES]);
        }
        if ([CC_HookTrack getInstance].debug) {
            CCLOG(@"###%@###", popDetailInfo);
        }
    }
    [CC_HookTrack getInstance].triggerActionStr=popDetailInfo;
}

+ (void)willPushTo:(NSString *)toVC{
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@-%@-%@",[CC_HookTrack getInstance].currentVCStr,@"popTo",toVC];
    if ([CC_HookTrack getInstance].debug) {
        CCLOG(@"###%@###", popDetailInfo);
    }
    [CC_HookTrack getInstance].prePushActionStr=popDetailInfo;
}

+ (void)willPopOfIndex:(int)index{
    NSUInteger count=[CC_HookTrack getInstance].lastVCs.count;
    NSString *popToVC=[CC_HookTrack getInstance].lastVCs[count-index-1];
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@-%@-%@",[CC_HookTrack getInstance].currentVCStr,@"popTo",popToVC];
    if ([CC_HookTrack getInstance].debug) {
        CCLOG(@"###%@###", popDetailInfo);
    }
    [CC_HookTrack getInstance].prePopActionStr=popDetailInfo;
}

@end
