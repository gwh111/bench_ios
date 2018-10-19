//
//  CC_TextField.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_TextField : UITextField

/**
 *  根据模型name取得模型
 需导入模型文件 并初始化时读取
 */
+ (CC_TextField *)getModel:(NSString *)name;

/**
 *  制作一个模型
 model 创建的模型
 name 给模型取一个名字
 des description 添加描述 比如写该控件的特征（如有无边框）使用场景等
 hasSetLayer 有没有对layer做设置
 
 return 返回模型保存的沙盒路径
 */
+ (NSString *)saveModel:(CC_TextField *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;



+ (CC_TextField *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled;

+ (CC_TextField *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor f:(UIFont *)font ta:(NSTextAlignment)textAlignment ph:(NSString *)placeholder uie:(BOOL)userInteractionEnabled;

@end
