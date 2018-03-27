//
//  CC_View.h
//  bench_ios
//
//  Created by gwh on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_View : UIView

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view r:(float)right b:(float)bottom w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view cx:(float)centerX cy:(float)centerY w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top r:(float)right b:(float)bottom bgc:(UIColor *)backgroundColor;

@end
