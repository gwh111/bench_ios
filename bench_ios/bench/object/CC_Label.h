//
//  CC_Label.h
//  bench_ios
//
//  Created by gwh on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Label : UILabel

+ (CC_Label *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment;

/**
 * label的基本功能创建
 */
+ (CC_Label *)createWithFrame:(CGRect)frame
               andTitleString:(NSString *)titleString
          andAttributedString:(NSAttributedString*)attributedString
                andTitleColor:(UIColor *)color
           andBackGroundColor:(UIColor *)backGroundColor
                      andFont:(UIFont *)font
             andTextAlignment:(NSTextAlignment)textAlignment
                       atView:(UIView *)view;

@end
