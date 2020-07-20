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
#import <objc/runtime.h>
#import "CC_CoreCrash.h"

@implementation UIView (CCUI)

// 这里不使用动态方法添加，
// 因为UIWindow等一些类会使用动态方法添加和动态对象指定，所以在最后方法签名进行异常处理
// 不使用对象转移，这样会丢失对象，只能从堆栈中去找，麻烦
+ (id)unknowMethod:(NSString *)method className:(NSString *)className {
    
    // 在加入Exceptions后断言
    // 收集问题，debug下断言，release时记录
    [CC_CoreCrash.shared methodNotExist:method className:className];
    
    CCLOG(@"error: unknow method called");
    // 返回nil防止外部持续调用崩溃
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];//签名，进入forwardInvocation
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];//签名，进入forwardInvocation
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    id method = NSStringFromSelector(anInvocation.selector);
    NSString *class = NSStringFromClass(object_getClass(self));
    SEL unknow = NSSelectorFromString(@"unknowMethod:className:");
    anInvocation.selector = unknow;
    [anInvocation setArgument:&method atIndex:2];
    [anInvocation setArgument:&class atIndex:3];
    [anInvocation invokeWithTarget:self.class];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id method = NSStringFromSelector(anInvocation.selector);
    NSString *class = NSStringFromClass(object_getClass(self));
    SEL unknow = NSSelectorFromString(@"unknowMethod:className:");
    anInvocation.selector = unknow;
    [anInvocation setArgument:&method atIndex:2];
    [anInvocation setArgument:&class atIndex:3];
    [anInvocation invokeWithTarget:self.class];
}

// MARK: - Chain -
- (UIView *(^)(id))cc_addToView {
    return ^(id someObj){ [someObj cc_addSubview:self]; return self; };
}

- (UIView *(^)(UIColor *))cc_backgroundColor {
    return ^(UIColor *_) { self.backgroundColor = _; return self; };
}

- (UIView *(^)(CGFloat))cc_cornerRadius {
    return ^(CGFloat _) { self.layer.cornerRadius = _; self.layer.masksToBounds = YES; return self; };
}

- (UIView *(^)(BOOL))cc_masksToBounds {
    return ^(BOOL _) { self.layer.masksToBounds = _; return self; };
}

- (UIView *(^)(BOOL))cc_userInteractionEnabled {
    return ^(BOOL _) { self.userInteractionEnabled = _; return self; };
}

- (UIView *(^)(UIColor *))cc_borderColor {
    return ^(UIColor *_) { self.layer.borderColor = _.CGColor; return self; };
}

- (UIView *(^)(CGFloat))cc_borderWidth {
    return ^(CGFloat _) { self.layer.borderWidth = _; return self; };
}

- (UIView *(^)(BOOL))cc_hidden {
    return ^(BOOL _) { self.hidden = _; return self; };
}

- (UIView *(^)(CGFloat))cc_alpha {
    return ^(CGFloat _) { self.alpha = _; return self; };
}

- (UIView *(^)(NSString *))cc_name {
    return ^(NSString *name) {
#if DEBUG
        CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
        if ([(UIView *)vc.cc_displayView cc_viewWithName:name]) {
            CCLOGAssert("already has '%@'",name);
        }
#endif
        self.name = name;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_tag {
    return ^(CGFloat _) { self.tag = _; return self; };
}

- (UIView *(^)(UIViewContentMode))cc_contentMode {
    return ^(UIViewContentMode _) { self.contentMode = _; return self; };
}

- (UIView *(^)(void))cc_sizeToFit {
    return ^ { [self sizeToFit]; return self; };
}

- (UIView *(^)(BOOL))cc_clipsToBounds {
    return ^ (BOOL _) { self.clipsToBounds = _; return self; };
}

@end

@implementation UIView (CCLayout)

- (UIView *(^)(CGFloat x,CGFloat y,CGFloat w,CGFloat h))cc_frame {
    return ^(CGFloat x,CGFloat y,CGFloat w,CGFloat h){
        CGRect _ = self.frame; _ = CGRectMake(x, y, w, h); self.frame = _;
        return self;
    };
}

- (UIView *(^)(CGFloat w,CGFloat h))cc_size {
    return ^(CGFloat w,CGFloat h) {
        CGRect _ = self.frame; _.size = CGSizeMake(w, h); self.frame = _;
        return self;
    };
}
- (UIView *(^)(CGFloat))cc_w {
    return ^(CGFloat w) {
        CGRect _ = self.frame; _.size.width = w; self.frame = _;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_h {
    return ^(CGFloat h) {
        CGRect _ = self.frame; _.size.height = h; self.frame = _;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_top {
    return ^(CGFloat top) {
        CGRect _ = self.frame; _.origin.y = top; self.frame = _;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_left {
    return ^(CGFloat left) {
        CGRect _ = self.frame; _.origin.x = left; self.frame = _;
        return self;
    };
}

- (UIView *(^)(CGFloat right))cc_right {
    return ^(CGFloat right) {
        CGRect frame = self.frame;
        frame.origin.x = self.superview.frame.size.width + right - frame.size.width;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat bottom))cc_bottom {
    return ^(CGFloat bottom) {
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height + bottom - frame.size.height;
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))cc_center {
    return ^(CGFloat x,CGFloat y) {
        CGPoint _ = self.center; _.x = x; _.y = y; self.center = _;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_centerX {
    return ^(CGFloat x) { CGPoint _ = self.center; _.x = x; self.center = _; return self; };
}

- (UIView *(^)(CGFloat))cc_centerY {
    return ^(CGFloat y) { CGPoint _ = self.center; _.y = y; self.center = _; return self; };
}

- (UIView *(^)(void))cc_centerSuper {
    return ^ {
        CGFloat deltaY = (self.superview.frame.size.height - self.frame.size.height) * .5;
        CGFloat deltaX = (self.superview.frame.size.width - self.frame.size.width) * .5;
        self.center = CGPointMake(deltaX + self.frame.size.width * .5, deltaY + self.frame.size.height * .5);
        return self;
    };
}

- (UIView *(^)(void))cc_centerXSuper {
    return ^ {
        CGFloat deltaX = (self.superview.frame.size.width - self.frame.size.width) * .5;
        self.center = CGPointMake(deltaX + self.frame.size.width * .5, self.center.y);
        return self;
    };
}

- (UIView *(^)(void))cc_centerYSuper {
    return ^ {
        CGFloat deltaY = (self.superview.frame.size.height - self.frame.size.height) * .5;
        self.center = CGPointMake(self.center.x, deltaY + self.frame.size.height * .5);
        return self;
    };
}

@end

typedef void (^CCAssociatedTapBlock)(UIView *view);

@implementation UIView (CCActions)

- (void)cc_addSubview:(id)view {
    [self addSubview:view];
}

- (void)cc_removeViewWithName:(NSString *)name {
    UIView *view = [self cc_viewWithName:name];
    if (view) {
        [view removeFromSuperview];
    }
}

- (nullable __kindof id)cc_viewWithName:(NSString *)name {
    for (UIView *view in self.subviews) {
        if (view.name) {
//            CCLOG(@"%@",view.name);
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

- (nullable __kindof id)cc_viewWithNameOnVC:(NSString *)name {
    CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
    return [vc.cc_displayView cc_viewWithName:name];
}

- (UIViewController *)cc_viewController {
    for (UIView *next = self; next; next=next.superview) {
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

- (void)cc_addCornerRadius:(CGFloat)radius {
    [self cc_addCornerRadius:radius borderWidth:1 borderColor:[UIColor clearColor] backgroundColor:[UIColor clearColor]];
}

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)bgColor {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self cc_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:bgColor drawTopLeft:YES drawTopRight:YES drawBottomLeft:YES drawBottomRight:YES]];
    [self insertSubview:imageView atIndex:0];
}

- (void)cc_addCornerRadius:(CGFloat)radius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           backgroundColor:(UIColor *)bgColor
               drawTopLeft:(BOOL)topLeft
              drawTopRight:(BOOL)topRight
            drawBottomLeft:(BOOL)bottomLeft
           drawBottomRight:(BOOL)bottomRight {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[self cc_drawRectWithRoundedCorner:radius borderWidth:borderWidth borderColor:borderColor backgroundColor:bgColor drawTopLeft:topLeft drawTopRight:topRight drawBottomLeft:bottomLeft drawBottomRight:bottomRight]];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)cc_drawRectWithRoundedCorner:(CGFloat)radius
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(UIColor *)borderColor
                          backgroundColor:(UIColor *)bgColor
                              drawTopLeft:(BOOL)topLeft
                             drawTopRight:(BOOL)topRight
                           drawBottomLeft:(BOOL)bottomLeft
                          drawBottomRight:(BOOL)bottomRight {
    
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(contextRef, borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, borderColor.CGColor);
    CGContextSetFillColorWithColor(contextRef, bgColor.CGColor);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if (topRight) {
        CGContextMoveToPoint(contextRef, width - halfBorderWidth, radius + halfBorderWidth);
    } else {
        CGContextMoveToPoint(contextRef, width - halfBorderWidth, 0);
    }
    if (bottomRight) {
        CGContextAddArcToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    } else {
        CGContextAddLineToPoint(contextRef, width - halfBorderWidth, height - halfBorderWidth);
    }
    if (bottomLeft) {
        CGContextAddArcToPoint(contextRef, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    } else {
        CGContextAddLineToPoint(contextRef, halfBorderWidth, height - halfBorderWidth);
    }
    if (topLeft) {
        CGContextAddArcToPoint(contextRef, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    } else {
        CGContextAddLineToPoint(contextRef, halfBorderWidth, halfBorderWidth);
    }
    if (topRight) {
        CGContextAddArcToPoint(contextRef, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    } else {
        CGContextAddLineToPoint(contextRef, width - halfBorderWidth, halfBorderWidth);
    }
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 添加shadowpath避免离屏渲染
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
//    byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    return image;
}

- (void)cc_setShadow:(UIColor *)color offset:(CGSize)size opacity:(float)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = opacity;
    
    CGRect rect = self.frame;
    
    UIView *superV = [[UIView alloc]initWithFrame:rect];
    superV.layer.shadowColor = color.CGColor;
    superV.layer.shadowOffset = size;
    superV.layer.shadowOpacity = opacity;
    
    UIView *currentSuperV = self.superview;
    [self removeFromSuperview];
    self.frame = self.bounds;
    [currentSuperV addSubview:superV];
    [superV addSubview:self];
}

- (void)cc_setShadow:(UIColor *)color {
    [self cc_setShadow:color offset:CGSizeMake(2, 5) opacity:0.5];
}

- (void)cc_setFade:(int)deep {
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

- (void)tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id))block {
    [self cc_tappedInterval:interval withBlock:block];
}

- (nullable __kindof UIView *)cc_tappedInterval:(NSTimeInterval)interval withBlock:(void (^)(id))block {
    [self setAssociatedTapBlock:block];
    
    CC_TapGestureRecognizer *tap = [[CC_TapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)];
    tap.interval = interval;
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    
    return self;
}

- (void)tapSelf:(CC_TapGestureRecognizer *)tap {
    self.userInteractionEnabled = NO;
    
    [CC_Thread.shared delay:tap.interval block:^{
        self.userInteractionEnabled = YES;
    }];
    
    __weak __typeof(&*self)weakSelf = self;
    CCAssociatedTapBlock tapBlock = [self associatedTapBlock];
    if (tapBlock) {
        tapBlock(weakSelf);
    }
}

// MARK: - Associated -
- (void)setAssociatedTapBlock:(CCAssociatedTapBlock)associatedTapBlock {
    [CC_Runtime cc_setObject:self key:@selector(associatedTapBlock) value:associatedTapBlock];
}

- (id)associatedTapBlock {
    return [CC_Runtime cc_getObject:self key:@selector(associatedTapBlock)];
}

// ?
- (void)setAssociatedTapTimeInterval:(NSTimeInterval)timeInterval {
    [CC_Runtime cc_setObject:self key:@selector(timeInterval) value:@(timeInterval)];
}

- (NSTimeInterval)associatedTapTimeInterval {
    return [[CC_Runtime cc_getObject:self key:@selector(associatedTapTimeInterval)] doubleValue];
}

@end


@implementation UIView (CCGetter)

- (NSString *)name {
    return [CC_Runtime cc_getObject:self key:@selector(name)];
}

- (void)setName:(NSString *)name {
    [CC_Runtime cc_setObject:self key:@selector(name) value:name];
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth {
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y+self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right {
    return self.frame.origin.x+self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x+self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta;
    self.frame = newframe;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}


@end
