//
//  UITextField+CCCat.h
//  bench_ios
//
//  Created by david on 2019/6/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CC_Lib)

/** 检查textField.text的最大长度 (超出截掉)*/
- (void)cc_cutWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
