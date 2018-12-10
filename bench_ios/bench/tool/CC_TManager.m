//
//  CC_TManager.m
//  bench_ios
//
//  Created by gwh on 2018/12/10.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CC_TManager.h"
#import "CC_Share.h"

@interface CC_TManager(){
    
    NSMutableArray *registerNameMutArr;
    NSMutableArray *registerBlockMutArr;
    NSMutableArray *registerTimeMutArr;
    NSMutableDictionary *registerMutDic;
    
    NSDate *lastDate;
    int pause;
    float minF;
}

@end

@implementation CC_TManager

static CC_TManager *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_TManager alloc] init];
        [instance initT];
    });
    return instance;
}

- (void)initT{
    
    minF=0.1;
    registerMutDic=[[NSMutableDictionary alloc]init];
    registerBlockMutArr=[[NSMutableArray alloc]init];
    registerNameMutArr=[[NSMutableArray alloc]init];
    registerTimeMutArr=[[NSMutableArray alloc]init];
    __block CC_TManager *weakSelf=self;
    [ccs gotoThread:^{
        [NSTimer scheduledTimerWithTimeInterval:weakSelf->minF target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]run];
    }];
}

- (void)runTimer{
    
    if (registerTimeMutArr.count==0) {
        return;
    }
    
    if (pause) {
        return;
    }
    
    NSTimeInterval add=0;
    NSDate *d2=[NSDate date];
    if (!lastDate) {
        add=minF;
    }else{
        add=[CC_Date compareDate:d2 cut:lastDate];
    }
    lastDate=d2;
    
    for (int i=0; i<registerTimeMutArr.count; i++) {
        float getT=[registerTimeMutArr[i] floatValue];
        NSString *name=registerNameMutArr[i];
        float need=[registerMutDic[name] floatValue];
        if (getT+add<need) {
            [registerTimeMutArr replaceObjectAtIndex:i withObject:@(getT+add)];
        }else{
            float plus=getT+add-need;
            
            [registerTimeMutArr replaceObjectAtIndex:i withObject:@(plus)];
            
            __block CC_TManager *weakSelf=self;
            [ccs gotoMain:^{
                void (^myBlock)(void)=weakSelf->registerBlockMutArr[i];
                myBlock();
            }];
        }
    }
    
}

- (void)registerT:(NSString *)name interval:(float)interval block:(void (^)(void))block{
    if (!name) {
        CCLOG(@"no name");
        return;
    }
    if (!interval) {
        CCLOG(@"interval invalid");
        return;
    }
    if (!registerMutDic[name]) {
        //防重复
        [registerMutDic setObject:@(interval) forKey:name];
        [registerNameMutArr addObject:name];
        [registerBlockMutArr addObject:block];
        [registerTimeMutArr addObject:@(0)];
    }
}

- (void)unRegisterT:(NSString *)name{
    
    if (!name) {
        CCLOG(@"no name");
        return;
    }
    pause=1;
    //写保护
    [registerMutDic removeObjectForKey:name];
    int index=-1;
    for (int i=0; i<registerNameMutArr.count; i++) {
        if ([registerNameMutArr[i]isEqualToString:name]) {
            index=i;
        }
    }
    if (index>=0) {
        [registerNameMutArr removeObjectAtIndex:index];
        [registerBlockMutArr removeObjectAtIndex:index];
        [registerTimeMutArr removeObjectAtIndex:index];
    }
    pause=0;
}

@end
