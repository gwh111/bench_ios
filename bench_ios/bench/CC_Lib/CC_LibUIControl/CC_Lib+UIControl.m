//
//  UIControl+UIControl_CCExtention.m
//  AFNetworking
//
//  Created by gwh on 2019/1/25.
//

#import "CC_Lib+UIControl.h"

typedef NSTimeInterval acceptEventInterval;
typedef NSTimeInterval acceptEventTime;

@implementation UIControl (CC_Lib)

#pragma mark - 防重复
// 因category不能添加属性，只能通过关联对象的方式。
//static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)acceptEventInterval{
    return [[CC_Runtime cc_getObject:self key:@selector(acceptEventInterval)]doubleValue];
//    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    [CC_Runtime cc_setObject:self key:@selector(acceptEventInterval) value:@(acceptEventInterval)];
    
//    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(cs_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)acceptEventTime{
    return [[CC_Runtime cc_getObject:self key:@selector(acceptEventTime)]doubleValue];
//    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime{
    return [CC_Runtime cc_setObject:self key:@selector(acceptEventTime) value:@(acceptEventTime)];
//    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 在load时执行hook
+ (void)load{
    [CC_Runtime cc_exchangeInstance:self.class method:@selector(sendAction:to:forEvent:) withMethod:@selector(cc_sendAction:to:forEvent:)];
//    [CC_Runtime cc_exchange:@selector(sendAction:to:forEvent:) to:@selector(cc_sendAction:to:forEvent:)];
//    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method after    = class_getInstanceMethod(self, @selector(cc_sendAction:to:forEvent:));
//    method_exchangeImplementations(before, after);
}

- (void)cc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    NSArray *touchArr = [event.allTouches allObjects];
    if (touchArr.count > 0) {
        UITouch *touch = touchArr[0];
        UITouchPhase p = touch.phase;
        if (p != UITouchPhaseEnded){
            [self cc_sendAction:action to:target forEvent:event];
            return;
        }
    }
    if (self.acceptEventInterval == 0){
        if ([CC_Base shared].cc_acceptEventInterval>0) {
            self.acceptEventInterval = [CC_Base shared].cc_acceptEventInterval;
        }else{
            self.acceptEventInterval = 0.1;
        }
    }
    if ([NSDate date].timeIntervalSince1970-self.acceptEventTime < self.acceptEventInterval){
        
        if ([self isKindOfClass:[UIButton class]]) {
            //只对button处理
            return;
        }
    }
    if (self.acceptEventInterval > 0) {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self cc_sendAction:action to:target forEvent:event];
}

@end
