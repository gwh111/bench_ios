//
//  CC_TextView.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextView.h"
#import "CC_Share.h"

@implementation CC_TextView

+ (CC_TextView *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_TextView *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}

- (float)heightForWidth:(float)width{
    CGSize sizeToFit = [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

- (float)widthForHeight:(float)height{
    CGSize sizeToFit = [self sizeThatFits:CGSizeMake(MAXFLOAT, height)];
    return sizeToFit.width;
}


+ (CC_TextView *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor f:font ta:textAlignment sb:selectable eb:editable uie:userInteractionEnabled relative:YES];
}

+ (CC_TextView *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor f:font ta:textAlignment sb:selectable eb:editable uie:userInteractionEnabled relative:NO];
}

+ (CC_TextView *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled relative:(BOOL)relative{
    CC_TextView *newV=[[CC_TextView alloc]init];
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
