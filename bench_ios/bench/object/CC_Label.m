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

+ (CC_Label *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment{
    CC_Label *newV=[[CC_Label alloc]init];
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
