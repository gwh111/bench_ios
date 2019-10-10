//
//  UIView+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/2.
//

#import "UIView+CCUI.h"
#import "CC_Foundation.h"
#import "CC_TapGestureRecognizer.h"
#import "CC_ViewController.h"
#import "CC_View.h"

@implementation UIView (CCUI)

// MARK: - Chain -
- (__kindof UIView *(^)(id))cc_addToView {
    return ^(id someObj){
        [someObj cc_addSubview:self];
        return self;
    };
}

- (__kindof UIView *(^)(UIColor *))cc_backgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_cornerRadius {
    return ^(CGFloat cornerRaidus) {
        self.layer.cornerRadius = cornerRaidus;
        self.layer.masksToBounds = YES;
        return self;
    };
}

- (__kindof UIView *(^)(BOOL))cc_userInteractionEnabled {
    return ^(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (__kindof UIView *(^)(UIColor *))cc_borderColor {
    return ^(UIColor *borderColor) {
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_borderWidth {
    return ^(CGFloat borderWidth) {
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (__kindof UIView *(^)(BOOL))cc_hidden {
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_alpha {
    return ^(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}

- (__kindof UIView *(^)(NSString *))cc_name {
    return ^(NSString *name) {
#if DEBUG
        CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
        if ([(UIView *)vc.cc_displayView cc_viewWithName:name]) {
            CCLOGAssert("already has '%@'",name);
        }
#endif
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_tag {
    return ^(CGFloat tag) {
        self.tag = tag;
        return self;
    };
}

- (__kindof UIView *(^)(UIViewContentMode))cc_contentMode {
    return ^(UIViewContentMode mode) {
        self.contentMode = mode;
        return self;
    };
}

- (__kindof UIView *(^)(void))cc_sizeToFit {
    return ^ {
        [self sizeToFit];
        return self;
    };
}

- (__kindof UIView *(^)(BOOL))cc_clipsToBounds {
    return ^ (BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

// MARK: - Frame Extension -
- (NSString *)name {
    return [CC_Runtime cc_getObject:self key:@selector(name)];
}

- (void)setName:(NSString *)name{
    [CC_Runtime cc_setObject:self key:@selector(name) value:name];
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setRight:(CGFloat)newright{
    CGFloat delta = newright - (self.frame.origin.x+self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}

@end

@implementation UIView (CCLayout)

- (__kindof UIView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame {
    return ^(CGFloat x,CGFloat y,CGFloat w,CGFloat h){
        CGRect frame = self.frame;
        frame = CGRectMake(x, y, w, h);
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat w,CGFloat h))cc_size {
    return ^(CGFloat w,CGFloat h) {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(w, h);
        self.frame = frame;
        return self;
    };
}
- (__kindof UIView *(^)(CGFloat))cc_w {
    return ^(CGFloat w) {
        CGRect frame = self.frame;
        frame.size.width = w;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_h {
    return ^(CGFloat h) {
        CGRect frame = self.frame;
        frame.size.height = h;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_top {
    return ^(CGFloat top) {
        CGRect frame = self.frame;
        frame.origin.y = top;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_left {
    return ^(CGFloat left) {
        CGRect frame = self.frame;
        frame.origin.x = left;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat right))cc_right {
    return ^(CGFloat right) {
        CGRect frame = self.frame;
        frame.origin.x = self.superview.frame.size.width + right - frame.size.width;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat bottom))cc_bottom {
    return ^(CGFloat bottom) {
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height + bottom - frame.size.height;
        self.frame = frame;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat,CGFloat))cc_center {
    return ^(CGFloat x,CGFloat y) {
        CGPoint center = self.center;
        center.x = x;
        center.y = y;
        self.center = center;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_centerX {
    return ^(CGFloat x) {
        CGPoint center = self.center;
        center.x = x;
        self.center = center;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cc_centerY {
    return ^(CGFloat y) {
        CGPoint center = self.center;
        center.y = y;
        self.center = center;
        return self;
    };
}

- (__kindof UIView *(^)(void))cc_centerSuper {
    return ^ {
        CGFloat deltaY = (self.superview.frame.size.height - self.frame.size.height) * .5;
        CGFloat deltaX = (self.superview.frame.size.width - self.frame.size.width) * .5;
        self.center = CGPointMake(deltaX + self.frame.size.width * .5, deltaY + self.frame.size.height * .5);
        return self;
    };
}

- (__kindof UIView *(^)(void))cc_centerXSuper {
    return ^ {
        CGFloat deltaX = (self.superview.frame.size.width - self.frame.size.width) * .5;
        self.center = CGPointMake(deltaX + self.frame.size.width * .5, self.center.y);
        return self;
    };
}

- (__kindof UIView *(^)(void))cc_centerYSuper {
    return ^ {
        CGFloat deltaY = (self.superview.frame.size.height - self.frame.size.height) * .5;
        self.center = CGPointMake(self.center.x, deltaY + self.frame.size.height * .5);
        return self;
    };
}

@end

typedef void (^CCAssociatedTapBlock)(UIView *view);

@implementation UIView (CCActions)

- (void)cc_addSubview:(id)view{
    [self addSubview:view];
}

- (void)cc_removeViewWithName:(NSString *)name{
    UIView *view = [self cc_viewWithName:name];
    if (view) {
        [view removeFromSuperview];
    }
}

- (nullable __kindof id)cc_viewWithName:(NSString *)name{
    for (UIView *view in self.subviews) {
        if (view.name) {
            CCLOG(@"%@",view.name);
            if ([view.name isEqualToString:name]) {
                return view;
            }
        }
    }
    for (UIView *view in self.subviews) {
        return [self cc_viewWithName:name inView:view];
    }
    return nil;
}

- (nullable __kindof id)cc_viewWithName:(NSString *)name inView:(UIView *)inView{
    for (UIView *view in inView.subviews) {
        if ([view.name isEqualToString:name]) {
            CCLOG(@"find %@ in subviews",name);
            return view;
        }
        return [self cc_viewWithName:name inView:view];
    }
    return nil;
}

- (nullable __kindof id)cc_viewWithNameOnVC:(NSString *)name{
    CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
    return [vc.cc_displayView cc_viewWithName:name];
}

- (UIViewController *)cc_viewController {
    for (UIView *next = self; next; next=next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (UIViewController *)cc_viewControllerByWindow {
    UIViewController* currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}

- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = opacity;
}

- (void)cc_setShadow:(UIColor *)color{
    [self cc_setShadow:color offset:CGSizeMake(2, 5) opacity:0.5];
}

- (void)cc_setFade:(int)deep{
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    NSMutableArray *mutColors = [[NSMutableArray alloc]init];
    [mutColors cc_addObject:[UIColor colorWithWhite:0 alpha:0]];
    for (int i=0; i<deep; i++) {
        [mutColors cc_addObject:[UIColor colorWithWhite:0 alpha:1]];
    }
    [gradLayer setColors:mutColors];
    // 渐变起止点，point表示向量
    [gradLayer setStartPoint:CGPointMake(0.0f, 1.0f)];
    [gradLayer setEndPoint:CGPointMake(0.0f, 0.0f)];
    [gradLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.layer setMask:gradLayer];
}

- (__kindof UIView *(^)(void (^)(id view)))cc_tapped {
    return ^(void (^block)(id view)){
        self.cc_tappedInterval(0.1,block);
        return self;
    };
}

- (__kindof UIView *(^)(NSTimeInterval,void (^)(__kindof UIView *sender)))cc_tappedInterval {
    return ^(NSTimeInterval interval, void (^block)(__kindof UIView *sender)) {
        [self cc_tappedInterval:interval withBlock:block];
        return self;
    };
}

- (void)cc_tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id))block {
    [self setAssociatedTapBlock:block];
    
    CC_TapGestureRecognizer *tap = [[CC_TapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)];
    tap.interval = interval;
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
}

- (void)tapSelf:(CC_TapGestureRecognizer *)tap {
    self.userInteractionEnabled = NO;
    
    // CC_Thread *tapThread = [self tapThread];
    // if (!tapThread) {
    //   tapThread = [CC_Base cc_init:[CC_Thread class]];
    // }
    // [tapThread cc_delay:tap.interval key:self.name block:^{
    //   self.userInteractionEnabled = YES;
    // }];
    
    [CC_CoreThread.shared cc_delay:tap.interval block:^{
        self.userInteractionEnabled = YES;
    }];
    
    __weak __typeof(&*self)weakSelf = self;
    CCAssociatedTapBlock tapBlock = [self associatedTapBlock];
    if (tapBlock) {
        tapBlock(weakSelf);
    }
}

// MARK: - Associated -
- (void)setAssociatedTapBlock:(CCAssociatedTapBlock)associatedTapBlock{
    [CC_Runtime cc_setObject:self key:@selector(associatedTapBlock) value:associatedTapBlock];
}

- (id)associatedTapBlock{
    return [CC_Runtime cc_getObject:self key:@selector(associatedTapBlock)];
}

// ?
- (void)setAssociatedTapTimeInterval:(NSTimeInterval)timeInterval{
    [CC_Runtime cc_setObject:self key:@selector(timeInterval) value:@(timeInterval)];
}

- (NSTimeInterval)associatedTapTimeInterval{
    return [[CC_Runtime cc_getObject:self key:@selector(associatedTapTimeInterval)] doubleValue];
}

@end
