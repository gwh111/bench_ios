//
//  AppButton.m
//  JCZJ
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CC_Button.h"
#import "CC_Share.h"

@interface CC_Button(){
    BOOL delayMark;
}

@end
@implementation CC_Button
@synthesize tappedBlock;

+ (CC_Button *)getModel:(NSString *)name{
    return [CC_ObjectModel getModel:name class:[self class]];
}

+ (NSString *)saveModel:(CC_Button *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    return [CC_ObjectModel saveModel:model name:name des:des hasSetLayer:hasSetLayer];
}

+ (CC_Button *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor img:(UIImage *)image bgimg:(UIImage *)backgroundImage f:(UIFont *)font ta:(UIControlContentHorizontalAlignment)contentHorizontalAlignment uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor img:image bgimg:backgroundImage f:font ta:contentHorizontalAlignment uie:userInteractionEnabled relative:YES];
}

+ (CC_Button *)ccr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor img:(UIImage *)image bgimg:(UIImage *)backgroundImage f:(UIFont *)font ta:(UIControlContentHorizontalAlignment)contentHorizontalAlignment uie:(BOOL)userInteractionEnabled{
    return [self cr:view l:left t:top w:width h:height ts:titleStr ats:attributedStr tc:textColor bgc:backgroundColor img:image bgimg:backgroundImage f:font ta:contentHorizontalAlignment uie:userInteractionEnabled relative:NO];
}

+ (CC_Button *)cr:(UIView *)view l:(float)left t:(float)top w:(float)width h:(float)height ts:(NSString *)titleStr ats:(NSAttributedString *)attributedStr tc:(UIColor *)textColor bgc:(UIColor *)backgroundColor img:(UIImage *)image bgimg:(UIImage *)backgroundImage f:(UIFont *)font ta:(UIControlContentHorizontalAlignment)contentHorizontalAlignment uie:(BOOL)userInteractionEnabled relative:(BOOL)relative{
    CC_Button *newV=[[CC_Button alloc]init];
    [view addSubview:newV];
    if (relative) {
        newV.left=[ccui getRH:left];
        newV.top=[ccui getRH:top];
        newV.width=[ccui getRH:width];
        newV.height=[ccui getRH:height];
    }else{
        newV.left=left;
        newV.top=top;
        newV.width=width;
        newV.height=height;
    }
    
    if (titleStr) {
        [newV setTitle:titleStr forState:UIControlStateNormal];
    }
    if (attributedStr) {
        [newV setAttributedTitle:attributedStr forState:UIControlStateNormal];
    }
    if (textColor) {
        [newV setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        [newV setBackgroundColor:backgroundColor];
    }
    if (image) {
        [newV setImage:image forState:UIControlStateNormal];
    }
    if (backgroundImage) {
        [newV setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    if (font) {
        newV.titleLabel.font=font;
    }
    if (contentHorizontalAlignment) {
        newV.contentHorizontalAlignment=contentHorizontalAlignment;
    }
    newV.userInteractionEnabled=userInteractionEnabled;
    return newV;
}

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

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event{
    if (_forbiddenEnlargeTapFrame) {
        return [super pointInside:point withEvent:event];
    }
    CGRect bounds=self.bounds;
    if (self.width>=44&&self.height>=44) {
        return [super pointInside:point withEvent:event];
    }else if (self.width>=44&&self.height<44){
        bounds=CGRectInset(bounds, 0, -(44-self.height)/2.0);
    }else if (self.width<44&&self.height>=44){
        bounds=CGRectInset(bounds,-(44-self.width)/2.0,0);
    }else if (self.width<44&&self.height<44){
        bounds=CGRectInset(bounds,-(44-self.width)/2.0,-(44-self.height)/2.0);
    }
    return CGRectContainsPoint(bounds, point);
}

@end
