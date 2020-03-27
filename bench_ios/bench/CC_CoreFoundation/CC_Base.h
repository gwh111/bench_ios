//
//  CC_Basic.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_CoreMacro.h"
#import "CC_Object.h"

@interface CC_Base : CC_Object

// Buttons in UIKit minimum tap interval
@property (nonatomic,assign) NSTimeInterval acceptEventInterval;

@property (nonatomic,assign) BOOL debug;
@property (nonatomic,assign) int environment;

+ (instancetype)shared;

+ (void)cc_willInit;

// Init object for 'class'
- (id)cc_init:(Class)aClass;

- (id)cc_getAppDelegate:(Class)aClass;
// For moduler register a lifecycle/runloop.
- (id)cc_registerAppDelegate:(id)module;

// Return sharedInstance.
- (id)cc_registerSharedInstance:(id)shared;
- (id)cc_registerSharedInstance:(id)shared block:(void(^)(void))block;

// Get shared object as key-value.
// Flyweight 享元模式
- (id)cc_shared:(NSString *)key;
- (id)cc_removeShared:(NSString *)key;
// Cannot overlap shared object, use 'resetShared' to overlap.
- (id)cc_setShared:(NSString *)key obj:(id)obj;
- (id)cc_resetShared:(NSString *)key obj:(id)obj;

// Bind object, private use only. Use 'cc_shared:' as needed.
- (id)cc_bind:(NSString *)key;
- (id)cc_setBind:(NSString *)key value:(id)value;

@end
