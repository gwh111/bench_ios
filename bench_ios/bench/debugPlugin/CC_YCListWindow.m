//
//  YCListWindow.m
//  testPod
//
//  Created by admin on 2019/4/3.
//  Copyright © 2019 yc. All rights reserved.
//

#import "CC_YCListWindow.h"
#import "CC_YCListViewController.h"

@interface YCListWindow()

@end

@implementation YCListWindow

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelStatusBar - 1;//normal0 statusbar1000 alert2000
        self.layer.masksToBounds = YES;
        [self initVC];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backViewClicked) name:@"yc_HideListWindowNow" object:nil];
        self.alpha = 0;
    }
    return self;
    
}

- (void)initVC {
    
    YCListViewController *vc = [YCListViewController new];
    self.rootViewController = vc;
    
}

-(void)show {
    
    [self makeKeyAndVisible];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        self.hidden = NO;
    }];
    
}

-(void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

#pragma mark - delegateMethod
-(void)backViewClicked {
    
    if (!self.hidden) {
        [self hide];
    }
    
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"yc_HideListWindowNow" object:nil];
    
}


@end
