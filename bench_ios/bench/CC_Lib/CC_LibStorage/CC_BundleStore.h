//
//  CC_BundleStore.h
//  testbenchios
//
//  Created by gwh on 2019/8/12.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_BundleStore : NSObject

// NSBundle
+ (NSString *)cc_appName;
+ (NSString *)cc_appBid;
+ (NSString *)cc_appVersion;
+ (NSString *)cc_appBundleVersion;
+ (NSDictionary *)cc_appBundle;

+ (NSArray *)cc_bundleFileNamesWithPath:(NSString *)name type:(NSString *)type;
+ (NSData *)cc_bundleFileWithPath:(NSString *)name type:(NSString *)type;
// 'plist' is a special case of file
+ (NSDictionary *)cc_bundlePlistWithPath:(NSString *)name;

// 复制工程下的文件到沙盒
+ (BOOL)cc_copyBunldFileToSandboxToPath:(NSString *)name type:(NSString *)type;
// 'plist' is a special case of file
+ (BOOL)cc_copyBunldPlistToSandboxToPath:(NSString *)name;

@end

