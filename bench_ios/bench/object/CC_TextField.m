//
//  CC_TextField.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextField.h"

@implementation CC_TextField

+ (CC_TextField *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled{
    CC_TextField *newV=[[CC_TextField alloc]init];
    [view addSubview:newV];
    newV.left=[ccui getRH:left];
    newV.top=[ccui getRH:top];
    newV.width=[ccui getRH:width];
    newV.height=[ccui getRH:height];
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
