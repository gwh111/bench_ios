//
//  UIView+CCWebImage.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "UIView+CCWebImage.h"
#import "objc/runtime.h"

#define SAFE_CALL_BLOCK(blockFunc, ...)    \
if (blockFunc) {                        \
blockFunc(__VA_ARGS__);              \
}

static char kCC_WebImageOperation;
typedef NSMutableDictionary<NSString *, id<CC_WebImageOperationDelegate>> CC_WebImageOperationDictionay;

@implementation UIView (CCWebImage)
#pragma mark - 设置图片操作
- (void)cc_setImageWithURL:(NSURL *)url{
    [self cc_setImageWithURL:url placeholderImage:nil processBlock:nil completed:nil];
}
- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    [self cc_setImageWithURL:url placeholderImage:placeholder processBlock:nil completed:nil];
}
- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder processBlock:(nullable CC_WebImageProgressBlock)processBlock completed:(nullable CC_WebImageCompletionBlock)completedBlock{
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
- (CC_WebImageOperationDictionay*)operationDictionary{
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
- (void)setOperation:(id<CC_WebImageOperationDelegate>)operation forKey:(NSString *)key{
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
- (void)cancelOperationForKey:(NSString *)key{
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
- (void)removeOperationForKey:(NSString *)key{
    if (key) {
        CC_WebImageOperationDictionay* operationDic = [self operationDictionary];
        @synchronized (self) {
            [operationDic removeObjectForKey:key];
        }
    }
}
@end
