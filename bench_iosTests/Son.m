//
//  Son.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import "Son.h"

@implementation Son

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.x = 9;
        [self add:2];
        
        NSLog(@"son super=%@",[super class]);
    }
    return self;
}

- (instancetype)init2
{
    self = [super init];
    if (self) {
        
        [self add:2];
    }
    return self;
}

- (void)add:(int)y {
    self.x = self.x + y;
}

@end
