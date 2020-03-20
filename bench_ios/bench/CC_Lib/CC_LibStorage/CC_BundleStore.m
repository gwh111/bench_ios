//
//  CC_BundleStore.m
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_BundleStore.h"
#import "CC_SandboxStore.h"

@implementation CC_BundleStore

+ (NSDictionary *)cc_appBundle{
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)cc_appName{
    return [self cc_appBundle][@"CFBundleName"];
}

+ (NSString *)cc_appBid{
    return [self cc_appBundle][@"CFBundleIdentifier"];
}

+ (NSString *)cc_appVersion{
    return [self cc_appBundle][@"CFBundleShortVersionString"];
}

+ (NSString *)cc_appBundleVersion{
    return [self cc_appBundle][@"CFBundleVersion"];
}

+ (NSArray *)cc_bundleFileNamesWithPath:(NSString *)name
                                   type:(NSString *)type
{
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:type
                                                        inDirectory:name];
    return paths;
}

+ (NSData *)cc_bundleFileWithPath:(NSString *)name
                             type:(NSString *)type
{
    if (!name) return nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath)
    {
        CCLOG(@"cannot find file path '%@'",name);
        return nil;
    }
    
    return [NSData dataWithContentsOfFile:filePath options:0 error:NULL];
}

+ (NSDictionary *)cc_bundlePlistWithPath:(NSString *)name
{
    if (!name) return nil;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath)
    {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!data)
    {
        CCLOG(@"cannot find plist '%@'",name);
    }
    return data;
}

+ (BOOL)cc_copyBunldFileToSandboxToPath:(NSString *)name type:(NSString *)type
{
    if (!name) {
        CCLOG(@"no name");
        return NO;
    }
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *sbPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath)
    {
        CCLOG(@"cannot find file path '%@'",name);
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:sbPath])
    {
        return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
    }
    if (![[NSFileManager defaultManager] removeItemAtPath:sbPath error:nil])
    {
        return NO;
    }
    return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
}

+ (BOOL)cc_copyBunldPlistToSandboxToPath:(NSString *)name
{
    return [self cc_copyBunldFileToSandboxToPath:name type:@"plist"];
}

@end
