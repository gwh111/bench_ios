//
//  UIView+CCWebImage.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageConfig.h"
#import "CC_WebImageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_WebImgProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@end

@interface UIView (CCWebImage)

//是否展示进度条
@property (nonatomic, assign) BOOL showProgressView;
//进度条view
@property (nonatomic, strong) CC_WebImgProgressView *progressV;

#pragma mark - 设置图片操作

- (void)cc_setImageWithURL:(NSURL *)url;

- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder processBlock:(nullable CC_WebImageProgressBlock)processBlock completed:(nullable CC_WebImageCompletionBlock)completedBlock;

// With ProgressView
- (void)cc_setImageWithURL:(NSURL *)url placeholderImage:(nullable UIImage *)placeholder showProgressView:(BOOL)showProgressView completed:(nullable CC_WebImageCompletionBlock)completedBlock;

@end

NS_ASSUME_NONNULL_END
