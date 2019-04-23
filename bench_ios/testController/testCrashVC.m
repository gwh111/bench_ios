//
//  testCrashVC.m
//  bench_ios
//
//  Created by gwh on 2019/4/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testCrashVC.h"

@interface testCrashVC ()

@end

@implementation testCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    NSArray *arr = @[@(0), @(1)];
    CCLOG(@"%@", arr[2]); //模拟越界异常
    
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    CCLOG(@"%@\n%@\n%@",arr, reason, name);
    
    BOOL isContiune = TRUE; // 是否要保活
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (isContiune) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, true);
        }
    }
    CFRelease(allModes);
    
}
void UncaughtExceptio(NSException *exception) {
    
}

@end
