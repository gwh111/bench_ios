//
//  UIResponder+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (CC)

/**
 找到第一响应者
 
 @return 第一响应者
 */
+ (id)cc_currentFirstResponder;

@end

NS_ASSUME_NONNULL_END
