//
//  AreaInfomationView.m
//  BallOC
//
//  Created by gwh on 2020/1/8.
//  Copyright © 2020 gwh. All rights reserved.
//

#import "PopViewC.h"

@interface PopViewC ()

@end

@implementation PopViewC

+ (instancetype)shared {
    return [ccs registerSharedInstance:self];
}

- (CC_View *)displayView {
    return ccs.View
    .cc_backgroundColor(COLOR_WHITE)
    .cc_cornerRadius(6)
    .cc_size(RH(300), RH(350))
    .cc_center(WIDTH()/2, HEIGHT()/2);
}

- (id)popView:(CC_View *)backgroundView block:(void(^)(CC_View *displayView))block {
    
    [backgroundView cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
        [view removeFromSuperview];
    }];
    // 添加到用户当前视图
    backgroundView.cc_addToView(ccs.currentVC.view);
    
    // 创建白底显示视图 添加到背景图 返回给调用者
    block(self.displayView.cc_addToView(backgroundView));
    
    return backgroundView;
}

- (id)popViewWithClose:(CC_View *)backgroundView block:(void(^)(CC_View *displayView, CC_Button *closeButton))block {
    
    [backgroundView cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
        [view removeFromSuperview];
    }];
    // 添加到用户当前视图
    backgroundView.cc_addToView(ccs.currentVC.view);
    
    CC_View *displayView = self.displayView;
    
    // 添加关闭按钮
    CC_Button *close = ccs.ui.closeButton
    .cc_addToView(displayView);
    close.top = 0;
    close.right = displayView.width;
    [close cc_addTappedOnceDelay:.5 withBlock:^(CC_Button *btn) {
        [backgroundView removeFromSuperview];
    }];
    [displayView cc_addSubview:close];
    
    block(displayView.cc_addToView(backgroundView),close);
    
    return backgroundView;
}

- (id)popViewWithCloseAndTitle:(CC_View *)backgroundView block:(void(^)(CC_View *displayView, CC_Button *closeButton, CC_Label *titleLabel))block {
    
    [backgroundView cc_tappedInterval:.5 withBlock:^(id  _Nonnull view) {
        [view removeFromSuperview];
    }];
    // 添加到用户当前视图
    backgroundView.cc_addToView(ccs.currentVC.view);
    
    CC_View *displayView = self.displayView;
    
    // 添加关闭按钮
    CC_Button *close = ccs.ui.closeButton
    .cc_addToView(displayView);
    close.top = 0;
    close.right = displayView.width;
    [close cc_addTappedOnceDelay:.5 withBlock:^(CC_Button *btn) {
        [backgroundView removeFromSuperview];
    }];
    [displayView cc_addSubview:close];
    
    // 添加标题
    CC_Label *titleLabel = ccs.ui.itemTitleLabel
    .cc_frame(0, RH(20), displayView.width, RH(50))
    .cc_text(@"热点区颜色划分说明")
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_font(RF(22))
    .cc_addToView(displayView);
    
    block(displayView.cc_addToView(backgroundView),close,titleLabel);
    
    return backgroundView;
}

@end
