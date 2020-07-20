//
//  CC_Money.h
//  bench_ios
//
//  Created by gwh on 2019/11/11.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Money : CC_Object

@property (nonatomic, assign) NSString *value;//0.10 = 0.1
@property (nonatomic, assign) NSString *moneyValue;//0.1 = 0.10
@property (nonatomic, assign) double number;

+ (CC_Money *)moneyWithInt:(int)number;
+ (CC_Money *)moneyWithFloat:(float)value;
+ (CC_Money *)moneyWithString:(NSString *)str;

- (void)addMoney:(CC_Money *)add;
- (void)cutMoney:(CC_Money *)cut;

@end

NS_ASSUME_NONNULL_END
