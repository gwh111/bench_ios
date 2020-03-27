//
//  CC_Delegate.h
//  bench_ios
//
//  Created by gwh on 2019/8/29.
//

#import <Foundation/Foundation.h>
#import "CC_Object.h"

@interface CC_Delegate : CC_Object

@property (nonatomic, retain) NSObject *delegate;

- (void)cc_performSelector:(SEL)selector params:(id)param,...;

@end
