//
//  CC_Math.h
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Math : CC_Object

+ (CC_Math *)math;

// 除法 对分母0判断 返回0
- (int)intWithNumberInt:(int)number1 divideInt:(int)number2;
- (int)intWithNumberFloat:(float)number1 divideFloat:(float)number2;
- (int)intWithNumberId:(id)number1 divideId:(id)number2;
- (float)floatWithNumberInt:(int)number1 divideInt:(int)number2;
- (float)floatWithNumberFloat:(float)number1 divideFloat:(float)number2;
- (float)floatWithNumberId:(id)number1 divideId:(id)number2;

#pragma mark du
// 度和弧度的转化
- (CGFloat)huduWithDu:(CGFloat)du;
- (CGFloat)duWithHudu:(CGFloat)huDu;

// 根据两点坐标计算距离
- (CGFloat)distanceWithPoint:(CC_Point *)point1 point:(CC_Point *)point2;

// 根据两点坐标计算连线和x轴角度
- (CGFloat)duWithPoint:(CC_Point *)point1 point:(CC_Point *)point2;

// 根据角度和长度获得新坐标位置。相对于(0,0)点
- (CC_Point *)pointWithR:(CGFloat)r du:(CGFloat)du;

@end

NS_ASSUME_NONNULL_END
