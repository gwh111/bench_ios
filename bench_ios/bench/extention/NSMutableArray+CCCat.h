//
//  NSMutableArray+CCCat.h
//  Doctor
//
//  Created by 路飞 on 2019/6/10.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (CCCat)

- (void)safe_addObject:(id)obj;

- (void)safe_insertObject:(id)object withIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
