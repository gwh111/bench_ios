//
//  CC_AutoLabelGroup.h
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Share.h"

@protocol CC_AutoLabelGroupDelegate <NSObject>
- (void)buttonTappedwithIndex:(int)index button:(UIButton *)button;
@end

/**
 *  对齐方式
 */
typedef enum : NSUInteger {
    Left,
    Center,
    Right,
} CCAutoLabelAlignmentType;

@interface CC_AutoLabelGroup : UIView

/**
 *  单元按钮属性 每个单元按照这个为样本
 */
@property(nonatomic,strong) CC_Button *sampleBt;
@property (nonatomic, weak) id <CC_AutoLabelGroupDelegate> delegate;

/**
 *  初始化类型
 *  type 对齐方式
 *  width 最大宽度
 *  stepWidth 两个单元之间间隔
 *  sideX 每行第一个单元x的额外距离
 *  sideY 两行之间间隔
 *  itemHeight 每行的高度
 */
- (void)updateType:(CCAutoLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight;

/**
 *  更新文本和选中状态
 *  tempArr 文本数组
 *  selected 选中状态数组
 */
- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected;

@end
