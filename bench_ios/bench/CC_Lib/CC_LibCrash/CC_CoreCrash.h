//
//  CC_CoreCrash.h
//  bench_ios
//
//  Created by gwh on 2020/1/15.
//

#import "CC_Foundation.h"
#import "NSDictionary+CrashSafe.h"
#import "NSArray+CrashSafe.h"

@interface CC_CoreCrash : CC_Object

// 忽略断言
@property (nonatomic, assign) BOOL ignoreCrashWarning;

+ (instancetype)shared;

- (void)showCrashNotice:(NSString *)crashNotice;

- (void)setupUncaughtExceptionHandler;

- (void)methodNotExist:(NSString *)method className:(NSString *)className;

- (void)addWarningStackSymbols:(NSArray *)stackSymbols;
- (void)addWarningStackSymbols:(NSArray *)stackSymbols info:(NSString *)info;

- (void)addCrashStackSymbols:(NSArray *)stackSymbols;

@end

