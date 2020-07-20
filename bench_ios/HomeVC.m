//
//  HomeVC.m
//  bench_ios
//
//  Created by gwh on 2019/8/26.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "HomeVC.h"
#import "ccs.h"

#import "TestPresentVC.h"
#import "TestPresentVC2.h"

//#define RF(f) [CC_CoreUI.shared relativeFont:@"FZXS12--GB1-0" fontSize:f]

@interface HomeVC ()

@property (nonatomic, retain) NSArray *testList;
@property (nonatomic, retain) NSMutableArray *testNameList;

@end

@implementation HomeVC

- (void)cc_viewWillLoad {
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.cc_title = @"首页abc123";
    self.cc_navigationBar.titleLabel.font = RF(20);
    _testList = [ccs bundlePlistWithPath:@"testList"][@"list"];
    _testNameList = ccs.mutArray;
    for (int i = 0; i < _testList.count; i++) {
        [_testNameList cc_addObject:_testList[i][@"title"]];
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    CCLOG(@"didMoveToParentViewController");
}

- (void)cc_viewWillAppear {
    
    CCLOG(@"willapper");
}

- (void)viewDidAppear:(BOOL)animated {
    
    CCLOG(@"didapper");
}

- (void)viewWillDisappear:(BOOL)animated {
    CCLOG(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    CCLOG(@"viewDidDisappear");
}

- (void)cc_viewDidLoad {
    
    @autoreleasepool {
        @autoreleasepool {
            @autoreleasepool {
                
            }
        }
    }
    
//    self.cc_navigationBarHidden = YES;
    CC_TableView *tableView = ccs.TableView
    .cc_addToView(self)
//    .cc_frame(0, STATUS_AND_NAV_BAR_HEIGHT, ccs.width, ccs.safeHeight - TABBAR_BAR_HEIGHT)
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_backgroundColor(UIColor.whiteColor);
    [tableView cc_addTextList:_testNameList withTappedBlock:^(NSUInteger index) {
        
        NSDictionary *dic = self.testList[index];
        NSString *name = dic[@"className"];
        if ([name isEqualToString:@"TestPresentVC"]) {
            TestPresentVC2 *vc = [ccs init:TestPresentVC2.class];
            [ccs presentViewController:vc];
            return;
        }
        Class cls = NSClassFromString(name);
        if (!cls) {
            CCLOG(@"找不到class");
            return;
        }
        if ([cls isSubclassOfClass:[UIViewController class]]) {
            [ccs pushViewController:[ccs init:cls]];
        } else {
            [cc_message cc_class:cls method:@selector(start)];
        }
    }];
    
    ccs.ui.dateLabel
    .cc_text(@"2019/09/10 10:13:41")
    .cc_top(RH(10))
    .cc_addToView(self);
    
    ccs.ui.grayLine
    .cc_top(RH(30))
    .cc_addToView(self);
    self.view.opaque;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理Timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理Source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出RunLoop");
                break;
            default:
                break;
        }

    });
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    [[NSString alloc]initWithCString:@"" encoding:NSUTF8StringEncoding];
    
}

@end
