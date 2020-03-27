//
//  CC_Animation.h
//  bench_ios
//
//  Created by gwh on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_Button.h"

@interface CC_Animation : CC_Object

// 不停闪烁
// [noteTextV.layer addAnimation:[CC_Animation cc_flickerForever:.5] forKey:nil];
+ (CABasicAnimation *)flickerForever:(float)time;

// 按钮点击放大动画
// [CC_Animation cc_buttonTapEnlarge:checkBt];
+ (void)buttonTapEnlarge:(CC_Button *)button;

@end
