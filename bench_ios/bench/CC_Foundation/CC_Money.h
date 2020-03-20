//
//  CC_Money.h
//  bench_ios
//
//  Created by gwh on 2019/11/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Money : NSObject

@property (nonatomic, assign) NSString *value;
@property (nonatomic, assign) double number;

- (NSString *)moneyWithString:(NSString *)money;

- (void)addMoney:(CC_Money *)add;
- (void)cutMoney:(CC_Money *)cut;

@end

NS_ASSUME_NONNULL_END
