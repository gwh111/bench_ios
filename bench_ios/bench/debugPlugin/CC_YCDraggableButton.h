//
//  YCDraggableButton.h
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCDraggableButtonDelegate <NSObject>

- (void)draggableButtonClicked:(UIButton *)sender;

@end

@interface YCDraggableButton : UIButton

@property (nonatomic, strong)UIView *rootView;
@property (nonatomic, weak)id<YCDraggableButtonDelegate>delegate;
@property (nonatomic, assign)UIInterfaceOrientation initOrientation;
@property (nonatomic, assign)CGAffineTransform originTransform;

- (void)buttonRotate;

@end

