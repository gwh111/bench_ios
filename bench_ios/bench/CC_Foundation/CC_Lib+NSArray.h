//
//  NSArray+CC_Lib.h
//  testbenchios
//
//  Created by gwh on 2019/8/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (CC_Lib)

- (void)cc_addObject:(id)obj;

// 升序
- (void)cc_ascending;

// 降序
- (void)cc_descending;

@end

NS_ASSUME_NONNULL_END
