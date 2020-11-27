//
//  CC_Object.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Object.h"
#import "CC_CoreCrash.h"
#import <objc/runtime.h>

@implementation CC_Object

+ (id)unknowMethod:(NSString *)method className:(NSString *)className {
    
    // 在加入Exceptions后断言
    // 收集问题，debug下断言，release时记录
    [CC_CoreCrash.shared methodNotExist:method className:className];
    
    CCLOG(@"error: unknow method called");
    // 返回nil防止外部持续调用崩溃
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];//签名，进入forwardInvocation
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:@@"];//签名，进入forwardInvocation
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
#ifdef DEBUG
#else
    id method = NSStringFromSelector(anInvocation.selector);
    NSString *class = NSStringFromClass(object_getClass(self));
    // 转发到unknow并记录异常
    SEL unknow = NSSelectorFromString(@"unknowMethod:className:");
    anInvocation.selector = unknow;
    [anInvocation setArgument:&method atIndex:2];
    [anInvocation setArgument:&class atIndex:3];
    [anInvocation invokeWithTarget:self.class];
#endif
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
#ifdef DEBUG
#else
    id method = NSStringFromSelector(anInvocation.selector);
    NSString *class = NSStringFromClass(object_getClass(self));
    // 转发到unknow并记录异常
    SEL unknow = NSSelectorFromString(@"unknowMethod:className:");
    anInvocation.selector = unknow;
    [anInvocation setArgument:&method atIndex:2];
    [anInvocation setArgument:&class atIndex:3];
    [anInvocation invokeWithTarget:self.class];
#endif
}

@end
