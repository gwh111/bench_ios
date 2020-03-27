//
//  CrashTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/15.
//

#import <XCTest/XCTest.h>
#import "ccs.h"
#import "Person.h"
#import "CC_CoreCrash.h"
#import <objc/runtime.h>

@interface CrashTests : XCTestCase

@end

@implementation CrashTests

- (void)testExample {
    
    
    
}

- (void)testNotExist {
    
    
}

+ (id)unknow {
    
    CCLOG(@"error: unknow method called");
    // 返回nil防止外部持续调用崩溃
    return nil;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {

    [self addMethod:sel];
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel {

    [self addMethod:sel];
    return YES;
}

+ (void)addMethod:(SEL)sel {
    // 如果没有这个类方法，补救一次
    id method = NSStringFromSelector(sel);
    if ([method isEqualToString:@"start"]) {
        return;
    }

    NSString *class = NSStringFromClass(object_getClass(self));

    // 在加入Exceptions后断言
    // 收集问题，debug下断言，release时记录
    [CC_CoreCrash.shared methodNotExist:method className:class];

    // 转发到unknow方法
    Class cls = objc_getClass([NSStringFromClass(self) UTF8String]);
    IMP imp = class_getMethodImplementation(objc_getMetaClass([NSStringFromClass(self) UTF8String]), @selector(unknow));
    class_addMethod(cls, sel, imp, "v@:");
}

- (void)testCatchException {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    // 只能在appdeleage里注册
    [ccs.coreCrash setupUncaughtExceptionHandler];
    id arr = @[];
    [arr rangeAtIndex:4];
    
}

- (void)testArr {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    NSArray *arr = @[@"1"];
    id idadd = arr;
    [idadd addObject:@"1"];
    id i = arr[5];
    [arr objectAtIndex:3];
    
}

- (void)testMutArr {
    
    ccs.coreCrash.ignoreCrashWarning = YES;
    NSMutableArray *arr = ccs.mutArray;
    [arr removeObject:nil];
    [arr cc_addObject:@"1"];
    id i = arr[5];
    [arr objectAtIndex:3];
    
}

- (void)testDic {
    
    id dic = NSDictionary.new;
    [dic setObject:@"1" forKey:@"2"];
    
}

- (void)testMutDic {
    
    id mutDic = NSMutableDictionary.new;
    [mutDic setObject:@"1" forKey:nil];
    
}

@end
