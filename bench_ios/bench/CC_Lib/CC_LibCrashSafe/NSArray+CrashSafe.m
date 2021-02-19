//
//  NSArray+CrashSafe.m
//  bench_ios
//
//  Created by gwh on 2020/1/16.
//

#import "NSArray+CrashSafe.h"
#import "CC_Foundation.h"
#import "CC_CoreCrash.h"

@implementation NSArray (CrashSafe)

+ (void)load {
#if DEBUG
        return;
#endif
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 没内容类型是__NSArray0
        {
            Class class = NSClassFromString(@"__NSArray0");
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
        }
        {
            Class class = NSClassFromString(@"__NSArrayI");
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
        }
        {
            Class class = NSClassFromString(@"__NSArrayI_Transfer");
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
        }
        // iOS10 以上，单个内容类型是__NSSingleObjectArrayI
        {
            Class class = NSClassFromString(@"__NSSingleObjectArrayI");
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
        }
    });
}

- (instancetype)safe_objectAtIndex:(NSUInteger)index {
    if (index > (self.count - 1)) {
        [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }else {
        return [self safe_objectAtIndex:index];
    }
}

- (instancetype)safe_objectAtIndexedSubscript:(NSUInteger)index {
    if (index > (self.count - 1)) {
        [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }else {
        return [self safe_objectAtIndexedSubscript:index];
    }
}

- (void)addObject:(id)anObject {
    [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols] info:@"addObject to NSArray failed, use NSMutableArray"];
}

- (void)removeObject:(id)anObject {
    [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols] info:@"removeObject to NSArray failed, use NSMutableArray"];
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols] info:@"insertObject to NSArray failed, use NSMutableArray"];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols] info:@"removeObjectAtIndex to NSArray failed, use NSMutableArray"];
}

@end

@implementation NSMutableArray (CrashSafe)

+ (void)load {
static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        {
            Class class = NSClassFromString(@"__NSArrayM");
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(objectAtIndexedSubscript:) withMethod:@selector(safe_objectAtIndexedSubscript:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(addObject:) withMethod:@selector(safe_addObject:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(insertObject:atIndex:) withMethod:@selector(safe_insertObject:atIndex:)];
            [CC_Runtime cc_swizzlingInstance:class method:@selector(removeObjectAtIndex:) withMethod:@selector(safe_removeObjectAtIndex:)];
        }
    });
}

- (void)safe_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self safe_addObject:anObject];
}

- (instancetype)safe_objectAtIndex:(NSUInteger)index {
    if (index > (self.count - 1)) {
        [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }else {
        return [self safe_objectAtIndex:index];
    }
}

- (instancetype)safe_objectAtIndexedSubscript:(NSUInteger)index {
    if (index > (self.count - 1)) {
        [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }else {
        return [self safe_objectAtIndexedSubscript:index];
    }
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @synchronized (self) {
        if (anObject && index <= self.count) {
            [self safe_insertObject:anObject atIndex:index];
        } else {
            if (!anObject) {
                [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
            }
            if (index > self.count) {
                [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
            }
        }
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    @synchronized (self) {
        if (index < self.count) {
            [self safe_removeObjectAtIndex:index];
        } else {
            [CC_CoreCrash.shared addWarningStackSymbols:[NSThread callStackSymbols]];
        }
    }
}

@end
