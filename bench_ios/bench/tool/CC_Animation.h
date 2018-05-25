//
//  CC_Animation.h
//  bench_ios
//
//  Created by gwh on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Animation : NSObject

/**
 * 不停闪烁
 * [noteTextV.layer addAnimation:[CC_Animation opacityForever_Animation:.5] forKey:nil];
 */
+ (CABasicAnimation *)opacityForever_Animation:(float)time;
/**
 * 按钮点击放大动画
 * [CC_Animation buttonClick:checkBt];
 */
+ (void)buttonClick:(UIButton *)button;

@end
