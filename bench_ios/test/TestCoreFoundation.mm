//
//  testCoreFoundation.m
//  testbenchios
//
//  Created by gwh on 2019/8/14.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestCoreFoundation.h"
#import "ccs.h"
#include <iostream>

@implementation TestCoreFoundation

using namespace std;

+ (void)start{
    
//    NSObject *object = [[NSObject alloc] init];
//    NSLog(@"\n 引用计数 = %lu \n 对象内存 = %p \n object指针内存地址 = %x", (unsigned long)[object retainCount], object, &object);
//    self.property = object;
//    NSLog(@"\n 引用计数 = %lu \n 对象内存 = %p \n object指针内存地址 = %x \n property指针内存地址 = %x", (unsigned long)[object retainCount], object, &object, &_property);
//    [object release];
//    NSLog(@"\n 引用计数 = %lu \n 对象内存 = %p \n object指针内存地址 = %x \n property指针内存地址 = %x", (unsigned long)[object retainCount], object, &object, &_property);
    
    int  var;
    int  *ptr = nullptr;
    int  val;

    var = 3000;
    
    // 获取 var 的地址
    ptr = &var;
    // 获取 ptr 的值
    val = *ptr;
    
    
    NSArray *arr = @[@""];
    NSLog(@"%p %p %p",arr[0], arr.copy[0], arr.mutableCopy[0]);
    
    {
        int a[6] = {1,2,3,4,5,1};
        int *ptr = (int *)(&a + 1);// 地址+1
        int *ptr2 = (int *)(&a - 1);
        printf("%d,%d",*(a + 1),*(ptr - 1));
        printf("%d,%d",*(ptr),*(ptr2 + 6));// 指针+n
        
    }
    
    // 作用域
    [self creat];
    
    [CC_Runtime shared];
    
    // 共享数据 重复设置一个字段会断言
    if ((1)) {
        [ccs setShared:@"userName" value:@"a"];
//        [ccs setShared:@"userName" obj:@"a"];// assert
        [ccs resetShared:@"userName" value:@"a"];
        CCLOG(@"%@",[ccs sharedValueForKey:@"userName"]);
    }
}

+ (void)creat {
    int count = 10;
    for (int i = 0; i < 10; i++) {
        [self fun:count];
        NSLog(@"%d",count);
    }
}

+ (void)fun:(int)count {
    count++;
}

+ (void)testRunLoop {
    // 定义一个定时器，约定两秒之后调用self的run方法
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];

    // 将定时器添加到当前RunLoop的NSDefaultRunLoopMode下
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    cout << "请输入您的名称： ";
}

@end
