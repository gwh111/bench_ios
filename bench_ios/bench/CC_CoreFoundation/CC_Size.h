//
//  CC_Size.h
//  bench_ios
//
//  Created by gwh on 2020/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define Size(widthValue,heightValue) [CC_Size valueWidth:widthValue height:heightValue]

@interface CC_Size : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

+ (CC_Size *)valueWidth:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
