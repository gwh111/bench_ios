//
//  UIImage+CC_WebImageFormat.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/23.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CC_WebImageFormat) {
    CC_WebImageFormatUndefined = -1,
    CC_WebImageFormatJPEG = 0,
    CC_WebImageFormatPNG = 1,
    CC_WebImageFormatGIF = 2
};

@interface UIImage (CC_WebImageFormat)

@property (nonatomic, assign) CC_WebImageFormat imageFormat;//图片格式
@property (nonatomic, assign) NSUInteger memoryCost;//内存大小

- (UIImage *)normalizedImage;

#pragma mark - gif图片属性
@property (nonatomic, copy) NSArray<UIImage *> *images;
@property (nonatomic, assign) NSInteger loopCount;
@property (nonatomic, copy) NSArray<NSNumber *> *delayTimes;
@property (nonatomic, assign) NSTimeInterval totalTimes;

@end

NS_ASSUME_NONNULL_END
