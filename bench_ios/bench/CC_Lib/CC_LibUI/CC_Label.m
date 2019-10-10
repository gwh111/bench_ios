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

- (__kindof CC_Label* (^)(BOOL))cc_enableDebugMode {
    return ^(BOOL debugMode) {
        if (debugMode) {
            for (int i = 0; i < self.gestureRecognizers.count; ++i) {
                UIGestureRecognizer *ges = self.gestureRecognizers[i];
                if ([ges isKindOfClass:UITapGestureRecognizer.class]) {
                    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)ges;
                    if (tap.numberOfTapsRequired == 5) {
                        [tap removeTarget:self action:@selector(debugMenuAction:)];
                    }
                }
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(debugMenuAction:)];
            tap.numberOfTapsRequired = 5;
            self.cc_userInteractionEnabled(YES);
            [self addGestureRecognizer:tap];
        }
        return self;
    };
}

- (void)debugMenuAction:(UITapGestureRecognizer *)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"调试菜单" message:@"内部使用" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *dynamicDomainAction = [UIAlertAction actionWithTitle:@"功能1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CCLOG(@"功能1");
    }];
    
    UIAlertAction *networkAction = [UIAlertAction actionWithTitle:@"功能2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CCLOG(@"功能2");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertC addAction:dynamicDomainAction];
    [alertC addAction:networkAction];
    [alertC addAction:cancelAction];
    
    [UIView.cc_viewControllerByWindow presentViewController:alertC animated:YES completion:nil];
}

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

