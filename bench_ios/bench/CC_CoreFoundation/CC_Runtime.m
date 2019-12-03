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

+ (instancetype)shared{
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_Runtime shared].instanceMap = [[NSMutableDictionary alloc]init];
        [CC_Runtime shared].classMap = [[NSMutableDictionary alloc]init];
    }];
}

+ (id)cc_getObject:(id)object key:(SEL)key{
    return objc_getAssociatedObject(object, key);
}

+ (void)cc_setObject:(id)object key:(SEL)key value:(id)value{
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)cc_setObject:(id)object value:(id)value{
    objc_setAssociatedObject(object, @selector(value), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)cc_exchangeInstance:(Class)aClass method:(SEL)s1 withMethod:(SEL)s2 {
    NSString *meStr1 = NSStringFromSelector(s1);
    if ([CC_Runtime shared].instanceMap[meStr1]) {
        CCLOGAssert(@"'%@' has been registerd",meStr1);
    }
    NSString *meStr2 = NSStringFromSelector(s2);
    if ([CC_Runtime shared].instanceMap[meStr2]) {
        CCLOGAssert(@"'%@' has been registerd",meStr2);
    }
    [[CC_Runtime shared].instanceMap setObject:@"" forKey:meStr1];
    [[CC_Runtime shared].instanceMap setObject:@"" forKey:meStr2];
    
    Method before = class_getInstanceMethod(aClass, s1);
    Method after = class_getInstanceMethod(aClass, s2);
    method_exchangeImplementations(before, after);
}

+ (void)cc_exchangeClass:(Class)aClass method:(SEL)s1 withMethod:(SEL)s2 {
    NSString *meStr1 = NSStringFromSelector(s1);
    if ([CC_Runtime shared].classMap[meStr1]) {
        CCLOGAssert(@"'%@' has been registerd",meStr1);
    }
    NSString *meStr2 = NSStringFromSelector(s2);
    if ([CC_Runtime shared].classMap[meStr2]) {
        CCLOGAssert(@"'%@' has been registerd",meStr2);
    }
    [[CC_Runtime shared].classMap setObject:@"" forKey:meStr1];
    [[CC_Runtime shared].classMap setObject:@"" forKey:meStr2];
    
    Method before = class_getClassMethod(aClass, s1);
    Method after = class_getClassMethod(aClass, s2);
    method_exchangeImplementations(before, after);
}

@end
