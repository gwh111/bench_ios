//
//  CC_Rect.h
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import <UIKit/UIKit.h>
#import "CC_Object.h"
#import "CC_Point.h"
#import "CC_Size.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_RECT(xValue,yValue,widthValue,heightValue) [CC_Rect valueX:xValue y:yValue width:widthValue height:heightValue]

@interface CC_Rect : CC_Object

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGRect rect;
//@property (nonatomic, retain) CC_Point *point;
//@property (nonatomic, retain) CC_Size *size;

+ (CC_Rect *)valueX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
