//
//  CC_UIAtom.m
//  testautoview
//
//  Created by gwh on 2018/7/12.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "CC_UIAtom.h"

@implementation CC_UIAtom

+ (id)initAt:(UIView *)view name:(NSString *)name type:(CCAtomType)type finishBlock:(void (^)(id atom))block{
    
    CC_UIAtom *varView=[[CC_UIAtom alloc]init];
    varView.atomType=type;
    varView.atomName=name;
    switch (type) {
        case CCView:
        {
            CC_View *atom=[[CC_View alloc]init];
            atom.cas_styleClass = name;
            varView.atom=atom;
            break;
        }
        case CCLabel:
        {
            CC_Label *atom=[[CC_Label alloc]init];
            atom.cas_styleClass = name;
            varView.atom=atom;
            break;
        }
        case CCButton:
        {
            CC_Button *atom=[[CC_Button alloc]init];
            atom.cas_styleClass = name;
            varView.atom=atom;
            break;
        }
        case CCTextView:
        {
            CC_TextView *atom=[[CC_TextView alloc]init];
            atom.cas_styleClass = name;
            varView.atom=atom;
            break;
        }
        case CCTextField:
        {
            CC_TextField *atom=[[CC_TextField alloc]init];
            atom.cas_styleClass = name;
            varView.atom=atom;
            break;
        }
            
        default:
            break;
    }
    
    [view addSubview:varView.atom];
    
    objc_setAssociatedObject(varView.atom, (__bridge const void * _Nonnull)(name), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
#if !TARGET_IPHONE_SIMULATOR
    [varView.atom updateLayout_must];
#else
#endif
    
    return varView.atom;
}

@end
