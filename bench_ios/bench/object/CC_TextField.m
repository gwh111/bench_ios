//
//  CC_TextField.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextField.h"
#import "CC_Share.h"

@implementation CC_TextField

+ (CC_TextField *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_TextField *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}




+ (CC_TextField *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height tc:textColor bgc:backgroundColor f:font ta:textAlignment ph:placeholder uie:userInteractionEnabled relative:YES];
}

+ (CC_TextField *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height tc:textColor bgc:backgroundColor f:font ta:textAlignment ph:placeholder uie:userInteractionEnabled relative:NO];
}

+ (CC_TextField *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled relative:(BOOL)relative{
    CC_TextField *newV=[[CC_TextField alloc]init];
    [view addSubview:newV];
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
    
    if (textColor) {
        newV.textColor=textColor;
    }
    if (backgroundColor) {
        newV.backgroundColor=backgroundColor;
    }
    if (font) {
        newV.font=font;
    }
    if (textAlignment) {
        newV.textAlignment=textAlignment;
    }
    if (placeholder) {
        newV.placeholder=placeholder;
    }
    newV.userInteractionEnabled=userInteractionEnabled;
    return newV;
}

@end
