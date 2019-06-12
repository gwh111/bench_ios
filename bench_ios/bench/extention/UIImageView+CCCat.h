//
//  UIImageView+CCCat.h
//  bench_ios
//
//  Created by 路飞 on 2019/6/10.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CCCat)

/**
 更新badge
 
 @param badge 角标
 */
- (void)updateBadge:(nullable NSString*)badge;

/**
 更新badge背景色
 
 @param backGroundColor 背景色
 */
- (void)updateBadgeBackGroundColor:(UIColor*)backGroundColor;

/**
 更新badge文字颜色
 
 @param textColor 文字颜色
 */
- (void)updateBadgeTextColor:(UIColor*)textColor;

@end

NS_ASSUME_NONNULL_END
