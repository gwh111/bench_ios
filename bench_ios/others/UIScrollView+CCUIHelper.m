//
//  UIScrollView+CCUIHelper.m
//  bench_ios
//
//  Created by gwh on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIScrollView+CCUIHelper.h"
#import "CC_Share.h"

@implementation UIScrollView(CCUIHelper)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([CC_Share getInstance].ccDebug) {
        // 选其一即可
        [super touchesBegan:touches withEvent:event];
        //  [[self nextResponder] touchesBegan:touches withEvent:event];
    }
}

@end
