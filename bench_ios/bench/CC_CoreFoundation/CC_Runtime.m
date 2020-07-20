//
//  CC_Runtime.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Runtime.h"
#import <objc/runtime.h>
#import "CC_Base.h"

@interface CC_Runtime ()

@property (nonatomic,retain) NSMutableDictionary *instanceMap;
@property (nonatomic,retain) NSMutableDictionary *classMap;

@end

@implementation CC_Runtime

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_Runtime shared].instanceMap = [[NSMutableDictionary alloc]init];
        [CC_Runtime shared].classMap = [[NSMutableDictionary alloc]init];
    }];
}

+ (id)cc_getObject:(id)object key:(SEL)key {
    return objc_getAssociatedObject(object, key);
}

+ (void)cc_setObject:(id)object key:(SEL)key value:(id)value {
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)cc_setObject:(id)object value:(id)value {
    objc_setAssociatedObject(object, @selector(value), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)cc_exchangeInstance:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector {
    NSString *classStr = NSStringFromClass(aClass);
    NSString *meStr1 = NSStringFromSelector(oriSelector);
    NSString *key = [classStr stringByAppendingString:meStr1];
    if ([CC_Runtime shared].instanceMap[key]) {
        CCLOGAssert(@"'%@' has already been exchanged",meStr1);
    }
    [[CC_Runtime shared].instanceMap setObject:@"" forKey:key];
    
    Method before = class_getInstanceMethod(aClass, oriSelector);
    Method after = class_getInstanceMethod(aClass, newSelector);
    method_exchangeImplementations(before, after);
}

+ (void)cc_exchangeClass:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector {
    NSString *meStr1 = NSStringFromSelector(oriSelector);
    if ([CC_Runtime shared].classMap[meStr1]) {
        CCLOGAssert(@"'%@' has already been exchanged",meStr1);
    }
    NSString *meStr2 = NSStringFromSelector(newSelector);
    if ([CC_Runtime shared].classMap[meStr2]) {
        CCLOGAssert(@"'%@' has already been registerd",meStr2);
    }
    [[CC_Runtime shared].classMap setObject:@"" forKey:meStr1];
    [[CC_Runtime shared].classMap setObject:@"" forKey:meStr2];
    
    Method before = class_getClassMethod(aClass, oriSelector);
    Method after = class_getClassMethod(aClass, newSelector);
    method_exchangeImplementations(before, after);
}

+ (void)cc_swizzlingInstance:(Class)aClass method:(SEL)oriSelector withMethod:(SEL)newSelector {
    
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(aClass, oriSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, newSelector);
    
    /* add selector if not exist, implement append with method */
    if (class_addMethod(aClass,
                        oriSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(aClass,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(aClass,
                            newSelector,
                            class_replaceMethod(aClass,
                                                oriSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@end
