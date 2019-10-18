//
//  CC_AutoLabelGroup.h
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_View.h"
#import "CC_Label.h"
#import "CC_Button.h"

@class CC_LabelGroup;

@protocol CC_LabelGroupDelegate <NSObject>

- (void)labelGroup:(CC_LabelGroup *)group initWithButton:(UIButton *)button;
- (void)labelGroup:(CC_LabelGroup *)group button:(UIButton *)button tappedAtIndex:(NSUInteger)index;
- (void)labelGroupInitFinish:(CC_LabelGroup *)group;

@end

/**
 *  对齐方式
 */
typedef enum : NSUInteger {
    CCLabelAlignmentTypeLeft,
    CCLabelAlignmentTypeCenter,
    CCLabelAlignmentTypeRight,
} CCLabelAlignmentType;

@interface CC_LabelGroup : UIView

@property (nonatomic,assign) id <CC_LabelGroupDelegate>delegate;
// if set, item width is fixed.
@property (nonatomic,assign) float itemWidth;

/**
 *  初始化类型
 *  type 对齐方式
 *  width 最大宽度
 *  stepWidth 两个单元之间间隔
 *  sideX 每行第一个单元x的额外距离
 *  sideY 两行之间间隔
 *  itemHeight 每行的高度
 *  margin 文字距离边框
 */
- (void)updateType:(CCLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight margin:(float)margin;

/**
 *  图片 view的布局
 *  number 总个数
 *  控件是正方形的 高度和宽度相同
 */
- (void)updateNumber:(NSUInteger)number;

/**
 *  更新文本和选中状态
 *  tempArr 文本数组
 *  selected 选中状态数组
 */
- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected;

/**
 *  清空选中
 */
- (void)clearSelect;

/**
 *  更新选中
 */
- (void)updateSelect:(BOOL)select atIndex:(int)index;

@end
