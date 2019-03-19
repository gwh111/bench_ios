//
//  NSDate+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/11/9.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate(CCCat)

@property (nonatomic, assign, readonly) int dp_day;
@property (nonatomic, assign, readonly) int dp_month;
@property (nonatomic, assign, readonly) int dp_year;

@end

NS_ASSUME_NONNULL_END
