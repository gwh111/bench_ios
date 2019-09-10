//
//  UIImage+CC_WebImageFormat.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/23.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "UIImage+CC_WebImageFormat.h"

FOUNDATION_STATIC_INLINE NSUInteger CC_WebImageMemoryCost(UIImage *image){
    NSUInteger imageSize = image.size.width * image.size.height * image.scale;
    return image.images ? imageSize * image.images.count : imageSize;
}

@implementation UIImage (CC_WebImageFormat)

- (UIImage *)normalizedImage{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)setImageFormat:(CC_WebImageFormat)imageFormat{
    [CC_Runtime cc_setObject:self key:@selector(imageFormat) value:@(imageFormat)];
}

- (CC_WebImageFormat)imageFormat{
    CC_WebImageFormat imageFormat = CC_WebImageFormatUndefined;
    NSNumber *value = [CC_Runtime cc_getObject:self key:@selector(imageFormat)];
    if ([value isKindOfClass:[NSNumber class]]) {
        imageFormat = value.integerValue;
        return imageFormat;
    }
    return imageFormat;
}

- (NSUInteger)memoryCost{
    NSNumber *value = [CC_Runtime cc_getObject:self key:@selector(memoryCost)];
    if (value) {
        return [value unsignedIntegerValue];
    } else {
        NSUInteger memoryCost = CC_WebImageMemoryCost(self);
        [self setMemoryCost:memoryCost];
        return memoryCost;
    }
}

- (void)setMemoryCost:(NSUInteger)memoryCost{
    [CC_Runtime cc_setObject:self key:@selector(memoryCost) value:@(memoryCost)];
}

- (void)setTotalTimes:(NSTimeInterval)totalTimes{
    [CC_Runtime cc_setObject:self key:@selector(totalTimes) value:@(totalTimes)];
}

- (NSTimeInterval)totalTimes{
    NSNumber *value = [CC_Runtime cc_getObject:self key:@selector(totalTimes)];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value.floatValue;
    }
    return 0;
}

- (void)setLoopCount:(NSInteger)loopCount{
    [CC_Runtime cc_setObject:self key:@selector(loopCount) value:@(loopCount)];
}

- (NSInteger)loopCount{
    NSNumber *value = [CC_Runtime cc_getObject:self key:@selector(loopCount)];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value.integerValue;
    }
    return 0;
}

- (void)setDelayTimes:(NSArray<NSNumber *> *)delayTimes{
    [CC_Runtime cc_setObject:self key:@selector(delayTimes) value:delayTimes];
}

- (NSArray<NSNumber *> *)delayTimes{
    NSArray<NSNumber *> *delayTimes = [CC_Runtime cc_getObject:self key:@selector(delayTimes)];
    if ([delayTimes isKindOfClass:[NSArray class]]) {
        return delayTimes;
    }
    return nil;
}

- (void)setImages:(NSArray<UIImage *> *)images{
    [CC_Runtime cc_setObject:self key:@selector(images) value:images];
}

- (NSArray<UIImage *> *)images{
    NSArray<UIImage *> *images = [CC_Runtime cc_getObject:self key:@selector(images)];
    if ([images isKindOfClass:[NSArray class]]) {
        return images;
    }
    return nil;
}

@end
