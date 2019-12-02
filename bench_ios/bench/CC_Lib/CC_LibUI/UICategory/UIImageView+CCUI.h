//
//  UIImageView+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_ImageView;

@interface UIImageView (CCUI)

/// The image displayed in the image view.
- (UIImageView *(^)(UIImage *))cc_image;

/// The highlighted image displayed in the image view
- (UIImageView *(^)(UIImage *))cc_highlightedImage;

/// A Boolean value that determines whether the image is highlighted.
- (UIImageView *(^)(BOOL))cc_highlighted;

/// An array of UIImage objects to use for an animation.
- (UIImageView *(^)(NSArray *))cc_animationImages;

/// An array of UIImage objects to use for an animation when the view is highlighted.
- (UIImageView *(^)(NSArray *))cc_highlightedAnimationImages;

/// for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
- (UIImageView *(^)(NSTimeInterval))cc_animationDuration;

/// 0 means infinite (default is 0)
- (UIImageView *(^)(NSInteger))cc_animationRepeatCount;

@end

@interface UIImageView (CCActions)

@end

@protocol CC_ImageViewChainExtProtocol <NSObject>

/// The image displayed in the image view.
- (__kindof CC_ImageView *(^)(UIImage *))cc_image;

/// The highlighted image displayed in the image view
- (__kindof CC_ImageView *(^)(UIImage *))cc_highlightedImage;

/// A Boolean value that determines whether the image is highlighted.
- (__kindof CC_ImageView *(^)(BOOL))cc_highlighted;

/// An array of UIImage objects to use for an animation.
- (__kindof CC_ImageView *(^)(NSArray *))cc_animationImages;

/// An array of UIImage objects to use for an animation when the view is highlighted.
- (__kindof CC_ImageView *(^)(NSArray *))cc_highlightedAnimationImages;

/// for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
- (__kindof CC_ImageView *(^)(NSTimeInterval))cc_animationDuration;

/// 0 means infinite (default is 0)
- (__kindof CC_ImageView *(^)(NSInteger))cc_animationRepeatCount;

@end

NS_ASSUME_NONNULL_END
