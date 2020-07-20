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

+ (NSDictionary *)appBundle {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appName {
    return [self appBundle][@"CFBundleName"];
}

+ (NSString *)appBid {
    return [self appBundle][@"CFBundleIdentifier"];
}

+ (NSString *)appVersion {
    return [self appBundle][@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleVersion {
    return [self appBundle][@"CFBundleVersion"];
}

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name
                                   type:(NSString *)type {
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:type
                                                        inDirectory:name];
    return paths;
}

+ (NSData *)bundleFileWithPath:(NSString *)name
                             type:(NSString *)type {
    if (!name) return nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath)
    {
        CCLOG(@"cannot find file path '%@'",name);
        return nil;
    }
    
    return [NSData dataWithContentsOfFile:filePath options:0 error:NULL];
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    if (!name) return nil;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath) {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!data) {
        CCLOG(@"cannot find plist '%@'",name);
    }
    return data;
}

+ (BOOL)copyBundleFileToSandboxToPath:(NSString *)name type:(NSString *)type {
    if (!name) {
        CCLOG(@"no name");
        return NO;
    }
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *sbPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (!filePath) {
        CCLOG(@"cannot find file path '%@'",name);
        return NO;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:sbPath]) {
        return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
    }
    if (![[NSFileManager defaultManager] removeItemAtPath:sbPath error:nil]) {
        return NO;
    }
    return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:sbPath error:nil];
}

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name {
    return [self copyBundleFileToSandboxToPath:name type:@"plist"];
}

+ (UIImage *)benchBundleImage:(NSString *)imgName {
    return [self bundleImage:imgName bundleName:@"bench_ios"];
}

+ (UIImage *)bundleImage:(NSString *)imgName bundleName:(NSString *)bundleName {

    UIImage *backImage;
    NSBundle *mainBundle = [NSBundle bundleForClass:self.class];
    if ([mainBundle pathForResource:bundleName ofType:@"bundle"]) {
        NSString *myBundlePath = [mainBundle pathForResource:bundleName ofType:@"bundle"];
        NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
        backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:imgName ofType:@"png"]];
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@2x",imgName] ofType:@"png"]];
        }
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@3x",imgName] ofType:@"png"]];
        }
    } else {
        NSString *appBundlePath = [mainBundle pathForResource:bundleName ofType:@"bundle"];
        NSBundle *appBundle = [NSBundle bundleWithPath:appBundlePath];
        NSString *myBundlePath = [appBundle pathForResource:@"Bundle" ofType:@"bundle"];
        NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
        backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:imgName ofType:@"png"]];
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@2x",imgName] ofType:@"png"]];
        }
        if (!backImage) {
            backImage = [UIImage imageWithContentsOfFile:[myBundle pathForResource:[NSString stringWithFormat:@"%@@3x",imgName] ofType:@"png"]];
        }
    }
    return backImage;
}

@end
