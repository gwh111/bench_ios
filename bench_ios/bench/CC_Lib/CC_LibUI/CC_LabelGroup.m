//
//  CC_AutoLabelGroup.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_LabelGroup.h"

@interface CC_LabelGroup(){
    float maxW;
    float stepW;
    float sX;
    float sY;
    float iH;
    float mg;
    CCLabelAlignmentType altype;
    
    NSArray *tempNameArr;
    NSArray *tempSelectArr;
}

@property (nonatomic, strong) void (^btnInitBlock)(CC_Button *btn,CC_LabelGroup *group);
@property (nonatomic, strong) void (^groupInitBlock)(CC_LabelGroup *group);
@property (nonatomic, strong) void (^btnTappedBlock)(CC_Button *btn, NSUInteger index, CC_LabelGroup *group);

@end

@implementation CC_LabelGroup

static int baseTag=100;

- (void)addItemInitBlock:(void(^)(CC_Button *btn,CC_LabelGroup *group))block {
    _btnInitBlock = block;
}

- (void)addGroupUpdateBlock:(void(^)(CC_LabelGroup *group))block {
    _groupInitBlock = block;
}

- (void)addSelectBlock:(void(^)(CC_Button *btn, NSUInteger index, CC_LabelGroup *group))block {
    _btnTappedBlock = block;
}

- (void)updateType:(CCLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight margin:(float)margin{
    self.width = width;
    maxW = width;
    stepW = stepWidth;
    sX = sideX;
    sY = sideY;
    iH = itemHeight;
    mg = margin;
    altype = type;
}

- (void)clearSelect{
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < tempSelectArr.count; i++) {
        [mutArr addObject:@"0"];
    }
    [self updateLabels:tempNameArr selected:mutArr];
}

- (void)updateSelect:(BOOL)select atIndex:(NSUInteger)index{
    NSMutableArray *mutArr = [[NSMutableArray alloc]initWithArray:tempSelectArr];
    [mutArr replaceObjectAtIndex:index withObject:@(select)];
    [self updateLabels:tempNameArr selected:mutArr];
}

- (void)updateLabels:(NSArray *)tempArr selectedIndex:(NSUInteger)index {
    tempNameArr = tempArr;
    NSMutableArray *selects = NSMutableArray.new;
    for (int i = 0; i < tempArr.count; i++) {
        if (i == index) {
            [selects addObject:@(1)];
        } else {
            [selects addObject:@(0)];
        }
    }
    tempSelectArr = selects;
    [self updateLabels:tempArr selected:selects number:0];
}

- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected{
    tempNameArr = tempArr;
    tempSelectArr = selected;
    [self updateLabels:tempArr selected:selected number:0];
}

- (void)updateNumber:(NSUInteger)number{
    [self updateLabels:nil selected:nil number:number];
}

- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected number:(NSUInteger)number{
    
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float x = sX;
    float y = sY;
    int lastLine = 0;
    int lastBeginIndex = 0;
    int lastRight = 0;
    NSUInteger count;
    if (number > 0) {
        count = number;
    }else{
        count = tempArr.count;
    }
    for (int i = 0; i < count; i++) {
        
        CC_Button *button = [self viewWithTag:baseTag + i];
        if (!button) {
            button = [CC_Base.shared cc_init:CC_Button.class];
        }
        button.forbiddenEnlargeTapFrame = YES;
        button.height = iH;
        [self addSubview:button];
        button.tag = baseTag + i;
        if (selected) {
            button.selected = [selected[i] intValue];
        }
        [button setTitle:[NSString stringWithFormat:@"%@",tempArr[i]] forState:UIControlStateNormal];
        [button.titleLabel sizeToFit];
        float w = button.titleLabel.width + mg;
        if (number>0) {
            w = iH;
        }
        if (_itemWidth > 0) {
            w = _itemWidth;
        }
        if (x + stepW + w > maxW) {
            x = sX;
            y = y + iH + sY;
            
            if (altype == CCLabelAlignmentTypeCenter) {
                float needMove = (maxW - lastRight - sX) / 2;
                for (int m = lastBeginIndex; m < i; m++) {
                    CC_Button *button = [self viewWithTag:baseTag+m];
                    button.left = button.left+needMove;
                }
            }
            lastLine++;
            lastBeginIndex = i;
        }else{
            if (i > 0) {
                x = x + stepW;
            }
        }
        if (i > 0) {
            lastRight = x + stepW + w;//最右的坐标
        }else{
            lastRight = x + w;//最右的坐标
        }
        button.left = x;
        button.top = y;
        button.width = w;
        x = x + w;
        
        [button cc_tappedInterval:0.1 withBlock:^(id  _Nonnull view) {
            if ([self.delegate respondsToSelector:@selector(labelGroup:button:tappedAtIndex:)]) {
                [self.delegate labelGroup:self button:button tappedAtIndex:i];
            }
            if (self.btnTappedBlock) {
                self.btnTappedBlock(button,i,self);
            }
        }];
        if ([self.delegate respondsToSelector:@selector(labelGroup:initWithButton:)]) {
            [self.delegate labelGroup:self initWithButton:button];
        }
        if (_btnInitBlock) {
            _btnInitBlock(button,self);
        }
    }
    
    // 移除多的
    NSUInteger from = count;
    CC_Button *removeBtn = [self viewWithTag:baseTag + from];
    while (removeBtn) {
        [removeBtn removeFromSuperview];
        from++;
        removeBtn = [self viewWithTag:baseTag + from];
    }
    
    if (altype == CCLabelAlignmentTypeCenter) {
        float needMove = (maxW - lastRight - sX)/2;
        for (int m = lastBeginIndex; m < count; m++) {
            CC_Button *button = [self viewWithTag:baseTag + m];
            button.left = button.left + needMove;
        }
    }
    
    self.height = y + iH + sY;
    if ([self.delegate respondsToSelector:@selector(labelGroupInitFinish:)]) {
        [self.delegate labelGroupInitFinish:self];
    }
    if (_groupInitBlock) {
        _groupInitBlock(self);
    }
}

@end
