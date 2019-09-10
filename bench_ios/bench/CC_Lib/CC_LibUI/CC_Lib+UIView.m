//
//  UIView+CC.m
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Lib+UIView.h"
//#import <objc/runtime.h>

typedef void(^associatedTapBlock)(UIView *view);
typedef CC_Label *badgeLabel;
//typedef CC_ThreadCore *tapThread;
//
//static const char *associatedTapBlockKey="associatedTapBlockKey";
//static const char *associatedTapTimeIntervalKey="associatedTapTimeIntervalKey";

@implementation UIView (CC_Lib)

#pragma mark property
- (NSString *)name{
    return [CC_Runtime cc_getObject:self key:@selector(name)];
//    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name{
    [CC_Runtime cc_setObject:self key:@selector(name) value:name];
//    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociatedTapBlock:(associatedTapBlock)associatedTapBlock{
    [CC_Runtime cc_setObject:self key:@selector(associatedTapBlock) value:associatedTapBlock];
//    objc_setAssociatedObject(self, associatedTapBlockKey, tapBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedTapBlock{
    return [CC_Runtime cc_getObject:self key:@selector(associatedTapBlock)];
//    associatedTapBlock tapBlock=objc_getAssociatedObject(self, associatedTapBlockKey);
//    return tapBlock;
}

- (void)setAssociatedTapTimeInterval:(NSTimeInterval)timeInterval{
    [CC_Runtime cc_setObject:self key:@selector(timeInterval) value:@(timeInterval)];
//    objc_setAssociatedObject(self, associatedTapTimeIntervalKey, timeInterval, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)associatedTapTimeInterval{
    return [[CC_Runtime cc_getObject:self key:@selector(associatedTapTimeInterval)]doubleValue];
//    NSNumber *timeInterval=objc_getAssociatedObject(self, associatedTapTimeIntervalKey);
//    return timeInterval;
}

- (CC_Label *)badgeLabel{
    return [CC_Runtime cc_getObject:self key:@selector(badgeLabel)];
}

- (void)setBadgeLabel:(CC_Label *)badgeLabel{
    [CC_Runtime cc_setObject:self key:@selector(badgeLabel) value:badgeLabel];
}

//- (CC_ThreadCore *)tapThread{
//    return [CC_Runtime cc_getObject:self key:@selector(tapThread)];
//}
//
//- (void)setTapThread:(CC_ThreadCore *)tapThread{
//    [CC_Runtime cc_setObject:self key:@selector(tapThread) value:tapThread];
//}

#pragma mark function
- (void)cc_addSubview:(id)view{
    [self addSubview:view];
}

- (void)cc_removeViewWithName:(NSString *)name{
    UIView *view = [self cc_viewWithName:name];
    if (view) {
        [view removeFromSuperview];
    }
}

- (nullable __kindof id)viewWithName:(NSString *)name inView:(UIView *)inView{
    for (UIView *view in inView.subviews) {
        if ([view.name isEqualToString:name]) {
            CCLOG(@"find %@ in subviews",name);
            return view;
        }
        return [self viewWithName:name inView:view];
    }
    return nil;
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
        return [self viewWithName:name inView:view];
    }
    return nil;
}

- (nullable __kindof id)cc_viewWithNameOnVC:(NSString *)name{
    CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
    return [vc.cc_baseView cc_viewWithName:name];
}

- (void)cc_tappedInterval:(float)interval block:(void (^)(id view))block{
    [self setAssociatedTapBlock:block];
    
    CC_TapGestureRecognizer *tap = [[CC_TapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf:)];
    tap.interval = interval;
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
}

- (void)cc_updateBadge:(NSString *)badge{
    [self checkBadgeLabel];
    
    CGSize size = [self caculateBadgeWidth:badge];
    self.badgeLabel.frame = CGRectMake(self.width-size.width/2.0, -size.height/2.0, size.width, size.height);
    self.badgeLabel.text = badge;
    self.badgeLabel.layer.cornerRadius = size.height/2.0;
    self.badgeLabel.layer.masksToBounds = YES;
}

- (void)cc_updateBadgeBackgroundColor:(UIColor *)backgroundColor{
    [self checkBadgeLabel];
    self.badgeLabel.backgroundColor = backgroundColor;
}

- (void)cc_updateBadgeTextColor:(UIColor*)textColor{
    [self checkBadgeLabel];
    self.badgeLabel.textColor = textColor;
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
    //渐变起止点，point表示向量
    [gradLayer setStartPoint:CGPointMake(0.0f, 1.0f)];
    [gradLayer setEndPoint:CGPointMake(0.0f, 0.0f)];
    [gradLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.layer setMask:gradLayer];
}

- (UIViewController *)cc_viewController{
    for (UIView *next=[self superview]; next; next=next.superview){
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIWindow *)cc_lastWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            window.hidden = NO;
        return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

//- (void)cc_stopTap{
//    CC_Thread *tapThread = [self tapThread];
//    [tapThread cc_delayStop:self.name];
//}

#pragma mark private function
- (void)tapSelf:(CC_TapGestureRecognizer *)tap {
    self.userInteractionEnabled = NO;
//    CC_Thread *tapThread = [self tapThread];
//    if (!tapThread) {
//        tapThread = [CC_Base cc_init:[CC_Thread class]];
//    }
//    [tapThread cc_delay:tap.interval key:self.name block:^{
//        self.userInteractionEnabled = YES;
//    }];
    
    [CC_CoreThread.shared cc_delay:tap.interval block:^{
        self.userInteractionEnabled = YES;
    }];
    
    __weak __typeof(&*self)weakSelf = self;
    associatedTapBlock tapBlock = [self associatedTapBlock];
    if (tapBlock) {
        tapBlock(weakSelf);
    }
}

- (void)checkBadgeLabel {
    if (!self.badgeLabel) {
        self.badgeLabel = [[CC_Label alloc]init];
        {typeof (self.badgeLabel) item = self.badgeLabel;
            item.cc_font([[CC_CoreUI shared]relativeFont:11])
                .cc_textAlignment(NSTextAlignmentCenter)
                .cc_backgroundColor([UIColor cc_rgbA:255 green:89 blue:59 alpha:1])
                .cc_addToView(self);
        }
    }
}

- (CGSize)caculateBadgeWidth:(NSString*)badge {
    if (badge.length <= 0) {
        return CGSizeZero;
    }else{
        CGSize size = [badge boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[CC_CoreUI shared]relativeFont:11]} context:nil].size;
        size.height = [[CC_CoreUI shared]relativeHeight:14];
        size.width += [[CC_CoreUI shared]relativeHeight:8];
        return size;
    }
}

#pragma mark clase "UIView" property extention
- (UIView *(^)(CGFloat,CGFloat,CGFloat,CGFloat))cc_frame_id {
    return ^(CGFloat x,CGFloat y,CGFloat w,CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))cc_size_id {
    return ^(CGFloat w,CGFloat h){
        self.size = CGSizeMake(w, h);
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_width_id {
    return ^(CGFloat w){
        self.width = w;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_height_id {
    return ^(CGFloat h){
        self.height = h;
        return self;
    };
}

- (UIView *(^)(CGFloat,CGFloat))cc_center_id {
    return ^(CGFloat x,CGFloat y){
        self.center = CGPointMake(x, y);
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_centerX_id {
    return ^(CGFloat x){
        self.centerX = x;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_centerY_id {
    return ^(CGFloat y){
        self.centerY = y;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_top_id {
    return ^(CGFloat top){
        self.top = top;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_bottom_id {
    return ^(CGFloat bottom){
        self.bottom = bottom;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_left_id {
    return ^(CGFloat left){
        self.left = left;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_right_id {
    return ^(CGFloat right){
        self.right = right;
        return self;
    };
}

- (UIView *(^)(UIColor *))cc_backgroundColor_id {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(NSString *))cc_name_id{
    return ^(NSString *name) {
#if DEBUG
        CC_ViewController *vc = (CC_ViewController *)[self cc_viewController];
        if ([vc.cc_baseView cc_viewWithName:name]) {
            CCLOGAssert("already has '%@'",name);
        }
#endif
        self.name=name;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_cornerRadius_id {
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        return self;
    };
}

- (UIView *(^)(CGFloat))cc_borderWidth_id {
    return ^(CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

- (UIView *(^)(UIColor *))cc_borderColor_id {
    return ^(UIColor *borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}

- (UIView *(^)(BOOL))cc_userInteractionEnabled_id {
    return ^(BOOL userInteractionEnabled){
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UIView *(^)(id))cc_addToView_id {
    return ^(id view){
        [view cc_addSubview:self];
        return self;
    };
}

- (UIView *(^)(void (^)(id view)))cc_tapped {
    return ^(void (^block)(id view)){
        [self cc_tappedInterval:0.1 block:block];
        return self;
    };
}

- (UIView *(^)(float interval, void (^)(id view)))cc_tappedInterval {
    return ^(float interval, void (^block)(id view)){
        [self cc_tappedInterval:interval block:block];
        return self;
    };
}

#pragma mark frame property
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
