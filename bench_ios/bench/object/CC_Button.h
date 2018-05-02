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

/**
 * 防止连续点击后重复调用tap方法
 */
- (void)addTappedBlock:(void (^)(UIButton *button))block;

/**
 * 防止连续点击后重复调用tap方法
 * time 防止重复 第二次点击可执行需要的时间
 */
- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block;

@end
