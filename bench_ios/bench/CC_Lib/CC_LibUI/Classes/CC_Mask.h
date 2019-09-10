//
//  CC_Mask.h
//  bench_ios
//
//  Created by gwh on 2019/2/15.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Label.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Mask : UIView

// 加载文字的label
@property (nonatomic,retain) CC_Label *textL;

+ (instancetype)shared;

- (void)start;

// 点击是否穿透
// cross=0 点击不可穿透
// cross=1 点击可以穿透
- (void)setCross:(BOOL)cross;

// 设置加载文字提示
- (void)setText:(NSString *)text;

// 添加mask到view view=nil时使用window
- (void)startAtView:(UIView * _Nullable)view;

// 停止mask
- (void)stop;

@end

NS_ASSUME_NONNULL_END
