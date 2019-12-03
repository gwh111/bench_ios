//
//  CC_Label.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Label.h"
#import "CC_Alert.h"

@interface CC_Label (){
    BOOL _hasBind;
}
@end

@implementation CC_Label

// MARK: - Life Cycle -
- (void)dealloc{
    if (_hasBind == NO) {
        return;
    }
    
    // unbind text address from object address
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    NSString *bindAddress = [CC_Base.shared cc_shared:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:nil];
    [CC_Base.shared cc_setBind:bindAddress value:nil];
}

@end

@implementation CC_Label (CCActions)

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
    _hasBind = YES;
    // bind attText address to object address
    NSString *textAddress = [NSString stringWithFormat:@"%p",attText];
    NSString *objAddress = [NSString stringWithFormat:@"%p",self];
    [CC_Base.shared cc_setBind:textAddress value:objAddress];
    [CC_Base.shared cc_setShared:objAddress obj:textAddress];
    self.attributedText = attText;
}

@end

