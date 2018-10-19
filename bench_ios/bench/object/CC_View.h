//
//  CC_View.h
//  bench_ios
//
//  Created by gwh on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_View : UIView

/**
 *  根据模型name取得模型
 需导入模型文件 并初始化时读取
 */
+ (CC_View *)getModel:(NSString *)name;

/**
 *  制作一个模型
 model 创建的模型
 name 给模型取一个名字
 des description 添加描述 比如写该控件的特征（如有无边框）使用场景等
 hasSetLayer 有没有对layer做设置
 
 return 返回模型保存的沙盒路径
 */
+ (NSString *)saveModel:(CC_View *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;





+ (CC_View *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view r:(float)right b:(float)bottom w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view cx:(float)centerX cy:(float)centerY w:(float)width h:(float)height bgc:(UIColor *)backgroundColor;

+ (CC_View *)cr:(UIView *)view l:(float)left t:(float)top r:(float)right b:(float)bottom bgc:(UIColor *)backgroundColor;

@end
