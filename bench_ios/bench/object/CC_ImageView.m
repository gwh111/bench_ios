//
//  CC_ImageView.m
//  bench_ios
//
//  Created by gwh on 2018/10/19.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CC_ImageView.h"
#import "CC_Share.h"

@implementation CC_ImageView

+ (CC_ImageView *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_ImageView *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}

@end
