//
//  CC_Note.h
//  bench_ios
//
//  Created by gwh on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Note : NSObject

/**
 * CC_Notice同一时间可以有多个 CC_Note会一个个往下移
 */

@property (nonatomic, assign) int count;
+ (instancetype)getInstance;

+ (void)showAlert:(NSString *)str;
+ (void)showAlert:(NSString *)str atView:(UIView *)view;

@end
