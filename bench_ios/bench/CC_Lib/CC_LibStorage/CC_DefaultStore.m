//
//  CC_DefaultStore.m
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_DefaultStore.h"
#import "CC_AES.h"

@implementation CC_DefaultStore

+ (id)getDefault:(NSString *)key {
    if (!key) {
        CCLOG(@"error:key=nil");
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+ (void)saveDefault:(NSString *)key value:(id)value {
    if (!key) {
        CCLOG(@"error:key=nil");
        return;
    }
    if (!value) {
        CCLOG(@"error:v=nil");
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
        return;
    }
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)getSafeDefault:(NSString *)key {
    NSString *aesk;
    if (!aesk) {
        CCLOG(@"没有设置加密key 默认使用apple");
        aesk=@"apple";
    }
    NSData *oriData = [CC_DefaultStore getDefault:key];
    if (!oriData) {
        return nil;
    }
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [CC_AES decryptData:oriData key:aeskey];
    NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeString;
}

+ (void)saveSafeDefault:(NSString *)key value:(id)value {
    NSString *aesk;
    if (!aesk) {
        CCLOG(@"没有设置加密key 默认使用apple");
        aesk = [CC_AES shared].AESKey;
    }
    if (!value) {
        [CC_DefaultStore saveDefault:key value:nil];
        return;
    }
    NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData3 = [CC_AES encryptData:data key:aeskey];
    [CC_DefaultStore saveDefault:key value:encodeData3];
}

@end
