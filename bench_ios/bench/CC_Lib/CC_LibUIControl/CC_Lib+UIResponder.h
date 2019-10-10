//
//  UIResponder+CCCat.h
//  bench_ios
//
//  Created by ml on 2019/6/3.
//  Copyright © 2019 liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (CC_Lib)

+ (id)cc_currentFirstResponder;
- (void)findFirstResponder:(id)sender;

@end

NS_ASSUME_NONNULL_END
