//
//  UIViewController+CCUIHelper.m
//  bench_ios
//
//  Created by gwh on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+CCUIHelper.h"
#import "CC_Share.h"

@implementation UIViewController(CCUIHelper)

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
//    UITouch *touch = [[event allTouches] anyObject];
//    UIView *v=touch.view;
//    for (id object in [v subviews]) {
//        if ([object isKindOfClass:[UIView class]]) {
//            UIView *obj = (UIView *)object;
//            [CC_CodeClass setLineColorR:0 andG:0 andB:0 andA:1 width:1 view:obj];
//        }
//    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([CC_Share shareInstance].ccDebug==0) {
        return;
    }
    UITouch *touch = [[event allTouches] anyObject];
    UIView *v=touch.view;
    [v setUserInteractionEnabled:YES];
    
    CGPoint p = [touch locationInView:v];
    BOOL my=1;
    for (id object in [v subviews]) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *obj = (UIView *)object;
            UIView *superobj=obj.superview;
            if ([superobj isKindOfClass:[UITextView class]]||
                [superobj isKindOfClass:[UITextField class]]||
                [superobj isKindOfClass:[UIButton class]]) {
                [CC_CodeClass setLineColorR:0 andG:0 andB:0 andA:1 width:1 view:superobj];
                if (CGRectContainsPoint(obj.frame, p)){
                    CCLOG(@"cont");
                    my=0;
                    [self loadTarget:superobj];
                }else{
                }
                return;
            }
            [CC_CodeClass setLineColorR:0 andG:0 andB:0 andA:1 width:1 view:obj];
            if (CGRectContainsPoint(obj.frame, p)){
                my=0;
                [self loadTarget:obj];
            }else{
            }
        }
    }
    if ([v subviews].count==0||my==1) {
        [self loadTarget:v];
    }
    
}

- (void)loadTarget:(UIView *)v{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAct:)];
    [v setUserInteractionEnabled:YES];
    [v addGestureRecognizer:gesture];
    [CC_CodeClass setLineColorR:1 andG:0 andB:0 andA:1 width:2 view:v];
    [CC_UIHelper getInstance].lastV=v;
    double delayInSeconds = 0.9;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [CC_CodeClass setLineColorR:0 andG:0 andB:0 andA:1 width:1 view:v];
    });

}

- (void)gestureAct:(UIPanGestureRecognizer *)gesture{
    
    UIView *gestureV=gesture.view;
    [CC_UIHelper getInstance].lastV=gestureV;
    
    UIView *gestureV_superV=gesture.view.superview;
    CGPoint point = [gesture translationInView:gestureV_superV];
    
    float x=gestureV.center.x + point.x;
    float y=gestureV.center.y + point.y;
    if (x<gestureV.width/2) {
        x=gestureV.width/2;
    }else if (x>gestureV_superV.width-gestureV.width/2){
        x=gestureV_superV.width-gestureV.width/2;
    }
    if (y<gestureV.height/2) {
        y=gestureV.height/2;
    }else if (y>gestureV_superV.height-gestureV.height/2){
        y=gestureV_superV.height-gestureV.height/2;
    }
    gestureV.center = CGPointMake(x, y);
    [gesture setTranslation:CGPointMake(0, 0) inView:gestureV_superV];
}

@end
