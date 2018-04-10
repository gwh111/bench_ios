//
//  CC_LogicClass.m
//  bench_ios
//
//  Created by gwh on 2018/3/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_LogicClass.h"
#import "CC_Share.h"

@implementation CC_LogicClass

- (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2{
    if (!v1||!v2) {
        CCLOG("不能为空");
        return -100;
    }
    NSArray  *arr1 = [v1 componentsSeparatedByString:@"."];
    NSArray  *arr2 = [v2 componentsSeparatedByString:@"."];
    NSInteger c1=arr1.count;
    NSInteger c2=arr2.count;
    if (c1==0||c2==0) {
        CCLOG("分割错误");
        return -100;
    }
    for (int i=0; i<arr1.count; i++) {
        int item1=[arr1[i] intValue];
        int item2=[arr2[i] intValue];
        if (item1>item2) {
            return 1;
        }else if (item1<item2){
            return -1;
        }
    }
    
    if (c1>c2) {
        return 1;
    }else if (c1<c2){
        return -1;
    }else{
        return 0;
    }
    
    return 999;
}

@end
