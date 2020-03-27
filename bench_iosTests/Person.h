//
//  Person.h
//  bench_iosTests
//
//  Created by gwh on 2020/3/23.
//

#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : CC_Model

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickNames;
@property (nonatomic, copy) NSString *age;

- (void)nothing;
- (void)nothing:(int)asd;

@end

NS_ASSUME_NONNULL_END
