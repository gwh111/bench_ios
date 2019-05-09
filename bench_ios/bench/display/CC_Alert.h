//
//  CC_Alert.h
//  bench_ios
//
//  Created by gwh on 2019/5/9.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Alert : NSObject

/**
 *  系统弹窗
    @param bts 按钮的title数组
 */
+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block;

@end

NS_ASSUME_NONNULL_END
