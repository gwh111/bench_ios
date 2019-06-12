//
//  testDrawV.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testDrawV.h"

@interface testDrawV(){
    int count;
}

@end

@implementation testDrawV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=COLOR_WHITE;
//        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (count>100) {
        count=0;
    }
    
    // 获取当前的图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置绘制的颜色
    [[UIColor brownColor] setStroke];
    
    // 设置线条的宽度
    CGContextSetLineWidth(context, 2.0);
    
    // 设置线条绘制的起始点
    CGContextMoveToPoint(context, 100, 200);
    
    // 添加线条路径
    CGContextAddLineToPoint(context, 100, 300+count);
    
    // 执行绘制路径操作
    CGContextStrokePath(context);
    
    
    count++;
    
}


@end
