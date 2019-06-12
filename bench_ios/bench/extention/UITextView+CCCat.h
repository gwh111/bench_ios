//
//  UITextView+CCCat.h
//  bench_ios
//
//  Created by david on 2019/6/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CCCat)
/** 检查textView.text的最大长度 (超出截掉)*/
- (void)checkWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
