//
//  CC_Data.h
//  testbenchios
//
//  Created by gwh on 2019/8/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Data : NSObject

+ (NSData *)cc_archivedDataWithObject:(id)object;
+ (id)cc_unarchivedObjectWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
