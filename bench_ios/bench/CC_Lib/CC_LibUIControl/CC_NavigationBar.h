//
//  CatNavBarView.h
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_LibUI.h"
#import "CC_NavigationBarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_NavigationBar : UIView

@property (nonatomic,retain) CC_Button *backButton;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImage *navigationBarBackgroundImage;
@property (nonatomic,strong) UIImageView *navigationBarImageView;
@property (nonatomic,strong) UIView *line;

- (void)cc_updateConfig:(CC_NavigationBarConfig *)config;

@end

NS_ASSUME_NONNULL_END
