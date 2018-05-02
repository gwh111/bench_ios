//
//  CC_TextField.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_TextField : UITextField

+ (CC_TextField *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled;

+ (CC_TextField *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled;

@end
