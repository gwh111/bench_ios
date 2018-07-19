//
//  UIView+ClassyExtend.m
//  testautoview2
//
//  Created by gwh on 2018/7/16.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "UIView+ClassyExtend.h"
#import <objc/runtime.h>
#import "CC_UIAtom.h"

@implementation UIView (ClassyExtend)

+ (void)load {
    [super load];
    
    CASObjectClassDescriptor *objectClassDescriptor = [[CASStyler defaultStyler] objectClassDescriptorForClass:UIView.class];
    objectClassDescriptor.propertyKeyAliases =@{
    @"width"    : @cas_propertykey(UIView, cas_width),
    @"height"   : @cas_propertykey(UIView, cas_height),
    @"top"      : @cas_propertykey(UIView, cas_top),
    @"left"     : @cas_propertykey(UIView, cas_left),
    @"bottom"   : @cas_propertykey(UIView, cas_bottom),
    @"right"    : @cas_propertykey(UIView, cas_right),
    @"bgc"      : @cas_propertykey(UIView, cas_backgroundColor),
    @"text"     : @cas_propertykey(UIView, cas_text),
    @"tc"       : @cas_propertykey(UIView, cas_textColor),
    @"font"     : @cas_propertykey(UIView, cas_font),
    };
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
    #ifdef TARGET_IPHONE_SIMULATOR
    return self.cas_size.width;
    #else
    return [[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"width"]floatValue];
    #endif
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

- (CGFloat)cas_top{
    return self.cas_margin.top;
}

- (void)setCas_top:(CGFloat)cas_top{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.top = [ccui getRH:cas_top];
    self.cas_margin = currentMargin;
    self.top=cas_top;
    
    [self updateLayout];
}

- (CGFloat)cas_left{
    return self.cas_margin.left;
}

- (void)setCas_left:(CGFloat)cas_left{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.left = [ccui getRH:cas_left];
    self.cas_margin = currentMargin;
    self.left=cas_left;
    
    [self updateLayout];
}

- (CGFloat)cas_bottom{
    return self.cas_margin.bottom;
}

- (void)setCas_bottom:(CGFloat)cas_bottom{
    UIEdgeInsets currentMargin = self.cas_margin;
    currentMargin.bottom = [ccui getRH:cas_bottom];
    self.cas_margin = currentMargin;
    self.bottom=cas_bottom;
    
    [self updateLayout];
}

- (CGFloat)cas_right{
    return self.cas_margin.right;
}

- (void)setCas_right:(CGFloat)cas_right{
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
    self.backgroundColor=[convert colorwithHexString:cas_backgroundColor];
    [self updateLayout];
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
    [self updateLayout];
}

- (NSString *)cas_textColor{
    return self.cas_textColor;
}

- (void)setCas_textColor:(NSString *)cas_backgroundColor{
    UIColor *newC=[convert colorwithHexString:cas_backgroundColor];
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
    [self updateLayout];
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
    [self updateLayout];
}

- (void)updateLayout_must{
    
#if TARGET_IPHONE_SIMULATOR
    [self simulatorCas];
#else
    [self deviceCas];
#endif
    
    typedef void (^successBlock)(id atom);
    successBlock block = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(self.cas_styleClass));
    block(self);
}

- (void)updateLayout{
    
#if TARGET_IPHONE_SIMULATOR
    [self updateLayout_must];
#else
#endif
    
}

- (void)deviceCas{
    float width=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"width"]floatValue];
    float height=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"height"]floatValue];
    float top=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"top"]floatValue];
    float left=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"left"]floatValue];
    float right=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"right"]floatValue];
    float bottom=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][@"bottom"]floatValue];
    if (width>0) {
        self.width=width;
    }else{
        self.width=self.superview.width-left-right;
    }
    if (height>0) {
        self.height=height;
    }else{
        self.height=self.superview.height-top-bottom;
    }
    if (left>0) {
        self.left=left;
    }
    if (top>0) {
        self.top=top;
    }
    if (right>0) {
        self.right=self.superview.width-right;
    }
    if (bottom>0) {
        self.bottom=self.superview.height-bottom;
    }
    
    NSArray *names_str=@[@"bgc",@"text",@"tc"];
    for (NSString *name in names_str) {
        NSString *value=[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][name];
        if (value.length<=0) {
            continue;
        }
        if ([name isEqualToString:@"bgc"]) {
            [self setCas_backgroundColor:value];
        }else if ([name isEqualToString:@"text"]){
            [self setCas_text:value];
        }else if ([name isEqualToString:@"tc"]){
            [self setCas_textColor:value];
        }
    }
    NSArray *names_int=@[@"font"];
    for (NSString *name in names_int) {
        int value=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][name]intValue];
        if (value<=0) {
            continue;
        }
        if ([name isEqualToString:@"font"]){
            [self setCas_font:value];
        }
    }
}

- (void)simulatorCas{
    if (self.cas_size.width>0) {
        self.width=self.cas_size.width;
    }else{
        self.width=self.superview.width-self.cas_margin.left-self.cas_margin.right;
    }
    if (self.cas_size.height>0) {
        self.height=self.cas_size.height;
    }else{
        self.height=self.superview.height-self.cas_margin.top-self.cas_margin.bottom;
    }
    if (self.cas_margin.left>0) {
        self.left=self.cas_margin.left;
    }
    if (self.cas_margin.top>0) {
        self.top=self.cas_margin.top;
    }
    if (self.cas_margin.right>0) {
        self.right=self.superview.width-self.cas_margin.right;
    }
    if (self.cas_margin.bottom>0) {
        self.bottom=self.superview.height-self.cas_margin.bottom;
    }
}

@end





