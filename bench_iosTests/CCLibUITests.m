//
//  CCLibUITests.m
//  bench_iosTests
//
//  Created by ml on 2019/8/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

#define WAIT(TIME) do {\
[self expectationForNotification:@"CCUnitTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:TIME handler:nil];\
} while (0);
#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"CCUnitTest" object:nil];

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

BOOL enableInfoLog = NO;
BOOL enableDebugLog = NO;

@interface CCLibUITests : XCTestCase

@property (nonatomic,strong) CC_ViewController *vc;

@end

@implementation CCLibUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _vc = [[NSClassFromString(@"Test_LibUiViewController2") alloc] init];
    [CC_NavigationController.shared cc_pushViewController:_vc];
    
}

- (void)testPop {
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [self testCC_View];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testCC_View {
    
    NSInteger testPath = 31;
    
    !enableInfoLog ? : CCLOG(@"[测试]:center 在父视图y/x 非0时的失效问题\n");
    
    CC_View *outView = ccs.View;
    XCTAssertNotNil(outView);
    
    outView
    .cc_backgroundColor(UIColor.blueColor)
    .cc_addToView(_vc.view)
    .cc_dragable(YES)
    .cc_frame(RH(101),RH(300),RH(100),RH(100));
    
    XCTAssertEqual(outView.frame.origin.x, RH(101));
    XCTAssertEqual(outView.frame.origin.y, RH(300));
    XCTAssertEqual(outView.frame.size.height, RH(100));
    XCTAssertEqual(outView.frame.size.width, RH(100));

    /// outView: frame = (101 300; 100 100)
    !enableDebugLog ? : CCLOG(@"%@",outView);
    
    CC_View *inView = ccs.View
    .cc_backgroundColor(UIColor.redColor)
    .cc_addToView(outView)
    .cc_frame(0,0,RH(40),RH(30));
    
    /// inView: frame = (0 0; 40 30);
    !enableDebugLog ? : CCLOG(@"%@",inView);
    
    if (testPath & c1) {
        /// outView.center (x = 151, y = 350)
        inView.center = outView.center;
        
        /// inView: <CC_View: 0x109d69a00; frame = (131 335; 40 30); layer = <CALayer: 0x28136bfe0>>
        /// 335 = 300 + (100 - 30) * 0.5
        
        !enableDebugLog ? : CCLOG(@"%@",inView);
        
        XCTAssertFalse(CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50))),@"inView在outView的中点");
    }
    
    if (testPath & c2) {
        /// 对于一般情况下,在父子视图中使用center/centerX/centerY是要求子视图能居中 因此需要排除父视图的y值的影响
        /// cc_centerSuper可用于处理该情况
        /// 拖拽时也会跟随
        /// 若要使用原效果可调用 cc_center
        inView.cc_centerSuper();
        
        !enableDebugLog ? : CCLOG(@"%@",inView);
        
        XCTAssertTrue(CGPointEqualToPoint(inView.center, CGPointMake(RH(50), RH(50))),@"inView不在outView的中点");
    }
    
    !enableInfoLog ? : CCLOG(@"\n[测试]:查找控制器\n");
    if (testPath & c3) {
        XCTAssertTrue([_vc isEqual:_vc.view.cc_viewController],@"未找到正确的视图控制器");
    }
    
    if (testPath & c4) {
        XCTAssertTrue([_vc isEqual:UIView.cc_viewControllerByWindow],@"未找到正确的视图控制器");
        
    }
    
    if (testPath & c5) {
        inView
            .cc_badgeValue(@"999")
            .cc_badgeColor(UIColor.whiteColor)
            .cc_badgeBgColor(UIColor.redColor);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NOTIFY
        });
    }
    
    WAIT(30)
}

@end
