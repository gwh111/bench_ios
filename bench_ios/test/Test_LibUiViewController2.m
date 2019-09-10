//
//  Test_LibUiViewController2.m
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import "Test_LibUiViewController2.h"
#import "ccs.h"


@interface Test_LibUiViewController2 ()

@end

@implementation Test_LibUiViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cc_baseView.cc_backgroundColor(UIColor.whiteColor);
    self.title = NSStringFromClass(self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self testBuilder];
}

- (void)testBuilder {
    /// issues1:
    /// center 在父视图y/x 非0时的"失效"问题
    
    CC_View *outView = ccs.View;
    outView
        .cc_backgroundColor(UIColor.blueColor)
        .cc_addToView(self.view)
        .cc_dragable(YES)
        .cc_frame(RH(101),RH(300),RH(100),RH(100))
        .cc_tappedIntervalWithBlock(0.1,^(UIView *sender){
        
        });
    
    /// outView: frame = (101 300; 100 100)
    CCLOG(@"%@",outView);
    
    CC_View *inView = ccs.View;
    inView
        .cc_backgroundColor(UIColor.redColor)
        .cc_addToView(outView)
        .cc_frame(0,0,RH(40),RH(30));
    
    /// inView: frame = (0 0; 40 30);
    CCLOG(@"%@",inView);
    
    NSInteger c1 = 1;
    NSInteger c2 = 2;
    
    
    NSInteger testPath = 3;
    
    NSInteger enableLog = 0;
    
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
    }
    
    if (testPath & c2) {
        /// 对于一般情况下,在父子视图中使用center/centerX/centerY是要求子视图能居中 因此需要排除父视图的y值的影响
        /// cc_centerEqualSuperview可用于处理该情况
        /// 拖拽时也会跟随
        /// 若要使用原效果可调用 cc_center
        inView.cc_centerEqualSuperview();
        
        !enableLog ? : CCLOG(@"%@",inView);
        
        NSAssert(CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50))), assertLogFormat(c2,NO,@"inView不在outView的中点"));
        
        logFormat(c2,YES,nil);
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
