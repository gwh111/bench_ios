//
//  UIResponder+CCCat.h
//  bench_ios
//
//  Created by ml on 2019/6/3.
//  Copyright © 2019 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (CCCat)

/**
 找到第一响应者

 @return 第一响应者
 */
+ (id)cc_currentFirstResponder;

@end

NS_ASSUME_NONNULL_END
