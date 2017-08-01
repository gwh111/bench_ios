//
//  CC_Label.h
//  bench_ios
//
//  Created by gwh on 2017/8/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Label : UILabel

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
