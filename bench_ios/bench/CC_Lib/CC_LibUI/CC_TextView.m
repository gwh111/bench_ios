//
//  CC_TextView.m
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_TextView.h"

@interface CC_TextView (){
@public
    BOOL _hasBind;
}
@end

@implementation CC_TextView

// MARK: - Life Cyelc -
- (void)dealloc{
    if (_hasBind==NO) {
        return;
    }
    // unbind text address from object address
    NSString *objAddress=[NSString stringWithFormat:@"%p",self];
    NSString *bindAddress=[CC_Base.shared cc_shared:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:nil];
    [CC_Base.shared cc_setBind:bindAddress value:nil];
}

@end

@implementation CC_TextView (CCActions)

- (void)bindText:(NSString *)text{
    _hasBind = YES;
    // bind text address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",text];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.text = text;
}

- (void)bindAttText:(NSAttributedString *)attText{
    _hasBind=YES;
    // bind attText address to object address
    NSString *textAddress=[NSString stringWithFormat:@"%p",attText];
    NSString *objAddress=[NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.attributedText=attText;
}

@end
