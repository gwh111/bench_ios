//
//  UIView+CCWebImage.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "UIView+CCWebImage.h"
#import "objc/runtime.h"

static const char  user_defined_base_show_progress_view_key;
static const char  user_defined_base_progress_view_key;

#define SAFE_CALL_BLOCK(blockFunc, ...)    \
if (blockFunc) {                        \
blockFunc(__VA_ARGS__);              \
}

static char kCC_WebImageOperation;
typedef NSMutableDictionary<NSString *, id<CC_WebImageOperationDelegate>> CC_WebImageOperationDictionay;

@implementation CC_WebImgProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ccRGBA(33, 33, 33, 1);
        self.layer.cornerRadius = RH(12.0f);
        self.layer.borderColor = ccRGBA(255, 255, 255, 0.8).CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGPoint origin = CGPointMake(RH(12.0f), RH(12.0f));
    CGFloat radius = RH(12.0f);
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = startAngle + self.progress * M_PI * 2;
    //    根据起始点、原点、半径绘制弧线
    UIBezierPath *sectorPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    //    从弧线结束为止绘制一条线段到圆心。这样系统会自动闭合图形，绘制一条从圆心到弧线起点的线段。
    [sectorPath addLineToPoint:origin];
    [[UIColor whiteColor] set];
    [sectorPath fill];
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}
@end
@implementation UIView (CCWebImage)
#pragma mark - 设置图片操作
-(void)cc_setImageWithURL:(NSURL *)url{
    [self cc_setImageWithURL:url placeholderImage:nil processBlock:nil completed:nil];
}
-(void)cc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    [self cc_setImageWithURL:url placeholderImage:placeholder processBlock:nil completed:nil];
}
-(void)cc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder processBlock:(nullable CC_WebImageProgressBlock)processBlock completed:(nullable CC_WebImageCompletionBlock)completedBlock{
    //设置占位图
    dispatch_main_async_safe(^{
        [self internalSetImage:placeholder];
    });
    __weak typeof(self) weakSelf = self;
    id<CC_WebImageOperationDelegate> operation = [[CC_WebImageManager shareInstance] loadImageWithURL:url progress:processBlock completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
        if (error) {
            [CC_Notice show:error.description];
        } else if (image) {
            //设置下载完的图片
            [weakSelf internalSetImage:image];
        } else {
            if (finished) {
                [CC_Notice show:@"Error:image is nil"];
            }
        }
        SAFE_CALL_BLOCK(completedBlock, image, error, finished);
    }];
    //记录operation
    [self setOperation:operation forKey:NSStringFromClass([self class])];
}
- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder showProgressView:(BOOL)showProgressView completed:(nullable CC_WebImageCompletionBlock)completedBlock{
    
    self.progressV = [[CC_WebImgProgressView alloc]initWithFrame:CGRectMake(self.width/2.0-RH(12.0f), self.height/2.0-RH(12.0f), RH(24.0f), RH(24.0f))];
    [self addSubview:self.progressV];
    self.showProgressView = showProgressView;
    self.progressV.hidden = YES;
    
    WS(weakSelf);
    [self cc_setImageWithURL:url placeholderImage:placeholder processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        SS(strongSelf);
        if (showProgressView) {
            strongSelf.progressV.hidden = NO;
            strongSelf.progressV.progress = ((CGFloat)receivedSize)/expectedSize;
            //下载完了就隐藏
            if (receivedSize == expectedSize) {
                strongSelf.progressV.hidden = YES;
            }
        }
    } completed:completedBlock];
}
- (void)internalSetImage:(UIImage *)image {
    if (!image) {
        return;
    }
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self;
        if (image.imageFormat == CC_WebImageFormatGIF) {
            imageView.animationImages = image.images;
            imageView.animationDuration = image.totalTimes;
            imageView.animationRepeatCount = image.loopCount;
            [imageView startAnimating];
        } else {
            imageView.image = image;
        }
    } else if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button setImage:image forState:UIControlStateNormal];
    }
}

#pragma mark - operation
//动态生成operationDictionary属性
-(CC_WebImageOperationDictionay*)operationDictionary{
    @synchronized (self) {
        CC_WebImageOperationDictionay* operationDic = objc_getAssociatedObject(self, &kCC_WebImageOperation);
        if (operationDic) {
            return operationDic;
        }
        operationDic = [[NSMutableDictionary alloc]init];
        objc_setAssociatedObject(self, &kCC_WebImageOperation, operationDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return operationDic;
    }
}
-(void)setOperation:(id<CC_WebImageOperationDelegate>)operation forKey:(NSString *)key{
    if (key) {
        [self cancelOperationForKey:key];
        if (operation) {
            CC_WebImageOperationDictionay* operationDic = [self operationDictionary];
            @synchronized (self) {
                [operationDic setObject:operation forKey:key];
            }
        }
    }
}
-(void)cancelOperationForKey:(NSString *)key{
    if (key) {
        CC_WebImageOperationDictionay* operationDic = [self operationDictionary];
        id<CC_WebImageOperationDelegate> operation;
        @synchronized (self) {
            operation = [operationDic objectForKey:key];
        }
        if (operation && [operation conformsToProtocol:@protocol(CC_WebImageOperationDelegate)]) {
            [operation cancelOperation];
        }
        @synchronized (self) {
            [operationDic removeObjectForKey:key];
        }
    }
}
-(void)removeOperationForKey:(NSString *)key{
    if (key) {
        CC_WebImageOperationDictionay* operationDic = [self operationDictionary];
        @synchronized (self) {
            [operationDic removeObjectForKey:key];
        }
    }
}
#pragma mark - properties
- (BOOL)showProgressView {
    return [objc_getAssociatedObject(self, &user_defined_base_show_progress_view_key) boolValue];
}
- (void)setShowProgressView:(BOOL)showProgressView {
    objc_setAssociatedObject(self, &user_defined_base_show_progress_view_key, [NSNumber numberWithBool:showProgressView], OBJC_ASSOCIATION_ASSIGN);
}

- (CC_WebImgProgressView *)progressV {
    return objc_getAssociatedObject(self, &user_defined_base_progress_view_key);
}

- (void)setProgressV:(CC_WebImgProgressView *)progressV {
    objc_setAssociatedObject(self, &user_defined_base_progress_view_key, progressV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
