//
//  CC_Alert.m
//  bench_ios
//
//  Created by gwh on 2019/5/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Alert.h"

@implementation CC_Alert

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            block(i,bts[i]);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < placeholders.count; i++) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
            textField.placeholder = placeholders[i];
        }];
    }
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            NSMutableArray *texts = [[NSMutableArray alloc]init];
            NSArray *textFields = alertController.textFields;
            for (int i = 0; i < textFields.count; i++) {
                [texts addObject:alertController.textFields[i].text?alertController.textFields[i].text:@""];
            }
            block(i,bts[i],texts);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField) {
        textField.placeholder = placeholder;
    }];
    for (int i = 0; i < bts.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:bts[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            block(i,bts[i],alertController.textFields[0].text);
        }]];
    }
    [controller presentViewController:alertController animated:NO completion:nil];
}

@end
