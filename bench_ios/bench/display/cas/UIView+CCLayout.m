//
//  UIView+CCLayout.m
//  bench_ios
//
//  Created by gwh on 2018/7/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIView+CCLayout.h"

@implementation UIView (CCLayout)

- (void)updateLayout_simulator{
    [self updateCas:0];
    typedef void (^successBlock)(id atom);
    successBlock block = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(self.cas_styleClass));
    block(self);
}

- (void)updateLayout_device{
    [self updateCas:1];
    typedef void (^successBlock)(id atom);
    successBlock block = objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(self.cas_styleClass));
    block(self);
}

- (void)updateLayout{
#if TARGET_IPHONE_SIMULATOR
    if ([self stopCas]) {
        return;
    }
    [self updateLayout_simulator];
#else
    [self updateLayout_device];
#endif
}

- (void)updateCas:(int)type{
    float width;
    float height;
    NSString *widthSameAs;
    NSString *heightSameAs;
    NSString *widthSameAsParent;
    NSString *heightSameAsParent;
    
    float marginTop;
    float marginBottom;
    float marginLeft;
    float marginRight;
    
    NSString *above;
    NSString *below;
    NSString *toRightOf;
    NSString *toLeftOf;
    
    NSString *alignTop;
    NSString *alignBottom;
    NSString *alignLeft;
    NSString *alignRight;
    
    NSString *alignParentTop;
    NSString *alignParentBottom;
    NSString *alignParentLeft;
    NSString *alignParentRight;
    
    if (type==0) {//simulator
        width=self.cas_size.width;
        height=self.cas_size.height;
        widthSameAs=self.cas_widthSameAs;
        heightSameAs=self.cas_heightSameAs;
        widthSameAsParent=self.cas_widthSameAsParent;
        heightSameAsParent=self.cas_heightSameAsParent;
        
        marginTop=self.cas_margin.top;
        marginBottom=self.cas_margin.bottom;
        marginLeft=self.cas_margin.left;
        marginRight=self.cas_margin.right;
        
        above=self.cas_above;
        below=self.cas_below;
        toRightOf=self.cas_toRightOf;
        toLeftOf=self.cas_toLeftOf;
        
        alignTop=self.cas_alignTop;
        alignBottom=self.cas_alignBottom;
        alignLeft=self.cas_alignLeft;
        alignRight=self.cas_alignRight;
        
        alignParentTop=self.cas_alignParentTop;
        alignParentBottom=self.cas_alignParentBottom;
        alignParentLeft=self.cas_alignParentLeft;
        alignParentRight=self.cas_alignParentRight;
        
    }else{
        NSDictionary *casDic=[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass];
        width=[casDic[@"width"]floatValue];
        height=[casDic[@"height"]floatValue];
        widthSameAs=casDic[@"widthSameAs"];
        heightSameAs=casDic[@"heightSameAs"];
        
        marginTop=[casDic[@"marginTop"]floatValue];
        marginBottom=[casDic[@"marginBottom"]floatValue];
        marginLeft=[casDic[@"marginLeft"]floatValue];
        marginRight=[casDic[@"marginRight"]floatValue];
        
        above=casDic[@"above"];
        below=casDic[@"below"];
        toRightOf=casDic[@"toRightOf"];
        toLeftOf=casDic[@"toLeftOf"];
        
        alignTop=casDic[@"alignTop"];
        alignBottom=casDic[@"alignBottom"];
        alignLeft=casDic[@"alignLeft"];
        alignRight=casDic[@"alignRight"];
        
        alignParentTop=casDic[@"alignParentTop"];
        alignParentBottom=casDic[@"alignParentBottom"];
        alignParentLeft=casDic[@"alignParentLeft"];
        alignParentRight=casDic[@"alignParentRight"];
        
        NSArray *names_str=@[@"backgroundColor",@"text",@"textColor"];
        for (NSString *name in names_str) {
            NSString *value=[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][name];
            if (value.length<=0) {
                continue;
            }
            if ([name isEqualToString:@"backgroundColor"]) {
                [self setCas_backgroundColor:value];
            }else if ([name isEqualToString:@"text"]){
                [self setCas_text:value];
            }else if ([name isEqualToString:@"textColor"]){
                [self setCas_textColor:value];
            }
        }
        NSArray *names_int=@[@"fontSize"];
        for (NSString *name in names_int) {
            int value=[[CC_ClassyExtend getInstance].ccCasDic[self.cas_styleClass][name]intValue];
            if (value<=0) {
                continue;
            }
            if ([name isEqualToString:@"fontSize"]){
                [self setCas_font:value];
            }
        }
    }
    
    {
        if (width>0) {
            self.width=width;
        }else{
            self.width=self.superview.width-marginLeft-marginRight;
        }
        if (widthSameAs.length>0) {
            UIView *cas_v=[self findViewNamed:widthSameAs];
            self.width=cas_v.width;
        }
        if (widthSameAsParent.length>0) {
            self.width=self.superview.width;
        }
        if (height>0) {
            self.height=height;
        }else{
            self.height=self.superview.height-marginTop-marginBottom;
        }
        if (heightSameAs.length>0) {
            UIView *cas_v=[self findViewNamed:heightSameAs];
            self.height=cas_v.height;
        }
        if (heightSameAsParent.length>0) {
            self.height=self.superview.height;
        }
    }
    
    {
        if (marginLeft>0) {
            self.left=marginLeft;
        }
        if (marginTop>0) {
            self.top=marginTop;
        }
        if (marginRight>0) {
            self.right=self.superview.width-marginRight;
        }
        if (marginBottom>0) {
            self.bottom=self.superview.height-marginBottom;
        }
    }
    
    {
        if (above.length>0) {
            UIView *cas_v=[self findViewNamed:above];
            self.bottom=cas_v.top-marginBottom;
        }
        if (below.length>0) {
            UIView *cas_v=[self findViewNamed:below];
            self.top=cas_v.bottom+marginTop;
        }
        if (toLeftOf.length>0) {
            UIView *cas_v=[self findViewNamed:toLeftOf];
            self.right=cas_v.left+marginRight;
        }
        if (toRightOf.length>0) {
            UIView *cas_v=[self findViewNamed:toRightOf];
            self.left=cas_v.right+marginLeft;
        }
    }
    
    {
        if (alignTop.length>0) {
            UIView *cas_v=[self findViewNamed:alignTop];
            self.top=cas_v.top+marginTop;
        }
        if (alignBottom.length>0) {
            UIView *cas_v=[self findViewNamed:alignBottom];
            self.bottom=cas_v.bottom-marginBottom;
        }
        if (alignLeft.length>0) {
            UIView *cas_v=[self findViewNamed:alignLeft];
            self.left=cas_v.left+marginLeft;
        }
        if (alignRight.length>0) {
            UIView *cas_v=[self findViewNamed:alignRight];
            self.right=cas_v.right-marginRight;
        }
    }
    
    {
        if (alignParentTop.length>0) {
            if ([alignParentTop intValue]>0) {
                self.top=marginTop;
            }
        }
        if (alignParentBottom.length>0) {
            if ([alignParentBottom intValue]>0) {
                self.bottom=self.superview.height-marginBottom;
            }
        }
        if (alignParentLeft.length>0) {
            if ([alignParentLeft intValue]>0) {
                self.left=marginLeft;
            }
        }
        if (alignParentRight.length>0) {
            if ([alignParentRight intValue]>0) {
                self.right=self.superview.width-marginRight;
            }
        }
    }
    
}

- (UIView *)findViewNamed:(NSString *)cas_styleClass{
    UIView *cas_superView=self.superview;
    NSArray *cas_subViews=cas_superView.subviews;
    for (UIView *cas_v in cas_subViews) {
        NSString *findName=cas_v.cas_styleClass;
        if ([findName isEqualToString:cas_styleClass]) {
            return cas_v;
        }
    }
    return nil;
}

@end
