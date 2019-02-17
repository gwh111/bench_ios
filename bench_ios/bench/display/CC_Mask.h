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

/**
 *  添加mask到view view=nil时使用window
 */
- (void)startAtView:(UIView *)view;

/**
 *  停止mask
 */
- (void)stop;

@end

NS_ASSUME_NONNULL_END
