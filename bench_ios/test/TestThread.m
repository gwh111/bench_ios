//
//  testThread.m
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "TestThread.h"
#import <objc/runtime.h>
#import "TestModel.h"

@implementation TestThread

+ (void)initialize {
    if (self == [TestThread class]) {
        
        
        NSLog(@"22");
    }
}

+ (void)load {
//    [CC_Runtime cc_exchangeClass:TestThread.class method:@selector(start) withMethod:@selector(testBackground)];
//[CC_Runtime cc_exchangeClass:self.class method:@selector(foo:) withMethod:@selector(test)];
}

+ (void)testBackground {
//    NSLog(@"\n%@", [NSRunLoop currentRunLoop]);
    NSLog(@"iii %@",[NSThread currentThread]);
}

+ (void)test {
    // 线程会重复
    // 执行顺序立即执行
//    NSLog(@"\n%@", [NSRunLoop currentRunLoop]);
    NSLog(@"zzz %@",[NSThread currentThread]);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(foo:)) {//如果是执行foo函数，就动态解析，指定新的IMP
//        class_addMethod(object_getClass([self class]), sel, (IMP)fooMethod, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"Doing foo");//新的foo函数
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(foo)) {
        return [self class];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//签名，进入forwardInvocation
    }
    
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;

//    Person *p = [Person new];
//    if([p respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:p];
//    }
//    else {
//        [self doesNotRecognizeSelector:sel];
//    }

}

+ (void)start {

    return;
    
    [self performSelector:@selector(foo:)];
    
    id c = self.class;
    
    int age = 10;
    static int num = 25;
    void (^Block)(void) = ^{
        NSLog(@"age:%d,num:%d",age,num);
//        age++;// Variable is not assignable (missing __block type specifier)
        num++;
    };
    age = 20;
    num = 11;
    Block();
    
    
    
    return;
    // 一组异步任务 在多个线程执行
    if ((0)) {
        CCLOG(@"cc_group %@",[NSThread currentThread]);
        [ccs threadGroup:3 block:^(NSUInteger taskIndex, BOOL finish) {
            if (taskIndex == 0) {
                CCLOG(@"cc_group 0 finish %d %@",finish,[NSThread currentThread]);
            } else if (taskIndex == 1){
                CCLOG(@"cc_group 1 finish %d %@",finish,[NSThread currentThread]);
            } else if (taskIndex == 2){
                CCLOG(@"cc_group 2 finish %d %@",finish,[NSThread currentThread]);
            } else {
                CCLOG(@"cc_group 3 finish %d %@",finish,[NSThread currentThread]);
            }
        }];
    }
    
    // 异步完成一组有异步回调的函数后执行下一个函数
    if ((0)) {
        CCLOG(@"cc_blockGroup %@",[NSThread currentThread]);
        [ccs threadBlockGroup:2 block:^(NSUInteger taskIndex, BOOL finish, id sema) {
            if (taskIndex == 0) {
                CCLOG(@"cc_blockGroup 0 %@",[NSThread currentThread]);
                [ccs delay:2 block:^{
                    [ccs threadBlockFinish:sema];
                }];
            }else if (taskIndex == 1){
                CCLOG(@"cc_blockGroup 1 %@",[NSThread currentThread]);
                [ccs delay:2 block:^{
                    [ccs threadBlockFinish:sema];
                }];
            }
            if (finish) {
                CCLOG(@"cc_blockGroup finish %@",[NSThread currentThread]);
            }
        }];
    }
    
    // 顺序执行一组有异步回调的函数后执行下一个函数
    if ((1)) {
        CCLOG(@"cc_blockSequence %@",[NSThread currentThread]);
        [ccs threadBlockSequence:2 block:^(NSUInteger taskIndex, BOOL finish, id  _Nonnull sema) {
            if (taskIndex == 0) {
                CCLOG(@"cc_blockSequence 0 %@",[NSThread currentThread]);
                
                [ccs delay:5 block:^{
                    [ccs threadBlockFinish:sema];;
                }];
            } else if (taskIndex == 1) {
                CCLOG(@"cc_blockSequence 1 %@",[NSThread currentThread]);
                [ccs delay:2 block:^{
                    [ccs threadBlockFinish:sema];;
                }];
            }
            if (finish) {
                CCLOG(@"cc_blockSequence finish %@",[NSThread currentThread]);
            }
        }];

    }
    
}

@end
