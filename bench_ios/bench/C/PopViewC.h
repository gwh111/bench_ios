//
//  AreaInfomationView.h
//  BallOC
//
//  Created by gwh on 2020/1/8.
//  Copyright © 2020 gwh. All rights reserved.
//

#import "ccs.h"

@interface PopViewC : CC_Controller

+ (instancetype)shared;

- (id)popView:(CC_View *)backgroundView block:(void(^)(CC_View *displayView))block;
- (id)popViewWithClose:(CC_View *)backgroundView block:(void(^)(CC_View *displayView, CC_Button *closeButton))block;
- (id)popViewWithCloseAndTitle:(CC_View *)backgroundView block:(void(^)(CC_View *displayView, CC_Button *closeButton, CC_Label *titleLabel))block;

@end

