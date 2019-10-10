//
//  CC_Basic.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Base.h"
#import <malloc/malloc.h>
#import "CC_CoreBase.h"

//@interface CC_Base()
//
//// dispatch_once
//@property (nonatomic,retain) NSMutableDictionary *sharedDic;
//
//@property (nonatomic,retain) NSMutableDictionary *sharedObjDic;
//@property (nonatomic,retain) NSMutableDictionary *sharedObjBindDic;
//
//@end

@implementation CC_Base

static CC_Base *userManager = nil;
static dispatch_once_t onceToken;

+ (void)load {
    [self cc_willInit];
}

+ (instancetype)shared {
    dispatch_once(&onceToken, ^{
        userManager = [[CC_Base alloc]init];
    });
    return userManager;
}

+ (void)cc_willInit {
    
#if DEBUG
    [CC_Base shared].cc_debug = YES;
#else
    [CC_Base shared].cc_debug = NO;
#endif
}

- (id)cc_init:(Class)aClass {
    return [aClass new];
}

- (void)cc_registerAppDelegate:(id)module {
    NSString *classStr = NSStringFromClass([module class]);
    id obj = CC_CoreBase.shared.cc_sharedAppDelegate[classStr];
    if (!obj) {
        obj = [[module alloc]init];
        [CC_CoreBase.shared.cc_sharedAppDelegate setObject:obj forKey:classStr];
    }
}

- (id)cc_registerSharedInstance:(id)shared {
    NSString *classStr = NSStringFromClass([shared class]);
    id obj = CC_CoreBase.shared.sharedInstanceDic[classStr];
    if (!obj) {
        obj = [[shared alloc]init];
        [CC_CoreBase.shared.sharedInstanceDic setObject:obj forKey:classStr];
    }
    return obj;
}

- (id)cc_registerSharedInstance:(id)shared block:(void(^)(void))block {
    NSString *classStr = NSStringFromClass([shared class]);
    id obj = CC_CoreBase.shared.sharedInstanceDic[classStr];
    if (!obj) {
        obj = [[shared alloc]init];
        [CC_CoreBase.shared.sharedInstanceDic setObject:obj forKey:classStr];
        block();
    }
    return obj;
}

- (id)cc_shared:(NSString *)key {
    return CC_CoreBase.shared.sharedObjDic[key];
}

- (id)cc_removeShared:(NSString *)key {
    return [self cc_setShared:key obj:nil];
}

- (id)cc_bind:(NSString *)key {
    return CC_CoreBase.shared.sharedObjBindDic[key];
}

- (id)cc_setShared:(NSString *)key obj:(id)obj {
    if (!key) {
        return [self cc_shared:key];
    }
    if (!obj) {
        [CC_CoreBase.shared.sharedObjDic removeObjectForKey:key];
        return [self cc_shared:key];
    }
    if (CC_CoreBase.shared.sharedObjDic[key]) {
        CCLOGAssert(@"'%@' has been setted! use 'resetShared' to overlap",key);
    }
    [CC_CoreBase.shared.sharedObjDic setObject:obj forKey:key];
    return [self cc_shared:key];
}

- (id)cc_resetShared:(NSString *)key obj:(id)obj {
    if (!key) {
        return [self cc_shared:key];
    }
    if (!obj) {
        [CC_CoreBase.shared.sharedObjDic removeObjectForKey:key];
        return [self cc_shared:key];
    }
    [CC_CoreBase.shared.sharedObjDic setObject:obj forKey:key];
    return [self cc_shared:key];
}

- (id)cc_setBind:(NSString *)key value:(id)value {
    if (!key) {
        return [self cc_bind:key];
    }
    if (!value) {
        [CC_CoreBase.shared.sharedObjBindDic removeObjectForKey:key];
        return [self cc_bind:key];
    }
    [CC_CoreBase.shared.sharedObjBindDic setObject:value forKey:key];
    return [self cc_bind:key];
}

@end
