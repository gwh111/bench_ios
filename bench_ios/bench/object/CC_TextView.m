//
//  CC_TextView.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextView.h"

@implementation CC_TextView

+ (CC_TextView *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled{
    CC_TextView *newV=[[CC_TextView alloc]init];
    [view addSubview:newV];
    newV.left=[ccui getRH:left];
    newV.top=[ccui getRH:top];
    newV.width=[ccui getRH:width];
    newV.height=[ccui getRH:height];
    if (titleStr) {
        newV.text=titleStr;
    }
    if (attributedStr) {
        newV.attributedText=attributedStr;
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
    newV.selectable=selectable;
    newV.editable=editable;
    newV.userInteractionEnabled=userInteractionEnabled;
    return newV;
}

@end
