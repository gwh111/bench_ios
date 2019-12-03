//
//  AppButton.h
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "UIButton+CCUI.h"
#import "UIView+CCUI.h"

@interface CC_Button : UIButton <CC_ButtonChainProtocol,CC_ButtonChainExtProtocol>

/**
 default button will enlarge tap frame
 默认会扩大按钮的点击范围 */
@property(nonatomic,assign) int forbiddenEnlargeTapFrame;

@end

@interface CC_Button (CCActions)

/**
 
 点击后执行block,经过time时间间隔后,按钮转为可用状态,主要用于防止连续点击后重复调用tap方法
 
 @param time   按钮下一次可用的时间间隔
 @param block  点击回调
 
 */
- (void)cc_addTappedOnceDelay:(float)time
                    withBlock:(void (^)(CC_Button *btn))block;

/**
 
 点击后执行block,经过time时间间隔后,按钮转为可用状态,主要用于防止连续点击后重复调用tap方法
 
 @param time   按钮下一次可用的时间间隔
 @param block  点击回调
 @param controlEvents 事件
 
 @note 通过该方法可以指定绑定的事件,但对于一个行为中接连触发的事件只会有一次的延时
 比如controlEvents 传 UIControlEventTouchDown | UIControlEventTouchUpInside
 */
- (void)cc_addTappedOnceDelay:(float)time
                    withBlock:(void (^)(CC_Button *btn))block
             forControlEvents:(UIControlEvents)controlEvents;


- (void)bindText:(NSString *)text state:(UIControlState)state;
- (void)bindAttText:(NSAttributedString *)attText state:(UIControlState)state;

@end
