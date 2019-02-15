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

- (void)startAtView:(UIView *)view;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
