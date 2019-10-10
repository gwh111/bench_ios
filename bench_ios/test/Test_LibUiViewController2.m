//
//  Test_LibUiViewController2.m
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import "Test_LibUiViewController2.h"
#import "ccs.h"
#import "CC_CoreUI.h"

NSInteger c1 = 1;
NSInteger c2 = 2;
NSInteger c3 = 4;
NSInteger c4 = 8;
NSInteger c5 = 16;
NSInteger c6 = 32;
NSInteger c7 = 64;
NSInteger c8 = 128;
NSInteger c9 = 256;
NSInteger c10 = 512;

NSInteger enableLog = 0;

@interface Test_LibUiViewController2 () <UITableViewDelegate>

@end

@implementation Test_LibUiViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cc_displayView.cc_backgroundColor(UIColor.whiteColor);
    self.cc_title = NSStringFromClass(self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self testBuilder];
}

- (void)testBuilder {
    NSInteger testPath = 4;
    
    if (testPath & c1) {
        /// center 在父视图y/x 非0时的"失效"问题
        [self testUIView];
    }
    
    if (testPath & c2) {
        [self testImageView];
    }
    
    if (testPath & c3) {
        [self testButton];
    }
    
    if (testPath & c4) {
        [self testUITableView];
    }
}

- (void)testImageView {
    /// 本地图片
    NSAssert(
             ccs.ImageView
             .cc_imageNamed(@"tabbar_mine_high")
             .cc_addToView(self.view)
             .cc_top(100)
             .cc_w(40)
             .cc_centerXSuper()
             .cc_h(40).image,assertLogFormat(c1,NO,@"未成功加载本地图片"));
    
    /// 网络图片
    ccs.ImageView
    //
    .cc_imageURL(@"https://i.loli.net/2019/09/04/1PYcMZ97gCLWnA3.jpg",[UIImage imageNamed:@"tabbar_mine_high"])
    // .cc_imageURL(@"https://i.loli.net/2019/09/04/1PYcMZ97gCLWnA3.jpg2232",IMG_HOLDER(100,100))
    .cc_addToView(self.view)
    .cc_top(150)
    .cc_w(100)
    .cc_centerXSuper()
    .cc_h(100);
}

- (void)testUITableView {
    UIView *view = ccs.View
    .cc_addToView(self.view)
    .cc_frame(0,460,WIDTH(),100);
    
    ccs.TableView
    .cc_frame(0,NAV_BAR_HEIGHT,WIDTH(),100)
    .cc_addToView(view)
    .cc_delegate(self);
}

- (void)testButton {
    [ccs.Button
     .cc_frame(100,333,100,30)
     .cc_setTitleForState(@"点击",UIControlStateNormal)
     .cc_setTitleColorForState(HEX(FF0000),UIControlStateNormal)
     .cc_setTitleForState(@"不可点击",UIControlStateDisabled)
     .cc_addToView(self.view) cc_addTappedOnceDelay:0.1 withBlock:^(CC_Button *btn) {
         
     }];
}

- (void)testUIView {
    NSInteger testPath = 63;
    
    CCLOG(@"正在执行:%s \n",__func__);
    CCLOG(@"[测试]:center 在父视图y/x 非0时的失效问题\n");
    
    CC_View *outView = {ccs.View
        .cc_addToView(self.view)
        .cc_backgroundColor(UIColor.blueColor)
        .cc_dragable(YES)
        .cc_frame(RH(101),RH(260),RH(100),RH(100))
        .cc_centerXSuper()
    };
    
    /// outView: frame = (101 300; 100 100)
    CCLOG(@"%@",outView);
    
    CC_View *inView = ccs.View
    .cc_backgroundColor(UIColor.redColor)
    .cc_addToView(outView)
    .cc_frame(0,0,RH(40),RH(30));
    
    /// inView: frame = (0 0; 40 30);
    CCLOG(@"%@",inView);
    
    if (testPath & c1) {
        /// outView.center (x = 151, y = 350)
        inView.center = outView.center;
        
        /// inView: <CC_View: 0x109d69a00; frame = (131 335; 40 30); layer = <CALayer: 0x28136bfe0>>
        /// 335 = 300 + (100 - 30) * 0.5
        
        !enableLog ? : CCLOG(@"%@",inView);
        
        // NSAssert(CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50))), @"[FAILURE]:inView不在outView的中点");
        // CCLOG(@"[PASS]:condition%ld",reversePow(conditon1) + 1);
        
        if (CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50)))) {
            logFormat(c1, YES,nil);
        }else {
            logFormat(c1, NO,@"inView不在outView的中点");
        }
        
        /// 对于一般情况下,在父子视图中使用center/centerX/centerY是要求子视图能居中 因此需要排除父视图的y值的影响
        /// cc_centerSuper可用于处理该情况
        /// 拖拽时也会跟随
        /// 若要使用原效果可调用 cc_center
        inView.cc_centerSuper();
        
        !enableLog ? : CCLOG(@"%@",inView);
        
        NSAssert(CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50))), assertLogFormat(c1,NO,@"inView不在outView的中点"));
        
        logFormat(c1,YES,nil);
    }
    
    CCLOG(@"\n[测试]:查找控制器\n");
    
    if (testPath & c2) {
        NSAssert([self isEqual:[self.view cc_viewController]], assertLogFormat(c2, NO, @"cc_viewController未找到正确的视图控制器"));
        logFormat(c2, YES,nil);
        
        NSAssert([self isEqual:[UIView cc_viewControllerByWindow]], assertLogFormat(c2, NO, @"cc_viewControllerByWindow未找到正确的视图控制器"));
        logFormat(c2, YES,nil);
    }
    
    
    CCLOG(@"\n[测试]:调试菜单\n");
    
    if (testPath & c3) {
        CC_Label *verLabel = ccs.Label
        .cc_text(@"1.2.3")
        .cc_addToView(self.view)
        .cc_sizeToFit()
        .cc_top(440)
        .cc_centerXSuper();
        
        verLabel.cc_enableDebugMode(YES);
    }
    
    CCLOG(@"\n[测试]:角标\n");
    
    if (testPath & c4) {
        inView
        .cc_badgeValue(@"999");
        // .cc_badgeColor(UIColor.whiteColor)
        // .cc_badgeBgColor(UIColor.redColor);
    }
}

NSInteger reversePow(NSInteger localTestPath) {
    NSInteger i = 0;
    
    while (localTestPath >= 2) {
        localTestPath = localTestPath >> 1;
        i++;
    }
    
    return i;
}

void logFormat(NSInteger condition,BOOL state, NSString *descritpion) {
    CCLOG(@"%@",assertLogFormat(condition,state,descritpion));
}

NSString * assertLogFormat(NSInteger condition,BOOL state, NSString *descritpion) {
    return [NSString stringWithFormat:@"[CCLib] | [%@]: ==> condition%ld  %@",state ? @"PASS   " : @"FAILURE",reversePow(condition) + 1,descritpion ? : @"success"];
}

@end
