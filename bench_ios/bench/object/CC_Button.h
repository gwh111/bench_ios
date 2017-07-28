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

/** 防止连续点击后重复调用tap方法*/
- (void)addTappedBlock:(void (^)(UIButton *button))block;

@end
