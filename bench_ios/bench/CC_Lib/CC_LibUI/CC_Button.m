//
//  AppButton.m
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Button.h"
#import "CC_CoreUI.h"
#import "UIView+CCUI.h"

@interface CC_Button () {
    BOOL _hasBind;
    
@public
    // Tap freezing time
    NSTimeInterval _freezingTime;
    void (^_tappedBlock)(CC_Button *);
    
}

@end

@implementation CC_Button
@synthesize forbiddenEnlargeTapFrame;

#pragma mark private function
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event{
    if (forbiddenEnlargeTapFrame) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect bounds = self.bounds;
    float v = [[CC_CoreUI shared]relativeHeight:44];
    if (self.width >= v && self.height >= v) {
        return [super pointInside:point withEvent:event];
    }else if (self.width >= v && self.height < v){
        bounds = CGRectInset(bounds, 0, -(v - self.height)/2.0);
    }else if (self.width < v && self.height >= v){
        bounds = CGRectInset(bounds,-(v - self.width)/2.0,0);
    }else if (self.width < v && self.height < v){
        bounds = CGRectInset(bounds,-(v-self.width)/2.0,-(v-self.height)/2.0);
    }
    return CGRectContainsPoint(bounds, point);
}

- (void)dealloc{
    if (_hasBind == NO) {
        return;
    }
    
    // unbind text address from object address
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    NSString *bindAddress = [CC_Base.shared cc_shared:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:nil];
    [CC_Base.shared cc_setBind:bindAddress value:nil];
}

@end

@implementation CC_Button (CCActions)

- (void)cc_addTappedOnceDelay:(float)time
                    withBlock:(void (^)(CC_Button *btn))block {
    
    [self cc_addTappedOnceDelay:time withBlock:block forControlEvents:UIControlEventTouchUpInside];
}

- (void)cc_addTappedOnceDelay:(float)time
                    withBlock:(void (^)(CC_Button *btn))block
             forControlEvents:(UIControlEvents)controlEvents {
    
    self->_tappedBlock = block;
    self->_freezingTime = time;
    [self addTarget:self
             action:@selector(_cc_tappedDelayMethod:)
   forControlEvents:controlEvents];
}

- (void)_cc_tappedDelayMethod:(CC_Button *)button{
    !self->_tappedBlock ? : self->_tappedBlock(self);
    self.userInteractionEnabled = NO;
    
    UIImage *disableBgImg = [self backgroundImageForState:UIControlStateDisabled];
    UIImage *normalBgImg = [self backgroundImageForState:UIControlStateNormal];

    if(disableBgImg) {
        self.cc_setBackgroundImageForState(disableBgImg,UIControlStateNormal);
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_freezingTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
        
        if(disableBgImg) {
            self.cc_setBackgroundImageForState(disableBgImg,UIControlStateDisabled);
        }
        
        if (normalBgImg) {
            self.cc_setBackgroundImageForState(normalBgImg,UIControlStateNormal);
        }
    });
}

- (void)bindText:(NSString *)text state:(UIControlState)state{
    _hasBind = YES;
    // bind text address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",text];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    [self setTitle:text forState:state];
}

- (void)bindAttText:(NSAttributedString *)attText state:(UIControlState)state{
    _hasBind = YES;
    // bind attText address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",attText];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    [self setAttributedTitle:attText forState:state];
}

@end
