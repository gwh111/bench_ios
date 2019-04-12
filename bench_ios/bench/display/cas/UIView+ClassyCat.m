//
//  UIView+ClassyExtend.m
//  testautoview2
//
//  Created by gwh on 2018/7/16.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "UIView+ClassyCat.h"
#import <objc/runtime.h>
#import "CC_UIAtom.h"
#import "UIView+CCLayout.h"

@implementation UIView (ClassyCat)

+ (void)load {
    [super load];
    
    CASObjectClassDescriptor *objectClassDescriptor = [[CASStyler defaultStyler] objectClassDescriptorForClass:UIView.class];
    objectClassDescriptor.propertyKeyAliases =@{
                                                @"width"    : @cas_propertykey(UIView, cas_width),
                                                @"height"   : @cas_propertykey(UIView, cas_height),
                                                @"widthSameAs"    : @cas_propertykey(UIView, cas_widthSameAs),
                                                @"heightSameAs"   : @cas_propertykey(UIView, cas_heightSameAs),
                                                @"widthSameAsParent"    : @cas_propertykey(UIView, cas_widthSameAsParent),
                                                @"heightSameAsParent"   : @cas_propertykey(UIView, cas_heightSameAsParent),
                                                @"widthSameAsScreen"    : @cas_propertykey(UIView, cas_widthSameAsScreen),
                                                @"heightSameAsScreen"   : @cas_propertykey(UIView, cas_heightSameAsScreen),
                                                
                                                @"marginTop"      : @cas_propertykey(UIView, cas_marginTop),
                                                @"marginLeft"     : @cas_propertykey(UIView, cas_marginLeft),
                                                @"marginBottom"   : @cas_propertykey(UIView, cas_marginBottom),
                                                @"marginRight"    : @cas_propertykey(UIView, cas_marginRight),
                                                
                                                @"backgroundColor"      : @cas_propertykey(UIView, cas_backgroundColor),
                                                @"backgroundImage"      : @cas_propertykey(UIView, cas_backgroundImage),
                                                @"text"     : @cas_propertykey(UIView, cas_text),
                                                @"textColor"       : @cas_propertykey(UIView, cas_textColor),
                                                @"fontSize"     : @cas_propertykey(UIView, cas_font),
                                                
                                                @"above"     : @cas_propertykey(UIView, cas_above),
                                                @"below"     : @cas_propertykey(UIView, cas_below),
                                                @"toRightOf"     : @cas_propertykey(UIView, cas_toRightOf),
                                                @"toLeftOf"     : @cas_propertykey(UIView, cas_toLeftOf),
                                                
                                                @"alignTop"     : @cas_propertykey(UIView, cas_alignTop),
                                                @"alignBottom"     : @cas_propertykey(UIView, cas_alignBottom),
                                                @"alignLeft"     : @cas_propertykey(UIView, cas_alignLeft),
                                                @"alignRight"     : @cas_propertykey(UIView, cas_alignRight),
                                                
                                                @"alignParentTop"     : @cas_propertykey(UIView, cas_alignParentTop),
                                                @"alignParentBottom"     : @cas_propertykey(UIView, cas_alignParentBottom),
                                                @"alignParentLeft"     : @cas_propertykey(UIView, cas_alignParentLeft),
                                                @"alignParentRight"     : @cas_propertykey(UIView, cas_alignParentRight),
                                                
                                                
                                                };
}

- (int)getStopCas{
    return [self stopCas];
}
- (int)stopCas{
    return [objc_getAssociatedObject(self, @selector(stopCas)) intValue];
}

- (void)setStopCas:(int)stopCas{
    objc_setAssociatedObject(self, @selector(stopCas), ccstr(@"%d",stopCas), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)cas_margin{
    return [(NSValue *) objc_getAssociatedObject(self, @selector(cas_margin)) UIEdgeInsetsValue];
}

- (void)setCas_margin:(UIEdgeInsets)cas_margin{
    NSValue *value = [NSValue valueWithUIEdgeInsets:cas_margin];
    objc_setAssociatedObject(self, @selector(cas_margin), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self updateLayout];
}

- (CGSize)cas_size{
    return [(NSValue *) objc_getAssociatedObject(self, @selector(cas_size)) CGSizeValue];
}

- (void)setCas_size:(CGSize)cas_size{
    NSValue *value = [NSValue valueWithCGSize:cas_size];
    objc_setAssociatedObject(self, @selector(cas_size), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self updateLayout];
}

- (CGFloat)cas_width{
    return self.cas_size.width;
}

- (void)setCas_width:(CGFloat)cas_width{
    CGSize currentSize = self.cas_size;
    currentSize.width = [ccui getRH:cas_width];
    self.cas_size=currentSize;
    
    [self updateLayout];
}

- (CGFloat)cas_height{
    return self.cas_size.height;
}

- (void)setCas_height:(CGFloat)cas_height{
    CGSize currentSize = self.cas_size;
    currentSize.height = [ccui getRH:cas_height];
    self.cas_size=currentSize;
    
    [self updateLayout];
}

- (NSString *)cas_widthSameAs{
    return objc_getAssociatedObject(self, @selector(cas_widthSameAs));
}

- (void)setCas_widthSameAs:(NSString *)cas_widthSameAs{
    objc_setAssociatedObject(self, @selector(cas_widthSameAs), cas_widthSameAs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (NSString *)cas_heightSameAs{
    return objc_getAssociatedObject(self, @selector(cas_heightSameAs));
}

- (void)setCas_heightSameAs:(NSString *)cas_heightSameAs{
    objc_setAssociatedObject(self, @selector(cas_heightSameAs), cas_heightSameAs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (NSString *)cas_widthSameAsParent{
    return objc_getAssociatedObject(self, @selector(cas_widthSameAsParent));
}

- (void)setCas_widthSameAsParent:(NSString *)cas_widthSameAsParent{
    objc_setAssociatedObject(self, @selector(cas_widthSameAsParent), cas_widthSameAsParent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (NSString *)cas_heightSameAsParent{
    return objc_getAssociatedObject(self, @selector(cas_heightSameAsParent));
}

- (void)setCas_heightSameAsParent:(NSString *)cas_heightSameAsParent{
    objc_setAssociatedObject(self, @selector(cas_heightSameAsParent), cas_heightSameAsParent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (NSString *)cas_widthSameAsScreen{
    return objc_getAssociatedObject(self, @selector(cas_widthSameAsScreen));
}

- (void)setCas_widthSameAsScreen:(NSString *)cas_widthSameAsScreen{
    objc_setAssociatedObject(self, @selector(cas_widthSameAsScreen), cas_widthSameAsScreen, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (NSString *)cas_heightSameAsScreen{
    return objc_getAssociatedObject(self, @selector(cas_heightSameAsScreen));
}

- (void)setCas_heightSameAsScreen:(NSString *)cas_heightSameAsScreen{
    objc_setAssociatedObject(self, @selector(cas_heightSameAsScreen), cas_heightSameAsScreen, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (CGFloat)cas_marginTop{
    return self.cas_margin.top;
}

- (void)setCas_marginTop:(CGFloat)cas_top{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.top = [ccui getRH:cas_top];
    self.cas_margin = currentMargin;
    self.top=cas_top;
    
    [self updateLayout];
}

- (CGFloat)cas_marginLeft{
    return self.cas_margin.left;
}

- (void)setCas_marginLeft:(CGFloat)cas_left{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.left = [ccui getRH:cas_left];
    self.cas_margin = currentMargin;
    self.left=cas_left;
    
    [self updateLayout];
}

- (CGFloat)cas_marginBottom{
    return self.cas_margin.bottom;
}

- (void)setCas_marginBottom:(CGFloat)cas_bottom{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.bottom = [ccui getRH:cas_bottom];
    self.cas_margin = currentMargin;
    self.bottom=cas_bottom;
    
    [self updateLayout];
}

- (CGFloat)cas_marginRight{
    return self.cas_margin.right;
}

- (void)setCas_marginRight:(CGFloat)cas_right{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.right = [ccui getRH:cas_right];
    self.cas_margin = currentMargin;
    self.right=cas_right;
    
    [self updateLayout];
}

- (NSString *)cas_backgroundColor{
    return self.cas_backgroundColor;
}

- (void)setCas_backgroundColor:(NSString *)cas_backgroundColor{
    self.backgroundColor=[CC_Convert colorwithHexString:cas_backgroundColor];
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout];
#endif
}

- (NSString *)cas_backgroundImage{
    return self.cas_backgroundImage;
}

- (void)setCas_backgroundImage:(NSString *)cas_backgroundImage{
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *atom=(UIButton *)self;
        [atom setBackgroundImage:[UIImage imageNamed:cas_backgroundImage] forState:UIControlStateNormal];
    }else if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *atom=(UIImageView *)self;
        atom.image=[UIImage imageNamed:cas_backgroundImage];
    }
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout];
#endif
}

- (NSString *)cas_text{
    return self.cas_text;
}

- (void)setCas_text:(NSString *)cas_text{
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *atom=(UIButton *)self;
        [atom setTitle:cas_text forState:UIControlStateNormal];
    }else if ([self isKindOfClass:[UILabel class]]) {
        UILabel *atom=(UILabel *)self;
        [atom setText:cas_text];
    }else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *atom=(UITextView *)self;
        [atom setText:cas_text];
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *atom=(UITextField *)self;
        [atom setText:cas_text];
    }
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout];
#endif
}

- (NSString *)cas_textColor{
    return self.cas_textColor;
}

- (void)setCas_textColor:(NSString *)cas_backgroundColor{
    UIColor *newC=[CC_Convert colorwithHexString:cas_backgroundColor];
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *atom=(UIButton *)self;
        [atom setTitleColor:newC forState:UIControlStateNormal];
    }else if ([self isKindOfClass:[UILabel class]]) {
        UILabel *atom=(UILabel *)self;
        [atom setTextColor:newC];
    }else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *atom=(UITextView *)self;
        [atom setTextColor:newC];
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *atom=(UITextField *)self;
        [atom setTextColor:newC];
    }
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout];
#endif
}

- (int)cas_font{
    return self.cas_font;
}

- (void)setCas_font:(int)cas_font{
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *atom=(UIButton *)self;
        atom.titleLabel.font=[ccui getRFS:cas_font];
    }else if ([self isKindOfClass:[UILabel class]]) {
        UILabel *atom=(UILabel *)self;
        atom.font=[ccui getRFS:cas_font];
    }else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *atom=(UITextView *)self;
        atom.font=[ccui getRFS:cas_font];
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *atom=(UITextField *)self;
        atom.font=[ccui getRFS:cas_font];
    }
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout];
#endif
}

#pragma mark 在控件哪一边
- (NSString *)cas_above{
    return objc_getAssociatedObject(self, @selector(cas_above));
}
- (void)setCas_above:(NSString *)cas_above{
    objc_setAssociatedObject(self, @selector(cas_above), cas_above, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_below];
    [self resetCasValue:self.cas_alignTop];
    [self resetCasValue:self.cas_alignParentTop];
    [self updateLayout];
}
- (NSString *)cas_below{
    return objc_getAssociatedObject(self, @selector(cas_below));
}
- (void)setCas_below:(NSString *)cas_below{
    objc_setAssociatedObject(self, @selector(cas_below), cas_below, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignTop];
    [self resetCasValue:self.cas_alignParentTop];
    [self updateLayout];
}
- (NSString *)cas_toLeftOf{
    return objc_getAssociatedObject(self, @selector(cas_toLeftOf));
}
- (void)setCas_toLeftOf:(NSString *)cas_toLeftOf{
    objc_setAssociatedObject(self, @selector(cas_toLeftOf), cas_toLeftOf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_toRightOf];
    [self resetCasValue:self.cas_alignRight];
    [self resetCasValue:self.cas_alignParentRight];
    [self updateLayout];
}
- (NSString *)cas_toRightOf{
    return objc_getAssociatedObject(self, @selector(cas_toRightOf));
}
- (void)setCas_toRightOf:(NSString *)cas_toRightOf{
    objc_setAssociatedObject(self, @selector(cas_toRightOf), cas_toRightOf, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignRight];
    [self resetCasValue:self.cas_alignParentRight];
    [self updateLayout];
}

#pragma mark 和控件哪边对齐
- (NSString *)cas_alignTop{
    return objc_getAssociatedObject(self, @selector(cas_alignTop));
}
- (void)setCas_alignTop:(NSString *)cas_alignTop{
    objc_setAssociatedObject(self, @selector(cas_alignTop), cas_alignTop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignBottom];
    [self resetCasValue:self.cas_alignParentTop];
    [self updateLayout];
}
- (NSString *)cas_alignBottom{
    return objc_getAssociatedObject(self, @selector(cas_alignBottom));
}
- (void)setCas_alignBottom:(NSString *)cas_alignBottom{
    objc_setAssociatedObject(self, @selector(cas_alignBottom), cas_alignBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignParentTop];
    [self updateLayout];
}
- (NSString *)cas_alignLeft{
    return objc_getAssociatedObject(self, @selector(cas_alignLeft));
}
- (void)setCas_alignLeft:(NSString *)cas_alignLeft{
    objc_setAssociatedObject(self, @selector(cas_alignLeft), cas_alignLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignRight];
    [self resetCasValue:self.cas_alignParentLeft];
    [self updateLayout];
}
- (NSString *)cas_alignRight{
    return objc_getAssociatedObject(self, @selector(cas_alignRight));
}
- (void)setCas_alignRight:(NSString *)cas_alignRight{
    objc_setAssociatedObject(self, @selector(cas_alignRight), cas_alignRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignParentLeft];
    [self updateLayout];
}

#pragma mark 和父控件哪边对齐
- (NSString *)cas_alignParentTop{
    return objc_getAssociatedObject(self, @selector(cas_alignParentTop));
}
- (void)setCas_alignParentTop:(NSString *)cas_alignParentTop{
    objc_setAssociatedObject(self, @selector(cas_alignParentTop), cas_alignParentTop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignParentBottom];
    [self updateLayout];
}
- (NSString *)cas_alignParentBottom{
    return objc_getAssociatedObject(self, @selector(cas_alignParentBottom));
}
- (void)setCas_alignParentBottom:(NSString *)cas_alignParentBottom{
    objc_setAssociatedObject(self, @selector(cas_alignParentBottom), cas_alignParentBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}
- (NSString *)cas_alignParentLeft{
    return objc_getAssociatedObject(self, @selector(cas_alignParentLeft));
}
- (void)setCas_alignParentLeft:(NSString *)cas_alignParentLeft{
    objc_setAssociatedObject(self, @selector(cas_alignParentLeft), cas_alignParentLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self resetCasValue:self.cas_alignParentRight];
    [self updateLayout];
}
- (NSString *)cas_alignParentRight{
    return objc_getAssociatedObject(self, @selector(cas_alignParentRight));
}
- (void)setCas_alignParentRight:(NSString *)cas_alignParentRight{
    objc_setAssociatedObject(self, @selector(cas_alignParentRight), cas_alignParentRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLayout];
}

- (void)stopUpdateCas{
    [self setStopCas:1];
    [self updateLayout_device];
}

- (void)resetCasValue:(id)value{
    if ([value isKindOfClass:[NSString class]]) {
        value=nil;
    }else{
        value=0;
    }
}



@end





