//
//  CC_Rect.m
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import "CC_Rect.h"
#import "CC_Base.h"

@implementation CC_Rect

+ (CC_Rect *)valueX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CC_Rect *rect = [CC_Base.shared cc_init:[CC_Rect class]];
    rect.x = x;
    rect.y = y;
    rect.maxX = x + width;
    rect.maxY = y + height;
    rect.centerX = x + width/2;
    rect.centerY = y + height/2;
    rect.width = width;
    rect.height = height;
    rect.rect = CGRectMake(x, y, width, height);
    return rect;
}

@end
