//
//  UIScrollView+CCCat.m
//  bench_ios
//
//  Created by ml on 2019/6/3.
//  Copyright © 2019 liuyi. All rights reserved.
//

#import "UIScrollView+CCCat.h"
#import "UIResponder+CCCat.h"
#import "CC_UIViewExt.h"
#import "CC_UIHelper.h"
#import <objc/message.h>


@implementation UIScrollView (CC_KdAdapter)

- (void)cc_kdAdapterWithOffset:(CGPoint)offset {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cc_kdAdapterAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cc_kdAdapterAction:) name:UIKeyboardWillHideNotification object:nil];
    self.cc_incrementOffset = offset;
}

- (void)cc_removeKdAdapter {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cc_kdAddNotifications:(NSDictionary *)notifications {
    NSParameterAssert(notifications);
    
    [notifications enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cc_kdAdapterAction:) name:key object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cc_kdAdapterAction:) name:obj object:nil];
    }];
    
    self.cc_extraNotifications = notifications;
}

- (void)cc_kdAdapterAction:(NSNotification *)sender {
    /**
     notification.userInfo {
     UIKeyboardAnimationCurveUserInfoKey = 7;//动画曲线类型
     UIKeyboardAnimationDurationUserInfoKey = "0.25";//动画持续时间
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 226}}";//键盘的bounds
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 849}";//键盘动画起始时的中心点
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 623}";//键盘动画结束时的中心点
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 226}}";//键盘动画起始时的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 510}, {414, 226}}";//键盘动画结束时的frame
     UIKeyboardIsLocalUserInfoKey = 1;//键盘是否显示，bool类型，1 show，2 hide
     }
     */
    if ([self viewController].isViewLoaded && [self viewController].view.window) {
        UIView *currentView = [UIResponder cc_currentFirstResponder];
        
        if (![currentView isDescendantOfView:self]) { return ;}
        
        if ([sender.name isEqualToString:UIKeyboardWillShowNotification]) {
            self.cc_originOffset = self.contentOffset;
            
            NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            CGFloat height = [[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            [self _adjustContentOffset:currentView height:height duration:duration show:YES];
            
        }else if ([sender.name isEqualToString:UIKeyboardWillHideNotification]) {
            
            NSTimeInterval duration = [[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            [self _adjustContentOffset:nil height:0 duration:duration show:NO];
            
        }else {
            __block BOOL isKey = NO;
            __block BOOL isValue = NO;
            __block NSString *name = nil;
            [self.cc_extraNotifications enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isEqualToString:sender.name]) {
                    isKey = YES;
                    name = key;
                }else if ([obj isEqualToString:sender.name]) {
                    isValue = YES;
                    name = obj;
                }
            }];
            
            if (isKey) {
                CGFloat height = [[sender.userInfo objectForKey:CCFrameEndUserInfoKey] CGRectValue].size.height;
                NSTimeInterval duration = [[sender.userInfo objectForKey:CCAnimationDurationUserInfoKey] doubleValue];
                [self _adjustContentOffset:currentView height:height duration:duration show:YES];
            }else if (isValue) {
                NSTimeInterval duration = [[sender.userInfo objectForKey:CCAnimationDurationUserInfoKey] doubleValue];
                [self _adjustContentOffset:nil height:0 duration:duration show:NO];
            }
        }
    }
}

- (void)_adjustContentOffset:(UIView *)responder height:(CGFloat)height duration:(NSTimeInterval)duration show:(BOOL)isShow {
    if (isShow) {
        CGPoint point = [responder.superview convertPoint:CGPointMake(CGRectGetMinX(responder.frame), CGRectGetMaxY(responder.frame))
                                                   toView:self];
        // NSLog(@"%@",NSStringFromCGPoint(point));
        point = [self convertPoint:point toView:[self viewController].view];
        if (self.contentOffset.y > 0) {
            point.y += self.contentOffset.y;
        }else if (self.contentOffset.y < 0) {
            if (@available(iOS 11.0, *)) {
                if (self.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
                    point.y -= ([ccui getSY] + 44);
                }
            }else {
                if ([self viewController].automaticallyAdjustsScrollViewInsets == YES) {
                    point.y -= ([ccui getSY] + 44);
                }
            }
        }
        
        // NSLog(@"%@",NSStringFromCGPoint(point));
        CGFloat offsetY = CC_SCREEN_HEIGHT - height;
        if (point.y > CC_SCREEN_HEIGHT) {
            if ((point.y - CGRectGetHeight(responder.frame)) > CC_SCREEN_HEIGHT) {
                offsetY = point.y - CC_SCREEN_HEIGHT + height;
            }else {
                offsetY = point.y - CC_SCREEN_HEIGHT + height - (CC_SCREEN_HEIGHT - (point.y - CGRectGetHeight(responder.frame)));
            }
        }
        
        if (point.y > offsetY) {
            if (CGRectGetMaxY(self.frame) > (CC_SCREEN_HEIGHT - height)) {
                [UIView animateWithDuration:duration animations:^{
                    CGPoint offset = self.cc_incrementOffset;
                    if (point.y > CC_SCREEN_HEIGHT) {
                        [self setContentOffset:CGPointMake(offset.x, offsetY + offset.y)
                                      animated:YES];
                    }else {
                        [self setContentOffset:CGPointMake(offset.x, point.y - offsetY + offset.y)
                                      animated:YES];
                    }
                }];
            }
        }
    }else {
        if (self.keyboardDismissMode == UIScrollViewKeyboardDismissModeNone) {
            
            [UIView animateWithDuration:duration animations:^{
                CGPoint offset = CGPointEqualToPoint(self.cc_originOffset,CGPointZero) == NO ? self.cc_originOffset : CGPointZero;
                self.contentOffset = offset;
            }];
        }
    }
}

- (void)setCc_incrementOffset:(CGPoint)offset {
    objc_setAssociatedObject(self, @selector(cc_incrementOffset), [NSValue valueWithCGPoint:offset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)cc_incrementOffset {
    return [objc_getAssociatedObject(self, @selector(cc_incrementOffset)) CGPointValue];
}

- (void)setCc_originOffset:(CGPoint)offset {
    objc_setAssociatedObject(self, @selector(cc_originOffset), [NSValue valueWithCGPoint:offset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)cc_originOffset {
    return [objc_getAssociatedObject(self, @selector(cc_originOffset)) CGPointValue];
}

- (void)setCc_extraNotifications:(NSDictionary *)notificatins {
    objc_setAssociatedObject(self, @selector(cc_extraNotifications), notificatins, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)cc_extraNotifications {
    return objc_getAssociatedObject(self, @selector(cc_extraNotifications));
}

@end

NSString const *CCFrameEndUserInfoKey = @"CCFrameEndUserInfoKey";
NSString const *CCAnimationDurationUserInfoKey = @"CCAnimationDurationUserInfoKey";
