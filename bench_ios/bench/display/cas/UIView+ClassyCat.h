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

@interface UIView (ClassyCat)

@property(nonatomic, assign) int stopCas;

@property(nonatomic, assign) UIEdgeInsets cas_margin;
@property(nonatomic, assign) CGSize cas_size;

/**
 *  控件宽
 *  控件高
 *  控件宽和指定控件id的宽相等
 *  控件高和指定控件id的高相等
 *  控件宽和父视图宽相等 如比父视图少5 填“-5” 大10 填“10” 相等 填“0”
 *  控件高和父视图高相等
 *  控件宽和屏幕宽相等 如比父视图少5 填“-5” 大10 填“10” 相等 填“0”
 *  控件高和屏幕高相等
 */
@property(nonatomic, assign) CGFloat cas_width;
@property(nonatomic, assign) CGFloat cas_height;
@property(nonatomic, retain) NSString *cas_widthSameAs;
@property(nonatomic, retain) NSString *cas_heightSameAs;
@property(nonatomic, retain) NSString *cas_widthSameAsParent;
@property(nonatomic, retain) NSString *cas_heightSameAsParent;
@property(nonatomic, retain) NSString *cas_widthSameAsScreen;
@property(nonatomic, retain) NSString *cas_heightSameAsScreen;

/**
 *  上偏移的值
 *  下偏移的值
 *  左偏移的值
 *  右偏移的值
 */
@property(nonatomic, assign) CGFloat cas_marginTop;
@property(nonatomic, assign) CGFloat cas_marginBottom;
@property(nonatomic, assign) CGFloat cas_marginLeft;
@property(nonatomic, assign) CGFloat cas_marginRight;

/**
 *  背景色
 *  背景图
 *  文字
 *  字体颜色
 *  字体大小
 */
@property(nonatomic, retain) NSString *cas_backgroundColor;
@property(nonatomic, retain) NSString *cas_backgroundImage;
@property(nonatomic, retain) NSString *cas_text;
@property(nonatomic, retain) NSString *cas_textColor;
@property(nonatomic, assign) int cas_font;

/**
 *  控件ID为自定义的控件名
 *  将该控件的底部置于给定ID的控件之上;
 *  将该控件的底部置于给定ID的控件之下;
 *  将该控件的右边缘与给定ID的控件左边缘对齐;
 *  将该控件的左边缘与给定ID的控件右边缘对齐;
 */
@property(nonatomic, retain) NSString *cas_above;
@property(nonatomic, retain) NSString *cas_below;
@property(nonatomic, retain) NSString *cas_toRightOf;
@property(nonatomic, retain) NSString *cas_toLeftOf;

/**
 *  设为@“1”即可
 *  将该控件的顶部边缘与给定ID的顶部边缘对齐;
 *  将该控件的底部边缘与给定ID的底部边缘对齐;
 *  将该控件的左边缘与给定ID的左边缘对齐;
 *  将该控件的右边缘与给定ID的右边缘对齐;
 */
@property(nonatomic, retain) NSString *cas_alignTop;
@property(nonatomic, retain) NSString *cas_alignBottom;
@property(nonatomic, retain) NSString *cas_alignLeft;
@property(nonatomic, retain) NSString *cas_alignRight;

/**
 *  设为@“1”即可
 *  如果为true,将该控件的顶部与其父控件的顶部对齐;
 *  如果为true,将该控件的底部与其父控件的底部对齐;
 *  如果为true,将该控件的左部与其父控件的左部对齐;
 *  如果为true,将该控件的右部与其父控件的右部对齐;
 */
@property(nonatomic, retain) NSString *cas_alignParentTop;
@property(nonatomic, retain) NSString *cas_alignParentBottom;
@property(nonatomic, retain) NSString *cas_alignParentLeft;
@property(nonatomic, retain) NSString *cas_alignParentRight;

///**
// *  控件离顶部设置的内容距离
// *  控件离底部设置的内容距离
// *  控件离左部设置的内容距离
// *  控件离右部设置的内容距离
// */
//@property(nonatomic, retain) NSString *cas_paddingTop;
//@property(nonatomic, retain) NSString *cas_paddingBottom;
//@property(nonatomic, retain) NSString *cas_paddingLeft;
//@property(nonatomic, retain) NSString *cas_paddingRight;

- (int)getStopCas;
/**
 *  停止cas的动态读取
 */
- (void)stopUpdateCas;

@end
