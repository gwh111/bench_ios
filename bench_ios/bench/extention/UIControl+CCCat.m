//
//  UIControl+UIControl_CCExtention.m
//  AFNetworking
//
//  Created by gwh on 2019/1/25.
//

#import "UIControl+CCCat.h"
#import <objc/runtime.h>
#import "CC_Share.h"

@implementation UIControl (CCCat)

#pragma mark - 防重复
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)cs_acceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setCs_acceptEventInterval:(NSTimeInterval)cs_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    NSArray *touchArr=[event.allTouches allObjects];
    if (touchArr.count>0) {
        UITouch *touch=touchArr[0];
        int p=touch.phase;
        if (p!=UITouchPhaseEnded) {
            [self cs_sendAction:action to:target forEvent:event];
            return;
        }
    }
    
    if (self.cs_acceptEventInterval==0) {
        if ([CC_Share getInstance].acceptEventInterval>0) {
            self.cs_acceptEventInterval=[CC_Share getInstance].acceptEventInterval;
        }else{
            self.cs_acceptEventInterval=0.5;
        }
    }
    if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.cs_acceptEventInterval) {
        
        if ([self isKindOfClass:[UIButton class]]) {
            //只对button处理
            return;
        }
    }
    
    if (self.cs_acceptEventInterval > 0) {
        self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    
    [self cs_sendAction:action to:target forEvent:event];
}

@end
