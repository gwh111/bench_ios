//
//  CC_Alert.h
//  bench_ios
//
//  Created by gwh on 2019/5/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Alert : NSObject

// 系统弹窗
// @param bts 按钮的title数组
- (void)showAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle))block;

// 系统弹窗
// @param bts 按钮的title数组
// @placeholder textField的placeholder
- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSString *text))block;

- (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholder:(NSString *_Nullable)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSString *text))block textFieldBlock:(void(^_Nullable)(UITextField *_Nonnull textField))textFieldBlock;

- (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *indexTitle, NSArray *texts))block;

@end

NS_ASSUME_NONNULL_END
