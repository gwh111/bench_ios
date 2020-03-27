//
//  Son.h
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import "Father.h"

NS_ASSUME_NONNULL_BEGIN

@interface Son : Father

typedef void (^block1)(void);

@property (nonatomic, assign) int x;

- (instancetype)init2;

@end

NS_ASSUME_NONNULL_END
