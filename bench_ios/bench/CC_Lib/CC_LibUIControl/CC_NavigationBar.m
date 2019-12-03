//
//  CatNavBarView.m
//  UITemplateKit
//
//  Created by 路飞 on 2019/6/4.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_NavigationBar.h"

@implementation CC_NavigationBar

static NSString *KEY_BACK_ICON = @"gray_navBack_arrow_icon@3x";

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, WIDTH(), STATUS_AND_NAV_BAR_HEIGHT);
        _navigationBarImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_navigationBarImageView];
        
        UIImage *backImage;
        NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
        if ([mainBundle pathForResource:@"bench_ios" ofType:@"bundle"]) {
            NSString *myBundlePath = [mainBundle pathForResource:@"bench_ios" ofType:@"bundle"];
            NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:KEY_BACK_ICON ofType:@"png"]];
        }else{
            NSString *appBundlePath = [mainBundle pathForResource:@"bench_ios" ofType:@"bundle"];
            NSBundle* appBundle = [NSBundle bundleWithPath:appBundlePath];
            NSString *myBundlePath = [appBundle pathForResource:@"Bundle" ofType:@"bundle"];
            NSBundle* myBundle = [NSBundle bundleWithPath:myBundlePath];
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:KEY_BACK_ICON ofType:@"png"]];
        }
        self.backgroundColor = UIColor.whiteColor;
        _backButton = [CC_Button buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:backImage forState:UIControlStateNormal];
        _backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _backButton.frame = CGRectMake(10, STATUS_BAR_HEIGHT + 10, backImage.size.width * 24 / backImage.size.height, 24);
        [self addSubview:_backButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH()/2 - RH(150), STATUS_BAR_HEIGHT, RH(300), RH(44))];
        _titleLabel.textColor = HEX(#000000);
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [CC_CoreUI.shared relativeFont:@"Helvetica-Bold" fontSize:19];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _line = [[UIView alloc]init];
        _line.frame = CGRectMake(0, _titleLabel.bottom - 1, WIDTH(), 1);
        _line.backgroundColor = RGBA(0, 0, 0, .1);
        [self addSubview:_line];
    }
    return self;
}

- (void)cc_updateConfig:(CC_NavigationBarConfig *)config {
    if (!config) {
        return;
    }
    if (config.hiddenLine) {
        _line.hidden = YES;
    }
    _navigationBarBackgroundImage = config.cc_navigationBarBackgroundImage;
    _titleLabel.font = config.cc_navigationBarTitleFont;
    _titleLabel.textColor = config.cc_navigationBarTitleColor;
    self.backgroundColor = config.cc_navigationBarBackgroundColor;
}

@end
