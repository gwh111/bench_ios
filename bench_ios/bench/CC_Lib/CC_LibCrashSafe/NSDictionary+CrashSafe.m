//
//  NSDictionary+CrashSafe.m
//  bench_ios
//
//  Created by gwh on 2020/1/15.
//

#import "NSDictionary+CrashSafe.h"
#import "CC_Foundation.h"
#import "CC_CoreCrash.h"

@implementation NSDictionary (CrashSafe)

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols] info:@"setObject to NSDictionary failed, use NSMutableDictionary"];
}

@end

@implementation NSMutableDictionary (CrashSafe)

+ (void)load {
#if DEBUG
        return;
#endif
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [CC_Runtime cc_exchangeInstance:class method:@selector(setObject:forKey:) withMethod:@selector(safe_setObject:forKey:)];
        [CC_Runtime cc_exchangeInstance:class method:@selector(setObject:forKeyedSubscript:) withMethod:@selector(safe_setObject:forKeyedSubscript:)];
    });
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self safe_setObject:anObject forKey:aKey];
}

- (void)safe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self safe_setObject:obj forKeyedSubscript:key];
}

@end
