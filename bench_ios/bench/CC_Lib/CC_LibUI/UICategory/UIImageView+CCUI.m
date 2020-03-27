//
//  UIImageView+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UIImageView+CCUI.h"

@interface UIImage (CC)

- (UIImage *)cc_drawRectWithRoundedCorner:(CGFloat)radius
                                     size:(CGSize)size;

@end

@implementation UIImage (CC)

- (UIImage *)cc_drawRectWithRoundedCorner:(CGFloat)radius
                                     size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

@end

@implementation UIImageView (CCUI)

- (void)cc_addCorner:(CGFloat)radius {
    if (self.image) {
        self.image = [self.image cc_drawRectWithRoundedCorner:radius size:self.bounds.size];
    }
}

- (UIImageView * (^)(UIImage *))cc_image {
    return ^(UIImage *_) { self.image = _; return self; };
}

- (UIImageView *(^)(UIImage *))cc_highlightedImage {
    return ^(UIImage *_) { self.highlightedImage = _; return self; };
}

- (UIImageView *(^)(BOOL))cc_highlighted {
    return ^(BOOL _) { self.highlighted = _; return self; };
}

- (UIImageView *(^)(NSArray *))cc_animationImages {
    return ^(NSArray *_) { self.animationImages = _; return self; };
}

- (UIImageView *(^)(NSArray *))cc_highlightedAnimationImages {
    return ^(NSArray *_) { self.highlightedAnimationImages = _; return self; };
}

- (UIImageView *(^)(NSTimeInterval))cc_animationDuration {
    return ^(NSTimeInterval _) { self.animationDuration = _; return self; };
}

- (UIImageView *(^)(NSInteger))cc_animationRepeatCount {
    return ^(NSInteger _) { self.animationRepeatCount = _; return self; };
}

@end

@implementation UIImageView (CCActions)

@end

