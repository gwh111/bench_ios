//
//  ccs+Domain.m
//  bench_ios
//
//  Created by Shepherd on 2019/10/10.
//

#import "ccs+DebugMenu.h"
#import "CC_DomainController.h"

@implementation ccs (Domain)

@end

@implementation CC_Label (DebugMenu)

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
    UIAlertAction *dynamicDomainAction = [UIAlertAction actionWithTitle:@"动态域名" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[self cc_viewController].navigationController pushViewController:[CC_Base.shared cc_init:CC_DomainController.class] animated:YES];
    }];
    
    UIAlertAction *networkAction = [UIAlertAction actionWithTitle:@"网络监听" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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


@end
