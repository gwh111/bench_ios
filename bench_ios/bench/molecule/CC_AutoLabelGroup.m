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
    CCAutoLabelAlignmentType altype;
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

- (void)updateType:(CCAutoLabelAlignmentType)type width:(float)width stepWidth:(float)stepWidth sideX:(float)sideX sideY:(float)sideY itemHeight:(float)itemHeight{
    self.width=width;
    maxW=width;
    stepW=stepWidth;
    sX=sideX;
    sY=sideY;
    iH=itemHeight;
    altype=type;
}

- (void)updateLabels:(NSArray *)tempArr selected:(NSArray *)selected{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float x=sX;
    float y=sY;
    int lastLine=0;
    int lastBeginIndex=0;
    int lastRight=0;
    for (int i=0; i<tempArr.count; i++) {
    
        CC_Button *leftBt=[ccs copyThis:_sampleBt];
        leftBt.cs_dictBackgroundColor=_sampleBt.cs_dictBackgroundColor;
        leftBt.height=iH;
        [self addSubview:leftBt];
        leftBt.tag=baseTag+i;
        if (selected) {
            leftBt.selected=[selected[i] intValue];
        }
        [leftBt setTitle:tempArr[i] forState:UIControlStateNormal];
        [leftBt.titleLabel sizeToFit];
        float w=leftBt.titleLabel.width;
        if (x+stepW+w>maxW) {
            x=sX;
            y=y+iH+sY;
            
            if (altype==Center) {
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
            [self.delegate buttonTappedwithIndex:i button:button];
        }];
    }
    
    if (altype==Center) {
        float needMove=(maxW-lastRight-sX)/2;
        for (int m=lastBeginIndex; m<tempArr.count; m++) {
            CC_Button *button=[self viewWithTag:baseTag+m];
            button.left=button.left+needMove;
        }
    }
    
    self.height=y+iH+sY;
}

@end
