//
//  AppButton.h
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Button : UIButton{
    void (^tappedBlock)(UIButton *button);
}

@property(strong) void (^tappedBlock)(UIButton *button);
@property(nonatomic,assign) float delayTime;
@property(nonatomic,assign) int forbiddenEnlargeTapFrame;

/**
 *  根据模型name取得模型
    需导入模型文件 并初始化时读取
 */
+ (CC_Button *)getModel:(NSString *)name;

/**
 *  制作一个模型
    model 创建的模型
    name 给模型取一个名字
    des description 添加描述 比如写该控件的特征（如有无边框）使用场景等
    hasSetLayer 有没有对layer做设置
 
    return 返回模型保存的沙盒路径
 */
+ (NSString *)saveModel:(CC_Button *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;

/**
 * 防止连续点击后重复调用tap方法
 * time 防止重复 第二次点击可执行需要的时间
 */
- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block;



#pragma mark 不再建议使用 保留是为了兼容之前版本

/**
 * 防止连续点击后重复调用tap方法
   区别于addTappedOnceDelay是先点击后延迟
   addTappedBlock是先延时后点击
 */
- (void)addTappedBlock:(void (^)(UIButton *button))block;

+ (CC_Button *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor img:(UIImage *)image bgimg:(UIImage *)backgroundImage f:(UIFont *)font ta:(UIControlContentHorizontalAlignment)contentHorizontalAlignment uie:(BOOL)userInteractionEnabled;

+ (CC_Button *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor img:(UIImage *)image bgimg:(UIImage *)backgroundImage f:(UIFont *)font ta:(UIControlContentHorizontalAlignment)contentHorizontalAlignment uie:(BOOL)userInteractionEnabled;

/**
 * button的基本功能创建
 */
+ (CC_Button *)createWithFrame:(CGRect)frame
    andTitleString_stateNoraml:(NSString *)titleStr_stateNoraml
andAttributedString_stateNoraml:(NSAttributedString *)attributedString_stateNoraml
     andTitleColor_stateNoraml:(UIColor *)color_stateNoraml
                  andTitleFont:(UIFont *)font
            andBackGroundColor:(UIColor *)backColor
                      andImage:(UIImage *)image
            andBackGroundImage:(UIImage *)backGroundImage
                        inView:(UIView *)view;

@end
