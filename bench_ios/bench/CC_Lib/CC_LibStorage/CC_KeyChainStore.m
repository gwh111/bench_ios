//
//  KeyChainStore.m
//  HHSLive
//
//  Created by 杜文杰 on 2017/9/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_KeyChainStore.h"
#import "CC_BundleStore.h"

@implementation CC_KeyChainStore

+ (void)cc_saveKeychainWithName:(NSString *)key str:(NSString *)str{
    [CC_KeyChainStore save:key data:str];
}

+ (NSString *)cc_keychainWithName:(NSString *)name{
    NSString *strUUID = (NSString *)[CC_KeyChainStore load:name];
    return strUUID;
}

+ (NSString *)cc_keychainUUID{
    NSString *strUUID = (NSString *)[CC_KeyChainStore load:[CC_BundleStore cc_appBid]];
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""]|| !strUUID) {
        //生成一个uuid的方法
        strUUID = [NSUUID UUID].UUIDString;
        //将该uuid保存到keychain
        [self cc_saveKeychainWithName:[CC_BundleStore cc_appBid] str:strUUID];
    }
    return strUUID;
}

#pragma mark private
+ (id)load:(NSString *)service{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    // Configure the search setting
    // Since in our simple case we areexpecting only a single attribute to be returned (the password) wecan set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery,(CFTypeRef*)&keyData) ==noErr){
        @try{
            ret =[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)keyData];
        }@catch(NSException *e) {
            CCLOG(@"Unarchive of %@ failed: %@",service, e);
        }@finally{
            
        }
    }
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
           (id)kSecClassGenericPassword,(id)kSecClass,
           service,(id)kSecAttrService,
           service,(id)kSecAttrAccount,
           (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
           nil];
}


+ (void)save:(NSString *)service data:(id)data{
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    // Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    // Add new object to searchdictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]forKey:(id)kSecValueData];
    // Add item to keychain with the searchdictionary
    SecItemAdd((CFDictionaryRef)keychainQuery,NULL);
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
