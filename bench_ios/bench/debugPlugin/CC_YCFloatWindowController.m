//
//  YCFloatWindowController.m
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import "CC_YCFloatWindowController.h"
#import "CC_YCDraggableButton.h"
#import "CC_YCFloatWindowSingleton.h"
#import "CC_YCListWindow.h"

@interface YCFloatWindowController ()<YCDraggableButtonDelegate>

@property (strong,nonatomic) UIWindow *window;
@property (strong,nonatomic) YCDraggableButton *button;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)YCListWindow *listWindow;

@end

@implementation YCFloatWindowController
#define floatWindowSize 50
#define SelfWidth [UIScreen mainScreen].bounds.size.width
#define SelfHeight  [UIScreen mainScreen].bounds.size.height
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = CGRectZero;
    
    [self createButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

/**
 * create floating window and button
 */
- (void)createButton
{
    // 1.floating button
    _button = [YCDraggableButton buttonWithType:UIButtonTypeCustom];
    _button.backgroundColor = [UIColor grayColor];
    _button.alpha = 0.3;
    _button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _button.frame = CGRectMake(0, 0, floatWindowSize, floatWindowSize);
    _button.delegate = self;
    _button.initOrientation = [UIApplication sharedApplication].statusBarOrientation;
    _button.originTransform = _button.transform;
    _button.imageView.alpha = 0.3;
    
    // 2.floating window
    _window = [[UIWindow alloc]init];
    _window.frame = CGRectMake(0, 100, floatWindowSize, floatWindowSize);
    _window.windowLevel = UIWindowLevelStatusBar - 2;//normal0 statusbar1000 alert2000
    _window.backgroundColor = [UIColor clearColor];
    _window.layer.cornerRadius = floatWindowSize/2;
    _window.layer.masksToBounds = YES;
    [_window addSubview:_button];
    [_window makeKeyAndVisible];
    
}

//*******************************配置内容的window*******************************************
-(YCListWindow *)listWindow {
    
    if (!_listWindow) {
        _listWindow = [[YCListWindow alloc]initWithFrame: CGRectMake(0, 0, SelfWidth, SelfHeight)];        
    }
    return _listWindow;
    
}

- (void)listWindowHidden {
    
    _listWindow.hidden = YES;
    
}

- (void)containTap {
    NSLog(@"good");
}

/**
 * set rootview
 */
- (void)setRootView {
    
    _button.rootView = self.view.superview;
    
}

/**
 *  floating button clicked
 */
- (void)draggableButtonClicked:(UIButton *)sender {
    
    // click action
    if (!_listWindow.hidden && _listWindow) {
        [_listWindow hide];
        return;
    }
    [self.listWindow show];
    
}

/**
 * reset window hiden
 */
- (void)setHideWindow:(BOOL)hide {
    
    _window.hidden = hide;
    
}

/**
 * reset floating window size
 */
- (void)setWindowSize:(float)size {
    
    CGRect rect = _window.frame;
    _window.frame = CGRectMake(rect.origin.x, rect.origin.y, size, size);
    _button.frame = CGRectMake(0, 0, size, size);
    [self.view setNeedsLayout];
    
}

/**
 * notification
 */
- (void)orientationChange:(NSNotification *)notification {
    
    [_button buttonRotate];
    
}

@end
