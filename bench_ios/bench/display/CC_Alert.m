//
//  CC_Alert.m
//  bench_ios
//
//  Created by gwh on 2019/5/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Alert.h"

@implementation CC_Alert

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i=0; i<bts.count; i++) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block(i,bts[i]);
            
        }]];
    }
    
    
    // 由于它是一个控制器 直接modal出来就好了
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
