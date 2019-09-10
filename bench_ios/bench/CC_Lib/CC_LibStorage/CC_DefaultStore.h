//
//  CC_DefaultStore.h
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_DefaultStore : NSObject

+ (id)cc_default:(NSString *)key;

// if 'value=nil' will do 'removeObjectForKey:'
+ (void)cc_saveDefault:(NSString *)key value:(id)value;

// set init AES_KEY in 'CC_LibSecurity', otherwise will use 'apple' as default key
+ (id)cc_safeDefault:(NSString *)key;
+ (void)cc_saveSafeDefault:(NSString *)key value:(id)value;

@end
