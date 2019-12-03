//
//  CC_Message.m
//  testbenchios
//
//  Created by gwh on 2019/8/20.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Message.h"
#import "CC_Base.h"
#import "CC_CoreBase.h"

#import "CC_Int.h"
#import "CC_Float.h"
#import "CC_Double.h"

#import "CC_Monitor.h"

@implementation cc_message

+ (id)cc_class:(Class)aClass method:(SEL)selector {
    return [self cc_target:aClass method:selector paramList:nil];
}

+ (id)cc_class:(Class)aClass method:(SEL)selector params:(id)param,... {
    NSMethodSignature *signature = [aClass methodSignatureForSelector:selector];
    NSInteger paramsCount = signature.numberOfArguments - 2;
    NSMutableArray *paramList = NSMutableArray.new;
    va_list params;
    va_start(params, param);
    int i = 0;
    for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
        if (tmpObject) {
            [paramList addObject:tmpObject];
        }else{
            [paramList addObject:NSNull.new];
        }
        i++;
        if (i >= paramsCount) {
            break;
        }
    }
    va_end(params);
    return [self cc_target:aClass method:selector paramList:paramList];
}

+ (id)cc_class:(Class)aClass method:(SEL)selector paramList:(NSArray *)paramList {
    return [self cc_target:aClass method:selector paramList:paramList];
}

+ (id)cc_instance:(id)instance method:(SEL)selector {
    return [self cc_target:instance method:selector paramList:nil];
}

+ (id)cc_instance:(id)instance method:(SEL)selector params:(id)param,... {
    NSMethodSignature *signature = [instance methodSignatureForSelector:selector];
    NSInteger paramsCount = signature.numberOfArguments - 2;
    NSMutableArray *paramList = NSMutableArray.new;
    va_list params;
    va_start(params, param);
    int i = 0;
    for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
        if (tmpObject) {
            [paramList addObject:tmpObject];
        }else{
            [paramList addObject:NSNull.new];
        }
        i++;
        if (i >= paramsCount) {
            break;
        }
    }
    va_end(params);
    return [self cc_target:instance method:selector paramList:paramList];
}

+ (id)cc_instance:(id)instance method:(SEL)selector paramList:(NSArray *)paramList {
    return [self cc_target:instance method:selector paramList:paramList];
}

+ (void)cc_appDelegateMethod:(SEL)selector params:(id)param,... {
    NSArray *keys = [CC_CoreBase.shared.cc_sharedAppDelegate allKeys];
    for (NSString *name in keys) {
        
        NSString *method = NSStringFromSelector(selector);
        [CC_Monitor.shared watchStart:name method:method];
        
        id target = CC_CoreBase.shared.cc_sharedAppDelegate[name];
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        NSInteger paramsCount = signature.numberOfArguments - 2;
        NSMutableArray *paramsList = [CC_Base.shared cc_init:NSMutableArray.class];
        va_list params;
        va_start(params, param);
        int i = 0;
        for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
            if (tmpObject) {
                [paramsList addObject:tmpObject];
            }else{
                [paramsList addObject:[CC_Base.shared cc_init:NSNull.class]];
            }
            i++;
            if (i >= paramsCount) {
                break;
            }
        }
        va_end(params);
        [cc_message cc_target:target method:selector paramList:paramsList];
        
        [CC_Monitor.shared watchEnd:name method:method];
    }
}

+ (id)cc_targetClass:(NSString *)className method:(NSString *)method params:(id)param,... {
    Class targetClass = NSClassFromString(className);
    SEL selector = NSSelectorFromString(method);
    NSMethodSignature *signature = [targetClass methodSignatureForSelector:selector];
    if (!signature) {
        CCLOG(@"<<< error:\n<<< target not found!");
    }
    NSInteger paramsCount = signature.numberOfArguments - 2;
    NSMutableArray *paramList = NSMutableArray.new;
    va_list params;
    va_start(params, param);
    int i = 0;
    for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
        if (tmpObject) {
            [paramList addObject:tmpObject];
        }else{
            [paramList addObject:NSNull.new];
        }
        i++;
        if (i >= paramsCount) {
            break;
        }
    }
    va_end(params);
    return [self cc_target:targetClass method:selector paramList:paramList];
}

+ (id)cc_targetInstance:(id)target method:(NSString *)method params:(id)param,... {
    SEL selector = NSSelectorFromString(method);
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    if (!signature) {
        CCLOG(@"<<< error:\n<<< target not found!");
    }
    NSInteger paramsCount = signature.numberOfArguments - 2;
    NSMutableArray *paramList = NSMutableArray.new;
    va_list params;
    va_start(params, param);
    int i = 0;
    for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
        if (tmpObject) {
            [paramList addObject:tmpObject];
        }else{
            [paramList addObject:NSNull.new];
        }
        i++;
        if (i >= paramsCount) {
            break;
        }
    }
    va_end(params);
    return [self cc_target:target method:selector paramList:paramList];
}

+ (id)cc_targetAppDelegate:(NSString *)appDelegateName method:(NSString *)method block:(void (^)(BOOL success))block params:(id)param,... {
    SEL selector = NSSelectorFromString(method);
    id appDelegate = CC_CoreBase.shared.cc_sharedAppDelegate[appDelegateName];
    NSMethodSignature *signature = [appDelegate methodSignatureForSelector:selector];
    if (!signature) {
        CCLOG(@"<<< error:\n<<< target not found!");
        block(NO);
    }
    NSInteger paramsCount = signature.numberOfArguments - 2;
    NSMutableArray *paramList = NSMutableArray.new;
    va_list params;
    va_start(params, param);
    int i = 0;
    for (id tmpObject = param; 1; tmpObject = va_arg(params, id)) {
        if (tmpObject) {
            [paramList addObject:tmpObject];
        }else{
            [paramList addObject:NSNull.new];
        }
        i++;
        if (i >= paramsCount) {
            break;
        }
    }
    va_end(params);
    return [self cc_target:appDelegate method:selector paramList:paramList];
}

+ (id)cc_target:(id)target method:(SEL)selector paramList:(NSArray *)paramList {
    
    // message sent to deallocated instance 0x7f81204154e0
    // 使用NSInvocation方法对返回对象引用计数会有问题 怀疑是ARC没有控制好
    // 原因是在arc模式下，getReturnValue：仅仅是从invocation的返回值拷贝到指定的内存地址，如果返回值是一个NSObject对象的话，是没有处理起内存管理的。而我们在定义resultSet时使用的是__strong类型的指针对象，arc就会假设该内存块已被retain（实际没有），当resultSet出了定义域释放时，导致该crash。假如在定义之前有赋值的话，还会造成内存泄露的问题。
    // 所以在接收id对象时用__unsafe_unretained修饰来临时保留对象来解决这个问题
    if (target && [target respondsToSelector:selector]) {
        NSMethodSignature *methodSig = [target methodSignatureForSelector:selector];
        if (methodSig == nil) {
            return nil;
        }
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setTarget:target];
        [invocation setSelector:selector];
        for (NSInteger i = 0; i < paramList.count; i++) {
            id obj = paramList[i];
            if (![obj isKindOfClass:NSNull.class]) {
                [invocation setArgument:&obj atIndex:i+2];
                if ([obj isKindOfClass:CC_Int.class]) {
                    CC_Int *ccint = (CC_Int *)obj;
                    int value = ccint.value;
                    [invocation setArgument:&value atIndex:i+2];
                }else if ([obj isKindOfClass:CC_Float.class]){
                    CC_Float *ccfloat = (CC_Float *)obj;
                    float value = ccfloat.value;
                    [invocation setArgument:&value atIndex:i+2];
                }else if ([obj isKindOfClass:CC_Double.class]){
                    CC_Double *ccdouble = (CC_Double *)obj;
                    double value = ccdouble.value;
                    [invocation setArgument:&value atIndex:i+2];
                }
                else{
                    [invocation setArgument:&obj atIndex:i+2];
                }
            }
        }
        [invocation invoke];
        if (methodSig.methodReturnLength) {
            const char *retType = [methodSig methodReturnType];
            if (strcmp(retType, @encode(id)) == 0) {
                id __unsafe_unretained tempResult;
                [invocation getReturnValue:&tempResult];
                id result = tempResult;
                return result;
            }
            if (strcmp(retType, @encode(float)) == 0) {
                float result = 0;
                [invocation getReturnValue:&result];
                return @(result);
            }
            if (strcmp(retType, @encode(int)) == 0) {
                int result = 0;
                [invocation getReturnValue:&result];
                return @(result);
            }
            if (strcmp(retType, @encode(double)) == 0) {
                double result = 0;
                [invocation getReturnValue:&result];
                return @(result);
            }
            if (strcmp(retType, @encode(NSInteger)) == 0) {
                NSInteger result = 0;
                [invocation getReturnValue:&result];
                return @(result);
            }
            // Result may as NSInteger/NSUInteger/BOOL/CGFloat...
            NSUInteger result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
        return nil;
    }
    if (!target) {
        CCLOG(@"<<< error:\n<<< target not found!");
    }
    if (![target respondsToSelector:selector]) {
        if ([NSStringFromSelector(selector) isEqualToString:@"start"]) {
            return nil;
        }
        CCLOG(@"<<< error:\n<<< %@ not found!", NSStringFromSelector(selector));
    }
    return nil;
}

@end
