//
//  CC_Size.h
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import <UIKit/UIKit.h>
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#define CC_SIZE(widthValue,heightValue) [CC_Size valueWidth:widthValue height:heightValue]

@interface CC_Size : CC_Object

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

+ (CC_Size *)valueWidth:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
