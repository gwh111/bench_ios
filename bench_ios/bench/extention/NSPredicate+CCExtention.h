//
//  NSPredicate+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/10/29.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPredicate(CCExtention)

+ (BOOL)isMatchNumberWordChinese:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
