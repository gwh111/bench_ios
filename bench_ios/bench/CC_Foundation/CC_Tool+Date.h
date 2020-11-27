//
//  CC_Tool+Date.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_CoreFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Date)

- (BOOL)checkNeedUpdateWithKey:(NSString *)key second:(NSUInteger)second;
- (NSTimeInterval)compareDate:(id)date1 cut:(id)date2;
- (NSString *)formatDate:(NSString *)date nowDate:(NSString *)nowDate;
- (NSString *)formatDate:(NSString *)cc_date nowDate:(NSString *)cc_nowDate formatArr:(NSArray *)formatArr;

@end

NS_ASSUME_NONNULL_END
