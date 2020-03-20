//
//  CC_Point.h
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define Point(xValue,yValue) [CC_Point valueX:xValue y:yValue]

@interface CC_Point : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGPoint point;

+ (CC_Point *)valueX:(CGFloat)x y:(CGFloat)y;

@end

NS_ASSUME_NONNULL_END
