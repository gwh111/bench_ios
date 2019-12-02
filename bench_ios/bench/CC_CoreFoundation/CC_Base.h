//
//  CC_Basic.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_CoreMacro.h"

@interface CC_Base : NSObject

// Buttons in UIKit minimum tap interval
@property (nonatomic,assign) NSTimeInterval cc_acceptEventInterval;

@property (nonatomic,assign) BOOL cc_debug;
@property (nonatomic,assign) int cc_environment;

+ (instancetype)shared;

+ (void)cc_willInit;

// Init object for 'class'
- (id)cc_init:(Class)aClass;

// For moduler register a lifecycle/runloop.
- (void)cc_registerAppDelegate:(id)module;

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
