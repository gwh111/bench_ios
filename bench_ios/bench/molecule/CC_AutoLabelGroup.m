//
//  CC_AutoLabelGroup.m
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_AutoLabelGroup.h"

@interface CC_AutoLabelGroup(){
    float maxW;
    float stepW;
    float sX;
    float sY;
    float iH;
    float mg;
    CCAutoLabelAlignmentType altype;
    
    NSArray *tempNameArr;
    NSArray *tempSelectArr;
}
@end

@implementation CC_AutoLabelGroup

static int baseTag=100;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)updateType:(CCAutoLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight margin:(float)margin{
    self.width=width;
    maxW=width;
    stepW=stepWidth;
    sX=sideX;
    sY=sideY;
    iH=itemHeight;
    mg=margin;
    altype=type;
}

- (void)clearSelect{
    NSMutableArray *mutArr=[[NSMutableArray alloc]init];
    for (int i=0; i<tempSelectArr.count; i++) {
        [mutArr addObject:@"0"];
    }
    [self updateLabels:tempNameArr selected:mutArr];
}

- (void)updateSelect:(BOOL)select atIndex:(int)index{
    NSMutableArray *mutArr=[[NSMutableArray alloc]initWithArray:tempSelectArr];
    [mutArr replaceObjectAtIndex:index withObject:@(select)];
    [self updateLabels:tempNameArr selected:mutArr];
}

- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected{
    tempNameArr=tempArr;
    tempSelectArr=selected;
    [self updateLabels:tempArr selected:selected number:0];
}

- (void)updateNumber:(NSUInteger)number{
    [self updateLabels:nil selected:nil number:number];
}

- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected number:(NSUInteger)number{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float x=sX;
    float y=sY;
    int lastLine=0;
    int lastBeginIndex=0;
    int lastRight=0;
    NSUInteger count;
    if (number>0) {
        count=number;
    }else{
        count=tempArr.count;
    }
    for (int i=0; i<count; i++) {
        
        CC_Button *leftBt;
        if (_sampleBt) {
            leftBt=[ccs copyThis:_sampleBt];
        }else{
            leftBt=[[CC_Button alloc]init];
        }
        leftBt.forbiddenEnlargeTapFrame=YES;
        leftBt.cs_dictBackgroundColor=_sampleBt.cs_dictBackgroundColor;
        leftBt.height=iH;
        [self addSubview:leftBt];
        leftBt.tag=baseTag+i;
        if (selected) {
            leftBt.selected=[selected[i] intValue];
            [leftBt setccSelected:[selected[i] intValue]];
        }
        [leftBt setTitle:[NSString stringWithFormat:@"%@",tempArr[i]] forState:UIControlStateNormal];
        [leftBt.titleLabel sizeToFit];
        float w=leftBt.titleLabel.width+mg;
        if (number>0) {
            w=iH;
        }
        if (x+stepW+w>maxW) {
            x=sX;
            y=y+iH+sY;
            
            if (altype==CCAutoLabelAlignmentTypeCenter) {
                float needMove=(maxW-lastRight-sX)/2;
                for (int m=lastBeginIndex; m<i; m++) {
                    CC_Button *button=[self viewWithTag:baseTag+m];
                    button.left=button.left+needMove;
                }
            }
            lastLine++;
            lastBeginIndex=i;
        }else{
            if (i>0) {
                x=x+stepW;
            }
        }
        if (i>0) {
            lastRight=x+stepW+w;//最右的坐标
        }else{
            lastRight=x+w;//最右的坐标
        }
        leftBt.left=x;
        leftBt.top=y;
        leftBt.width=w;
        x=x+w;
        [leftBt addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            if ([self.delegate respondsToSelector:@selector(autoLabelGroup:btTappedAtIndex:withBt:)]) {
                [self.delegate autoLabelGroup:self btTappedAtIndex:i withBt:button];
            }
        }];
        if ([self.delegate respondsToSelector:@selector(autoLabelGroup:btFinishInit:)]) {
            [self.delegate autoLabelGroup:self btFinishInit:leftBt];
        }
    }
    
    if (altype==CCAutoLabelAlignmentTypeCenter) {
        float needMove=(maxW-lastRight-sX)/2;
        for (int m=lastBeginIndex; m<count; m++) {
            CC_Button *button=[self viewWithTag:baseTag+m];
            button.left=button.left+needMove;
        }
    }
    
    self.height=y+iH+sY;
    if ([self.delegate respondsToSelector:@selector(autoLabelGroupUpdateFinish:)]) {
        [self.delegate autoLabelGroupUpdateFinish:self];
    }
}

@end
