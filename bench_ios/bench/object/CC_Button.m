//
//  AppButton.m
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Button.h"

@interface CC_Button(){
    BOOL delayMark;
}

@end
@implementation CC_Button
@synthesize tappedBlock;

- (void)addTappedBlock:(void (^)(UIButton *button))block{
    self.tappedBlock=block;
    [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapped:(UIButton *)button{
    
    if (delayMark==0) {
        tappedBlock(button);
        delayMark=1;
        [self performSelector:@selector(tappedMethod:) withObject:button afterDelay:.2];
    }
}

- (void)tappedMethod:(UIButton *)button{
    delayMark=0;
}

- (void)buttonTappedWithDelay:(float)delay{
    
}

@end
