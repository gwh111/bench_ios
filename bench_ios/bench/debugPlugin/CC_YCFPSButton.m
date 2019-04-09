//
//  YCFPSButton.m
//  bench_ios
//
//  Created by admin on 2019/4/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_YCFPSButton.h"

@implementation YCFPSButton
#define SelfWidth  [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
    
}

- (void)initView {
    
    self.frame = CGRectMake(0, 100, 80, 30);
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.7;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //添加拖拽手势-改变控件的位置
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
    [self addGestureRecognizer:pan];
    
    __weak typeof(self) weakSelf = self;
    _link = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)tick:(CADisplayLink *)link {
    
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count ++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) {
        return;
    }
    _lastTime = link.timestamp;
    float fps = _count/delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [attText addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attText.length - 3)];
    [attText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(attText.length - 3, 3)];
    
    [attText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(0, attText.length - 3)];
    [attText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(attText.length - 3, 3)];
    
    [self setAttributedTitle:attText forState:UIControlStateNormal];
    
}

- (void)changePostion:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:self];
    CGRect originalFrame = self.frame;
    
    originalFrame = [self changeXWithFrame:originalFrame point:point];
    originalFrame = [self changeYWithFrame:originalFrame point:point];
    
    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    
    UIButton *button = (UIButton *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan) {
        button.enabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
    } else {
        
        CGRect frame = self.frame;
        
        if (self.center.x <= SelfWidth / 2.0){
            frame.origin.x = 0;
        }else
        {
            frame.origin.x = SelfWidth - frame.size.width;
        }
        
        if (frame.origin.y < 20) {
            frame.origin.y = 20;
        } else if (frame.origin.y + frame.size.height > SelfHeight) {
            frame.origin.y = SelfHeight - frame.size.height;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = frame;
        }];
        
        button.enabled = YES;
        
    }
}

//拖动改变控件的水平方向x值
- (CGRect)changeXWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    
    BOOL q1 = originalFrame.origin.x >= 0;
    BOOL q2 = originalFrame.origin.x + originalFrame.size.width <= SelfWidth;
    if (q1 && q2) {
        originalFrame.origin.x += point.x;
    }
    return originalFrame;
    
}

//拖动改变控件的竖直方向y值
- (CGRect)changeYWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    
    BOOL q1 = originalFrame.origin.y >= 20;
    BOOL q2 = originalFrame.origin.y + originalFrame.size.height <= SelfHeight;
    if (q1 && q2) {
        originalFrame.origin.y += point.y;
    }
    return originalFrame;
    
}

@end
