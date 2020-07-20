//
//  CC_StrokeLabel.h
//  JHStories
//
//  Created by gwh on 2020/5/4.
//  Copyright © 2020 gwh. All rights reserved.
//

#import "CC_Label.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_StrokeLabel : CC_Label

@property (strong,nonatomic) UIColor *strokeColor;
@property (assign,nonatomic) CGFloat strokeWidth;

+ (CC_StrokeLabel *)label;

@end

NS_ASSUME_NONNULL_END
