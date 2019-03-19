//
//  CC_Loading.h
//  NewWord
//
//  Created by gwh on 2017/12/26.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CC_Loading : UIView

+ (instancetype)getInstance;
- (void)loading:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view textColor:(UIColor *)color;
- (void)stop;

- (void)showLoadingWithText:(NSString *)loadingText withAni:(BOOL)ani atView:(UIView *)view;
- (void)stopLoading;

@end
