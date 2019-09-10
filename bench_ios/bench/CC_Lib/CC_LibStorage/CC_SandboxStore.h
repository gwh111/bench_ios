//
//  CC_SandboxStorage.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_SandboxStore : NSObject

+ (NSString *)cc_sandboxPath;

+ (NSData *)cc_sandboxFileWithPath:(NSString *)name type:(NSString *)type;
// 'plist' is a special case of file
+ (NSDictionary *)cc_sandboxPlistWithPath:(NSString *)name;

// 获取沙盒指定路径下文件列表
+ (NSArray *)cc_sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type;

#pragma mark action
+ (BOOL)cc_deleteSandboxFileWithName:(NSString *)name;
+ (BOOL)cc_saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type;

@end

