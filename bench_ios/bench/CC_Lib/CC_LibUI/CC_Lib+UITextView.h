//
//  UITextView+CCCat.h
//  bench_ios
//
//  Created by david on 2019/6/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CC_Lib)

#pragma mark function
/** 检查textView.text的最大长度 (超出截掉) */
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

/** get textView height after set width&text */
- (float)cc_heightForWidth:(float)width;

/** get textView width after set height&text */
- (float)cc_widthForHeight:(float)height;

@end

NS_ASSUME_NONNULL_END
