//
//  UIView+UIView_CCCat.h
//  bench_ios
//
//  Created by gwh on 2019/5/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CCCat)

@property (nonatomic, retain) NSString *name;

/**
 *  view withTag:的扩展 如果对view设置了name，可根据name获取view
 */
- (nullable __kindof UIView *)viewWithName:(NSString *)name;

/**
 * @brief 添加tap点击的block
 * @param timeInterval 下次点击需要间隔多久, 不小于0
 */
- (void)addTapWithTimeInterval:(float)timeInterval tapBlock:(void (^)(UIView *view))tapBlock;

@end

NS_ASSUME_NONNULL_END
