//
//  ViewController.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestViewController1.h"
#import "TestViewController2.h"
#import "CC_Color.h"
#import "CC_Device.h"
#import "TestModel.h"
#import "TestView.h"
#import "TestController.h"
#import "ccs.h"

@interface TestViewController1 ()

@property (nonatomic, retain) NSString *name;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation TestViewController1
@synthesize text = _text;

+ (instancetype)shared{
    return [ccs registerSharedInstance:self block:^{
        // Do init things
    }];
}

- (void)testReadWriteLock {
    
    self.concurrentQueue = dispatch_queue_create("aaa", DISPATCH_QUEUE_CONCURRENT);
    // 测试代码,模拟多线程情况下的读写
    for (int i = 0; i<10; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.text = [NSString stringWithFormat:@"噼里啪啦--%d",i];
        });
    }
    
    for (int i = 0; i<50; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"读 %@ %@",[self text],[NSThread currentThread]);
        });
    }
    
    for (int i = 10; i<20; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.text = [NSString stringWithFormat:@"噼里啪啦--%d",i];
        });
    }
}
 
// 写操作,栅栏函数是不允许并发的,所以"写操作"是单线程进入的,根据log可以看出来
- (void)setText:(NSString *)text {
    
    __weak typeof(self) weakSelf = self;
    dispatch_barrier_sync(self.concurrentQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->_text = text;
        NSLog(@"写操作 %@ %@",text,[NSThread currentThread]);
        // 模拟耗时操作,1个1个执行,没有并发
        sleep(1);
    });
}

// 读操作,这个是可以并发的,log在很快时间打印完
- (NSString *)text {
 
    __block NSString * t = nil ;
    __weak typeof(self) weakSelf = self;
    // 并发 还是 顺序
    dispatch_sync(self.concurrentQueue, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        t = strongSelf->_text;
        // 模拟耗时操作,瞬间执行完,说明是多个线程并发的进入的
        sleep(1);
    });
    return t;
}
// end

- (void)testKVO {
    
    
    TestModel *model1 = TestModel.new;
    TestModel *model = TestModel.new;
    
    __weak typeof(model) weakDataSource = model;
    [model1 addObserver:weakDataSource forKeyPath:@"success" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    model1.success = @"asd";
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)contex {
    NSLog(@"%@",keyPath);
}

- (void)dealloc
{
    NSLog(@"TestViewController1dealloc");
}

- (void)cc_viewWillLoad{
    
    [self testReadWriteLock];
//    [self testKVO];
    return;
    
    TestView *imgv = [ccs init:TestView.class];
    ccs.View
    .cc_dragable(YES);
    
    imgv
        .cc_addToView(self.view)
        .cc_frame(100, 200, 50, 50)
    .cc_backgroundColor(HEXA(fff111, 1))
        .cc_badgeValue(@"abc3")
        .cc_badgeColor(UIColor.whiteColor)
        .cc_badgeBgColor(UIColor.redColor);
    
//    [imgv cc_updateBadge:@"abc3"];
//    [imgv cc_updateBadge:@"abc4"];
    
    [imgv test];
    NSData *d=[ccs bundleFileWithPath:@"testjson" type:@"json"];
    NSString *s=[d cc_convertToUTF8String];
    NSDictionary *json=[ccs function_jsonWithString:s];
    
    id vv= [ccs getAView];
    [ccs showNotice:@"aaaa@!#!@#!@#@!#!@#$" atView:vv];
    
    TestModel *t1=[ccs model:[TestModel class]];
    [t1 cc_setProperty:json];
    int v=t1.intv;
    v++;
    
    [t1 cc_setObjectClassInArrayWithDic:@{@"groupUsers":@"TestSubArrayModel"}];
    [t1 cc_setProperty:    @{
                             @"robots" :@(10),
                             @"jumpLogin" :@"",
                             @"nowTimestamp" : @"1568962641534",
                             @"success" : @"",
                             @"group2":@[@{@"name":@"1"}],
                             @"group" : @{
                                     @"groupUserCount" : @"",
                                     @"groupName" :@"易辰,清一色,贼牛逼",
                                     @"groupLogoUrl" :@" http://mapi1.mingliao.net/groupLogoUrl.htm?groupId=10164005311021834700740980168678&sizeType=LARGE&timestamp=1568962641641",
                                     },
                             @"nowDate" : @"2019-09-20 14:57:21",
                             @"groupUsers" :@[@{@"groupId" : @"123"}]
                             }];
    [t1 cc_setProperty:@{@"st1":@"1",@"id":@"b",@"model1":@{@"st2":@"abc",@"st1":@"abcsd"}} modelKVDic:@{@"st2":@"id"}];
    [t1 cc_update];
    [@{@"st1":@"1",@"a":@"b"} cc_propertyCode];
    
    CCLOG(@"%@",APP_STANDARD(@"大标题"));
    
}

- (void)cc_viewDidLoad{
    return;
    TestViewController2 *vc1 = [ccs init:TestViewController2.class];
    vc1.tests1 = @"";
    [ccs pushViewController:vc1];
    
    CC_View *someView = ccs.View
    .cc_addToView(self.view)
    .cc_name(@"abc")
    .cc_frame(RH(10),RH(100),RH(100),RH(100))
    .cc_backgroundColor(UIColor.whiteColor);
    
    [someView cc_addCornerRadius:20 borderWidth:3 borderColor:UIColor.orangeColor backgroundColor:nil drawTopLeft:YES drawTopRight:NO drawBottomLeft:NO drawBottomRight:YES];
    
    [someView cc_tappedInterval:3 withBlock:^(id  _Nonnull view) {
        [self cc_removeViewWithName:@"abc"];
    }];
    
}

- (void)cc_viewWillAppear {
}

- (id)change:(id)obj{
    return obj;
}

@end
