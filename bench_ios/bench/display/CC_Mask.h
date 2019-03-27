//
//  CC_Mask.h
//  bench_ios
//
//  Created by gwh on 2019/2/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Mask : UIView

+ (instancetype)getInstance;

- (void)start;

/**
 *  点击是否穿透
 *  cross=0 点击不可穿透
    cross=1 点击可以穿透
 */
- (void)setCross:(BOOL)cross;

/**
 *  添加mask到view view=nil时使用window
 */
- (void)startAtView:(UIView * _Nullable)view;

/**
 *  停止mask
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
