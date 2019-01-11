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
 *  描边颜色 无法使用多色的attbutedstr
 */
@property (nonatomic,strong)UIColor *borderColor;
/**
 *  描边宽
 */
@property (nonatomic,assign)CGFloat borderWidth;

/**
 *  根据模型name取得模型
 需导入模型文件 并初始化时读取
 */
+ (CC_Label *)getModel:(NSString *)name;

/**
 *  制作一个模型
 model 创建的模型
 name 给模型取一个名字
 des description 添加描述 比如写该控件的特征（如有无边框）使用场景等
 hasSetLayer 有没有对layer做设置
 
 return 返回模型保存的沙盒路径
 */
+ (NSString *)saveModel:(CC_Label *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;




+ (CC_Label *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment;

+ (CC_Label *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment;

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
