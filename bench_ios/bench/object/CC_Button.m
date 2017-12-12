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

+ (CC_Button *)createWithFrame:(CGRect)frame
    andTitleString_stateNoraml:(NSString *)titleStr_stateNoraml
andAttributedString_stateNoraml:(NSAttributedString *)attributedString_stateNoraml
     andTitleColor_stateNoraml:(UIColor *)color_stateNoraml
                  andTitleFont:(UIFont *)font
            andBackGroundColor:(UIColor *)backColor
                      andImage:(UIImage *)image
            andBackGroundImage:(UIImage *)backGroundImage
                        inView:(UIView *)view{
    
    CC_Button *button=[CC_Button buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    if (titleStr_stateNoraml) {
        [button setTitle:titleStr_stateNoraml forState:UIControlStateNormal];
    }
    if (attributedString_stateNoraml) {
        [button setAttributedTitle:attributedString_stateNoraml forState:UIControlStateNormal];
    }
    if (color_stateNoraml) {
        [button setTitleColor:color_stateNoraml forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font=font;
    }
    if (backColor) {
        [button setBackgroundColor:backColor];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (backGroundImage) {
        [button setBackgroundImage:backGroundImage forState:UIControlStateNormal];
    }
    [view addSubview:button];
    return button;
}

- (void)addTappedBlock:(void (^)(UIButton *button))block{
    self.tappedBlock=block;
    [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTappedOnceDelay:(float)time withBlock:(void (^)(UIButton *button))block{
    self.tappedBlock=block;
    _delayTime=time;
    [self addTarget:self action:@selector(tappedDelayMethod:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)tappedDelayMethod:(UIButton *)button{
    tappedBlock(self);
    self.enabled=NO;
    [self performSelector:@selector(buttonTappedWithDelay:) withObject:self afterDelay:_delayTime];
}

- (void)buttonTappedWithDelay:(float)delay{
    self.enabled=YES;
}

@end
