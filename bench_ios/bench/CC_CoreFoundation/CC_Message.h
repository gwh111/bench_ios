//
//  CC_Message.h
//  testbenchios
//
//  Created by gwh on 2019/8/20.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cc_message : NSProxy

+ (id)cc_class:(Class)aClass method:(SEL)selector;
+ (id)cc_class:(Class)aClass method:(SEL)selector params:(id)param,...;
+ (id)cc_class:(Class)aClass method:(SEL)selector paramList:(NSArray *)paramList;

+ (id)cc_instance:(id)instance method:(SEL)selector;
+ (id)cc_instance:(id)instance method:(SEL)selector params:(id)param,...;
+ (id)cc_instance:(id)instance method:(SEL)selector paramList:(NSArray *)paramList;

// Method for component. Use 'ccs''s category as component open API.
+ (id)cc_targetClass:(NSString *)className method:(NSString *)method params:(id)param,...;
+ (id)cc_targetInstance:(id)target method:(NSString *)method params:(id)param,...;
+ (id)cc_targetAppDelegate:(NSString *)appDelegateName method:(NSString *)method block:(void (^)(BOOL success))block params:(id)param,...;

// Send action for registered lifecycle/runloop.
+ (void)cc_appDelegateMethod:(SEL)selector params:(id)param,...;

@end

