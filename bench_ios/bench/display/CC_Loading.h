//
//  CC_Loading.h
//  NewWord
//
//  Created by gwh on 2017/12/26.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Loading : UIView

/**
 *  加载文字的label
 */
@property (nonatomic,retain) UILabel *textL;

+ (instancetype)getInstance;

- (void)start;

/**
 *  设置加载文字提示
 */
- (void)setText:(NSString *)text;

/**
 *  添加到view view=nil时使用window
 */
- (void)startAtView:(UIView * _Nullable)view;

- (void)loading:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view textColor:(UIColor *)color;
- (void)stop;

- (void)showLoadingWithText:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view;
- (void)stopLoading;

@end
