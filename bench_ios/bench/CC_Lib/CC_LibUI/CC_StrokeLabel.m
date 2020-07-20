//
//  CC_StrokeLabel.m
//  JHStories
//
//  Created by gwh on 2020/5/4.
//  Copyright © 2020 gwh. All rights reserved.
//

#import "CC_StrokeLabel.h"

@implementation CC_StrokeLabel

+ (CC_StrokeLabel *)label {
    CC_StrokeLabel *label = [CC_StrokeLabel new];
    label.frame = CGRectMake(160, 70, 150, 100);
    label.text = @"Hello";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:50];
    //描边
    label.strokeColor = [UIColor orangeColor];
    label.strokeWidth = 1;
    //发光
    label.layer.shadowRadius = 2;
    label.layer.shadowColor = [UIColor redColor].CGColor;
    label.layer.shadowOffset = CGSizeMake(0, 0);
    label.layer.shadowOpacity = 1.0;
    return label;
}

- (void)drawTextInRect:(CGRect)rect {
    if (self.strokeWidth > 0) {
        CGSize shadowOffset = self.shadowOffset;
        UIColor *textColor = self.textColor;
    
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(c, self.strokeWidth);
        CGContextSetLineJoin(c, kCGLineJoinRound);
        //画外边
        CGContextSetTextDrawingMode(c, kCGTextStroke);
        self.textColor = self.strokeColor;
        [super drawTextInRect:rect];
        //画内文字
        CGContextSetTextDrawingMode(c, kCGTextFill);
        self.textColor = textColor;
        self.shadowOffset = CGSizeMake(0, 0);
        [super drawTextInRect:rect];
        self.shadowOffset = shadowOffset;
    } else {
        [super drawTextInRect:rect];
    }
}

@end
