//
//  CC_DefaultStore.h
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_DefaultStore : CC_Object

+ (id)getDefault:(NSString *)key;

// if 'value=nil' will do 'removeObjectForKey:'
+ (void)saveDefault:(NSString *)key value:(id)value;

// set init AES_KEY in 'CC_AES', 'CC_AES.shared.AESKey = 'xxx'', otherwise will use 'apple' as default key
+ (id)getSafeDefault:(NSString *)key;
+ (void)saveSafeDefault:(NSString *)key value:(id)value;

@end
