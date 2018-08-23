//
//  KeyChainStore.m
//  HHSLive
//
//  Created by 杜文杰 on 2017/9/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_KeyChainStore.h"

@implementation CC_KeyChainStore

+ (id)load:(NSString*)service {
    id ret =nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we areexpecting only a single attribute to be returned (the password) wecan set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if(SecItemCopyMatching((CFDictionaryRef)keychainQuery,(CFTypeRef*)&keyData) ==noErr){
        @try{
            ret =[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)keyData];
        }@catch(NSException *e) {
            NSLog(@"Unarchiveof %@ failed: %@",service, e);
        }@finally{
        }
    }
    if(keyData)
        CFRelease(keyData);
    return ret;
}

+ (NSMutableDictionary*)getKeychainQuery:(NSString*)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
           (id)kSecClassGenericPassword,(id)kSecClass,
           service,(id)kSecAttrService,
           service,(id)kSecAttrAccount,
           (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
           nil];
}


+ (void)save:(NSString*)service data:(id)data{
    //Get search dictionary
    NSMutableDictionary*keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to searchdictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]forKey:(id)kSecValueData];
    //Add item to keychain with the searchdictionary
    SecItemAdd((CFDictionaryRef)keychainQuery,NULL);
}

+ (void)deleteKeyData:(NSString*)service {
    NSMutableDictionary*keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
