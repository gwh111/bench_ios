//
//  CC_View.m
//  bench_ios
//
//  Created by gwh on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_View.h"
#import "CC_Share.h"

@implementation CC_View

+ (CC_View *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_View *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}

//
//+ (CC_View *)createWithFrame:(CGRect)frame relative:(BOOL)relative backgroundColor:(UIColor *)backgroundColor inView:(UIView *)view{
//    CC_View *newV=[[CC_View alloc]initWithFrame:frame];
//    if (relative) {
//        newV.frame=CGRectMake([ccui getRH:frame.origin.x], [ccui getRH:frame.origin.y], [ccui getRH:frame.size.width], [ccui getRH:frame.size.height]);
//    }
//    [newV setBackgroundColor:backgroundColor];
//    [view addSubview:newV];
//    return newV;
//}
//
//+ (CC_View *)createWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor inView:(UIView *)view{
//    return [self createWithFrame:frame relative:NO backgroundColor:backgroundColor inView:view];
//}
//
//+ (CC_View *)createWithFrame_r:(CGRect)frame backgroundColor:(UIColor *)backgroundColor inView:(UIView *)view{
//    return [self createWithFrame:frame relative:YES backgroundColor:backgroundColor inView:view];
//}

+ (CC_View *)createOnView:(UIView *)view backgroundColor:(UIColor *)backgroundColor{
    CC_View *newV=[[CC_View alloc]init];
    [newV setBackgroundColor:backgroundColor];
    [view addSubview:newV];
    return newV;
}

+ (CC_View *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor{
    return [self cr:view l:left t:top w:width h:height bgc:backgroundColor relative:NO];
}

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor{
    return [self cr:view l:left t:top w:width h:height bgc:backgroundColor relative:YES];
}

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor relative:(BOOL)relative{
    CC_View *newV=[self createOnView:view backgroundColor:backgroundColor];
    if (relative) {
        newV.left=[ccui getRH:left];
        newV.top=[ccui getRH:top];
        newV.width=[ccui getRH:width];
        newV.height=[ccui getRH:height];
    }else{
        newV.left=left;
        newV.top=top;
        newV.width=width;
        newV.height=height;
    }
    return newV;
}

+ (CC_View *)cr:(UIView *)view r:(float)right b:(float)bottom w:(float)width h:(float)height bgc:(UIColor *)backgroundColor{
    CC_View *newV=[self createOnView:view backgroundColor:backgroundColor];
    newV.right=[ccui getRH:right];
    newV.bottom=[ccui getRH:bottom];
    newV.width=[ccui getRH:width];
    newV.height=[ccui getRH:height];
    return newV;
}

+ (CC_View *)cr:(UIView *)view cx:(float)centerX cy:(float)centerY w:(float)width h:(float)height bgc:(UIColor *)backgroundColor{
    CC_View *newV=[self createOnView:view backgroundColor:backgroundColor];
    newV.center=CGPointMake([ccui getRH:centerX], [ccui getRH:centerY]);
    newV.width=[ccui getRH:width];
    newV.height=[ccui getRH:height];
    return newV;
}

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top r:(float)right b:(float)bottom bgc:(UIColor *)backgroundColor{
    CC_View *newV=[self createOnView:view backgroundColor:backgroundColor];
    newV.left=[ccui getRH:left];
    newV.top=[ccui getRH:top];
    newV.right=[ccui getRH:right];
    newV.bottom=[ccui getRH:bottom];
    return newV;
}

@end
