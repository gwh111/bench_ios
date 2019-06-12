//
//  UIView+UIView_CCCat.m
//  bench_ios
//
//  Created by gwh on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UIView+CCCat.h"
#import <objc/runtime.h>

typedef void(^associatedTapBlock)(UIView *view);

@implementation UIView (CCCat)

static const char *associatedTapBlockKey = "associatedTapBlockKey";
static const char *associatedTapTimeIntervalKey = "associatedTapTimeIntervalKey";

- (NSString *)name{
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociatedTapBlock:(associatedTapBlock)tapBlock{
    objc_setAssociatedObject(self, associatedTapBlockKey, tapBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedTapBlock{
    associatedTapBlock tapBlock  = objc_getAssociatedObject(self, associatedTapBlockKey);
    return tapBlock;
}

- (void)setAssociatedTapTimeInterval:(NSNumber *)timeInterval{
    objc_setAssociatedObject(self, associatedTapTimeIntervalKey, timeInterval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedTapTimeInterval{
    NSNumber *timeInterval  = objc_getAssociatedObject(self, associatedTapTimeIntervalKey);
    return timeInterval;
}

#pragma mark method
- (nullable __kindof UIView *)viewWithName:(NSString *)name{
    for (UIView *view in self.subviews) {
        if ([view.name isEqualToString:name]) {
            return view;
        }
    }
    return nil;
}

- (void)addTapWithTimeInterval:(float)timeInterval tapBlock:(void (^)(UIView *view))tapBlock{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)];
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    [self setAssociatedTapBlock:tapBlock];
    NSNumber *interval = timeInterval>0 ? [NSNumber numberWithFloat:timeInterval] : [NSNumber numberWithFloat:0];
    [self setAssociatedTapTimeInterval:interval];
}

/** tap操作 */
- (void)tapSelf:(UITapGestureRecognizer *)gr{
    __weak __typeof(&*self)weakSelf = self;
    associatedTapBlock tapBlock = [self associatedTapBlock];
    if (tapBlock) {
        tapBlock(weakSelf);
    }
    
    self.userInteractionEnabled = NO;
    float timeInterval = [[self associatedTapTimeInterval] floatValue];
    [self performSelector:@selector(changeEnabled:) withObject:gr afterDelay:timeInterval];
}

/** 改变userInteractionEnabled */
- (void)changeEnabled:(UITapGestureRecognizer *)gr {
    self.userInteractionEnabled = YES;
}

@end
