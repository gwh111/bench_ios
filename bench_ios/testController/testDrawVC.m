//
//  testDrawVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testDrawVC.h"
#import "testDrawV.h"
#import "CC_TManager.h"

@interface testDrawVC (){
    int count;
}

@property (nonatomic, assign) CGFloat end;
@property (nonatomic, strong) CAShapeLayer *mylayer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation testDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    testDrawV *t=[[testDrawV alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:t];
//    [[CC_TManager getInstance]registerT:@"draw1" interval:0.05 block:^{
//
//        [t setNeedsDisplay];
//    }];
    
    self.mylayer = ({
        
        //创建圆路径
        UIBezierPath * circleP = [UIBezierPath bezierPath];
        [circleP moveToPoint:CGPointMake(0, 20)];
        [circleP addQuadCurveToPoint:CGPointMake(0, -20) controlPoint:CGPointMake(-20, 0)];
        [circleP addQuadCurveToPoint:CGPointMake(50, 0) controlPoint:CGPointMake(10, -30)];
        [circleP addQuadCurveToPoint:CGPointMake(0, 20) controlPoint:CGPointMake(10, 30)];
        
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.bounds         = CGRectMake(0, 0, 100, 100);
        layer.position       = self.view.center;
        layer.path           = circleP.CGPath;
        layer.strokeColor    = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
//        layer.lineWidth      = 1;
//        layer.strokeStart    = 0;
//        layer.strokeEnd      = 1;
        layer.fillColor      = [UIColor redColor].CGColor;
        layer.fillRule       = kCAFillRuleEvenOdd;
        
        layer.lineJoin = kCALineCapRound;
        layer.lineCap = kCALineCapRound;
        
        layer.anchorPoint=CGPointMake(0, 0);
        
        layer;
    });
    
    [self.view.layer addSublayer:self.mylayer];
    
//    CAKeyframeAnimation
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration=1;
    animation.repeatCount=1;
    animation.beginTime=CACurrentMediaTime() + 1;
    animation.fromValue=[NSNumber numberWithFloat:0.0];
    animation.toValue=[NSNumber numberWithFloat:M_PI];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    [self.mylayer addAnimation:animation forKey:@"rotate-layer"];
    
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeEnd)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    NSLog(@"%ld",(long)self.displayLink.frameInterval);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

- (void)changeEnd {
    count++;
    
    UIBezierPath * circleP = [UIBezierPath bezierPath];
    [circleP moveToPoint:CGPointMake(0, 20)];
    [circleP addQuadCurveToPoint:CGPointMake(0, -20) controlPoint:CGPointMake(-20, 0)];
    if (count<70) {
        
        [circleP addQuadCurveToPoint:CGPointMake(50-count/2, 0) controlPoint:CGPointMake(10, -30)];
        self.mylayer.position = CGPointMake(self.view.center.x-count/2, self.view.center.y);
    }else{
        
        [circleP addQuadCurveToPoint:CGPointMake(50+count, 0) controlPoint:CGPointMake(10, -30)];
        self.mylayer.position = CGPointMake(self.view.center.x+count, self.view.center.y);
    }
    [circleP addQuadCurveToPoint:CGPointMake(0, 20) controlPoint:CGPointMake(10, 30)];
    self.mylayer.path = circleP.CGPath;
    
    if (count>100) {
        count=0;
    }
}



@end
