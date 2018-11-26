//
//  CC_Label.m
//  bench_ios
//
//  Created by gwh on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Label.h"
#import "CC_Share.h"

@implementation CC_Label

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, _borderWidth);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = _borderColor;
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
    
}

+ (CC_Label *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_Label *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}



+ (CC_Label *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor f:font ta:textAlignment relative:YES];
}

+ (CC_Label *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor f:font ta:textAlignment relative:NO];
}

+ (CC_Label *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment relative:(BOOL)relative{
    CC_Label *newV=[[CC_Label alloc]init];
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
    return newV;
}

+ (CC_Label *)createWithFrame:(CGRect)frame
               andTitleString:(NSString *)titleString
          andAttributedString:(NSAttributedString*)attributedString
                andTitleColor:(UIColor *)color
           andBackGroundColor:(UIColor *)backGroundColor
                      andFont:(UIFont *)font
             andTextAlignment:(NSTextAlignment)textAlignment
                       atView:(UIView *)view{
    CC_Label *label=[[CC_Label alloc]init];
    label.frame=frame;
    if (titleString) {
        label.text=titleString;
    }
    if (attributedString) {
        label.attributedText=attributedString;
    }
    if (color) {
        label.textColor=color;
    }
    if (backGroundColor) {
        label.backgroundColor=backGroundColor;
    }
    if (font) {
        label.font=font;
    }
    if (textAlignment) {
        label.textAlignment=textAlignment;
    }
    [view addSubview:label];
    return label;
}

@end
