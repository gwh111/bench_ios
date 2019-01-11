//
//  abc.m
//  bench_ios
//
//  Created by gwh on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "abc.h"

@implementation abc

- (void)setStr:(NSString *)str{
    self.str=str;
    
}

- (void)log{
    CCLOG(@"%@",_str);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
