//
//  CC_Animation.m
//  bench_ios
//
//  Created by gwh on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Animation.h"

@implementation CC_Animation

#pragma mark === 永久闪烁的动画 ======
+ (CABasicAnimation *)cc_flickerForever:(float)time{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

+ (void)cc_buttonTapEnlarge:(CC_Button *)button{
    button.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
        float speed=1/5.0;
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:speed animations: ^{
            
            button.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:speed relativeDuration:speed animations: ^{
            
            button.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:speed*2 relativeDuration:speed animations: ^{
            
            button.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

@end
