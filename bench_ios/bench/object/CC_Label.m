//
//  CC_Label.m
//  bench_ios
//
//  Created by gwh on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Label.h"

@implementation CC_Label

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
