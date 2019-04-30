//
//  UIImage+CC_WebImageFormat.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/23.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "UIImage+CC_WebImageFormat.h"
#import "objc/runtime.h"

FOUNDATION_STATIC_INLINE NSUInteger CC_WebImageMemoryCost(UIImage *image){
    NSUInteger imageSize = image.size.width * image.size.height * image.scale;
    return image.images ? imageSize * image.images.count : imageSize;
}

@implementation UIImage (CC_WebImageFormat)

- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)setImageFormat:(CC_WebImageFormat)imageFormat {
    objc_setAssociatedObject(self, @selector(imageFormat), @(imageFormat), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CC_WebImageFormat)imageFormat {
    CC_WebImageFormat imageFormat = CC_WebImageFormatUndefined;
    NSNumber *value = objc_getAssociatedObject(self, @selector(imageFormat));
    if ([value isKindOfClass:[NSNumber class]]) {
        imageFormat = value.integerValue;
        return imageFormat;
    }
    return imageFormat;
}

- (NSUInteger)memoryCost {
    NSNumber *value = objc_getAssociatedObject(self, @selector(memoryCost));
    if (value) {
        return [value unsignedIntegerValue];
    } else {
        NSUInteger memoryCost = CC_WebImageMemoryCost(self);
        [self setMemoryCost:memoryCost];
        return memoryCost;
    }
}

- (void)setMemoryCost:(NSUInteger)memoryCost {
    objc_setAssociatedObject(self, @selector(memoryCost), @(memoryCost), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTotalTimes:(NSTimeInterval)totalTimes {
    objc_setAssociatedObject(self, @selector(totalTimes), @(totalTimes), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)totalTimes {
    NSNumber *value = objc_getAssociatedObject(self, @selector(totalTimes));
    if ([value isKindOfClass:[NSNumber class]]) {
        return value.floatValue;
    }
    return 0;
}

- (void)setLoopCount:(NSInteger)loopCount {
    objc_setAssociatedObject(self, @selector(loopCount), @(loopCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)loopCount {
    NSNumber *value = objc_getAssociatedObject(self, @selector(loopCount));
    if ([value isKindOfClass:[NSNumber class]]) {
        return value.integerValue;
    }
    return 0;
}

- (void)setDelayTimes:(NSArray<NSNumber *> *)delayTimes {
    objc_setAssociatedObject(self, @selector(delayTimes), delayTimes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray<NSNumber *> *)delayTimes {
    NSArray<NSNumber *> *delayTimes = objc_getAssociatedObject(self, @selector(delayTimes));
    if ([delayTimes isKindOfClass:[NSArray class]]) {
        return delayTimes;
    }
    return nil;
}

- (void)setImages:(NSArray<UIImage *> *)images {
    objc_setAssociatedObject(self, @selector(images), images, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSArray<UIImage *> *)images {
    NSArray<UIImage *> *images = objc_getAssociatedObject(self, @selector(images));
    if ([images isKindOfClass:[NSArray class]]) {
        return images;
    }
    return nil;
}
@end
