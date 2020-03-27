//
//  Father.h
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Father : CC_Model

typedef void (^block1)(void);

@property (nonatomic, assign) int x;
@property (nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
