//
//  UIButton+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(CCCat)

@property (nonatomic, strong) NSMutableDictionary *cs_dictBackgroundColor;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)setccSelected:(BOOL)selected;

@end
