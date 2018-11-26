//
//  CC_TextView.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_TextView : UITextView

/**
 *  计算textview的高度
 */
- (float)heightForWidth:(float)width;

/**
 *  计算textview的宽度
 */
- (float)widthForHeight:(float)height;

/**
 *  根据模型name取得模型
 需导入模型文件 并初始化时读取
 */
+ (CC_TextView *)getModel:(NSString *)name;

/**
 *  制作一个模型
 model 创建的模型
 name 给模型取一个名字
 des description 添加描述 比如写该控件的特征（如有无边框）使用场景等
 hasSetLayer 有没有对layer做设置
 
 return 返回模型保存的沙盒路径
 */
+ (NSString *)saveModel:(CC_TextView *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;



+ (CC_TextView *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled;

+ (CC_TextView *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment sb:(BOOL)selectable eb:(BOOL)editable uie:(BOOL)userInteractionEnabled;

@end
