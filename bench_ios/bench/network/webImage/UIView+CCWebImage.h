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
@property (nonatomic, strong) CC_WebImgProgressView* progressV;

#pragma mark - 设置图片操作

/**
 加载图片

 @param url URL
 */
-(void)cc_setImageWithURL:(NSURL*)url;

/**
 加载图片，带占位图

 @param url URL
 @param placeholder 占位图
 */
-(void)cc_setImageWithURL:(NSURL*)url placeholderImage:(nullable UIImage*)placeholder;

/**
 加载图片，带占位图，带进度回调，带完成回调

 @param url URL
 @param placeholder 占位图
 @param processBlock 进度回调
 @param completedBlock 完成回调
 */
-(void)cc_setImageWithURL:(NSURL*)url placeholderImage:(nullable UIImage *)placeholder processBlock:(nullable CC_WebImageProgressBlock)processBlock completed:(nullable CC_WebImageCompletionBlock)completedBlock;

/**
 加载图片，带占位图，带进度条（扇形），带完成回调
 
 @param url URL
 @param placeholder 占位图
 @param showProgressView 进度条是否展示
 @param completedBlock 完成回调
 */
-(void)cc_setImageWithURL:(NSURL*)url placeholderImage:(nullable UIImage *)placeholder showProgressView:(BOOL)showProgressView completed:(nullable CC_WebImageCompletionBlock)completedBlock;

#pragma mark - Operation操作

/**
 记录key对应的操作，key:operation

 @param operation operation
 @param key key
 */
- (void)setOperation:(id<CC_WebImageOperationDelegate>)operation forKey:(nullable NSString *)key;

/**
 取消key对应的操作

 @param key key
 */
- (void)cancelOperationForKey:(nullable NSString *)key;

/**
 移除key对应的操作

 @param key key
 */
- (void)removeOperationForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
