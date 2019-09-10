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

+ (id)cc_default:(NSString *)key{
    if (!key) {
        CCLOG(@"error:key=nil");
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+ (void)cc_saveDefault:(NSString *)key value:(id)value{
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

+ (id)cc_safeDefault:(NSString *)key{
    NSString *aesk;
    if (!aesk) {
        CCLOG(@"没有设置加密key 默认使用apple");
        aesk=@"apple";
    }
    NSData *oriData=[CC_DefaultStore cc_default:key];
    if (!oriData) {
        return nil;
    }
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [CC_AES cc_decryptData:oriData key:aeskey];
    NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeString;
}

+ (void)cc_saveSafeDefault:(NSString *)key value:(id)value{
    NSString *aesk;
    if (!aesk) {
        CCLOG(@"没有设置加密key 默认使用apple");
        aesk = [CC_AES shared].cc_AESKey;
    }
    if (!value) {
        [CC_DefaultStore cc_saveDefault:key value:nil];
        return;
    }
    NSData *data =[value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData3 = [CC_AES cc_encryptData:data key:aeskey];
    [CC_DefaultStore cc_saveDefault:key value:encodeData3];
}

@end
