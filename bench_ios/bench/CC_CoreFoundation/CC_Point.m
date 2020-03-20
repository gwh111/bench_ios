//
//  CC_Point.m
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import "CC_Point.h"
#import "CC_Base.h"

@implementation CC_Point

+ (CC_Point *)valueX:(CGFloat)x y:(CGFloat)y {
    CC_Point *point = [CC_Base.shared cc_init:[CC_Point class]];
    point.x = x;
    point.y = y;
    point.point = CGPointMake(x, y);
    return point;
}

@end
