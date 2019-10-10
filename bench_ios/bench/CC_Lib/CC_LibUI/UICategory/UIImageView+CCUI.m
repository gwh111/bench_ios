//
//  UIImageView+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UIImageView+CCUI.h"

@implementation UIImageView (CCUI)

- (__kindof UIImageView * (^)(UIImage *))cc_image {
    return ^(UIImage *image) {
        self.image = image;
        return self;
    };
}

- (__kindof UIImageView *(^)(UIImage *))cc_highlightedImage {
    return ^(UIImage *highlightedImage) {
        self.highlightedImage = highlightedImage;        
        return self;
    };
}

- (__kindof UIImageView *(^)(BOOL))cc_highlighted {
    return ^(BOOL highlighted) {
        self.highlighted = highlighted;
        return self;
    };
}

- (__kindof UIImageView *(^)(NSArray *))cc_animationImages {
    return ^(NSArray *animationImages) {
        self.animationImages = animationImages;
        return self;
    };
}

- (__kindof UIImageView *(^)(NSArray *))cc_highlightedAnimationImages {
    return ^(NSArray *highlightedAnimationImages) {
        self.highlightedAnimationImages = highlightedAnimationImages;
        return self;
    };
}

- (__kindof UIImageView *(^)(NSTimeInterval))cc_animationDuration {
    return ^(NSTimeInterval animationDuration) {
        self.animationDuration = animationDuration;
        return self;
    };
}

- (__kindof UIImageView *(^)(NSInteger))cc_animationRepeatCount {
    return ^(NSInteger animationRepeatCount) {
        self.animationRepeatCount = animationRepeatCount;
        return self;
    };
}



@end

@implementation UIImageView (CCActions)

@end
