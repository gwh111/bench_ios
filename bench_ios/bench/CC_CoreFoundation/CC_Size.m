//
//  CC_Size.m
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import "CC_Size.h"
#import "CC_Base.h"

@implementation CC_Size

+ (CC_Size *)valueWidth:(CGFloat)width height:(CGFloat)height {
    CC_Size *size = [CC_Base.shared cc_init:[CC_Size class]];
    size.width = width;
    size.height = height;
    size.size = CGSizeMake(width, height);
    return size;
}

@end
