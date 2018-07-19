//
//  UIView+ClassyExtend.h
//  testautoview2
//
//  Created by gwh on 2018/7/16.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Share.h"

/**
 * 设备的类别
 */
typedef enum : NSUInteger {
    CCSimulator,
    CCDevice,
} CCClassyType;

@interface UIView (ClassyExtend)

@property(nonatomic, assign) UIEdgeInsets cas_margin;
@property(nonatomic, assign) CGSize cas_size;

@property(nonatomic, assign) CGFloat cas_width;
@property(nonatomic, assign) CGFloat cas_height;

@property(nonatomic, assign) CGFloat cas_top;
@property(nonatomic, assign) CGFloat cas_left;
@property(nonatomic, assign) CGFloat cas_bottom;
@property(nonatomic, assign) CGFloat cas_right;

@property(nonatomic, retain) NSString *cas_backgroundColor;
@property(nonatomic, retain) NSString *cas_text;
@property(nonatomic, retain) NSString *cas_textColor;
@property(nonatomic, assign) int cas_font;

/**
 *  模拟器时更新动态布局
 */
- (void)updateLayout;
/**
 *  全部刷新 必定刷新
 */
- (void)updateLayout_must;

@end
