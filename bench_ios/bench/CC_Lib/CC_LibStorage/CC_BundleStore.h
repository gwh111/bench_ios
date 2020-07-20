//
//  CC_BundleStore.h
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_BundleStore : CC_Object

// NSBundle
+ (NSString *)appName;
+ (NSString *)appBid;
+ (NSString *)appVersion;
+ (NSString *)appBundleVersion;
+ (NSDictionary *)appBundle;

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name type:(NSString *)type;
+ (NSData *)bundleFileWithPath:(NSString *)name type:(NSString *)type;
// 'plist' is a special case of file
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;

// 复制工程下的文件到沙盒
+ (BOOL)copyBundleFileToSandboxToPath:(NSString *)name type:(NSString *)type;
// 'plist' is a special case of file
+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;

+ (UIImage *)benchBundleImage:(NSString *)imgName;
+ (UIImage *)bundleImage:(NSString *)imgName bundleName:(NSString *)bundleName;

@end

