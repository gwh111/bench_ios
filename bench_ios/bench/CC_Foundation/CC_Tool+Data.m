//
//  CC_Tool+Data.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool+Data.h"

@implementation CC_Tool (Data)

- (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2 {
    if (!v1||!v2) {
        CCLOG("不能为空");
        return -100;
    }
    if (v1.length < v2.length) {
        for (int i=0; i<(v2.length-v1.length)/2; i++) {
            v1=[NSString stringWithFormat:@"%@.0",v1];
        }
    }else if (v2.length < v1.length){
        for (int i=0; i<(v1.length-v2.length)/2; i++) {
            v2=[NSString stringWithFormat:@"%@.0",v2];
        }
    }
    NSArray  *arr1 = [v1 componentsSeparatedByString:@"."];
    NSArray  *arr2 = [v2 componentsSeparatedByString:@"."];
    NSInteger c1 = arr1.count;
    NSInteger c2 = arr2.count;
    if (c1 == 0 || c2 == 0) {
        CCLOG("分割错误");
        return -100;
    }
    for (int i=0; i<arr1.count; i++) {
        int item1 = [arr1[i] intValue];
        int item2 = [arr2[i] intValue];
        if (item1 > item2) {
            return 1;
        }else if (item1 < item2){
            return -1;
        }
    }
    
    if (c1 > c2) {
        return 1;
    }else if (c1 < c2){
        return -1;
    }else{
        return 0;
    }
    
    return 999;
}

- (NSData *)archivedDataWithObject:(id)object {
    if (!object) {
        return nil;
    }
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:object];
    return tempArchive;
}

- (id)unarchivedObjectWithData:(id)data {
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

@end
