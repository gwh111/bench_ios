//
//  CC_SandboxStorage.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_SandboxStore : CC_Object

+ (instancetype)shared;

- (NSString *)homePath;
- (NSString *)documentsPath;
// 判断文件(夹)是否存在
- (BOOL)isExistsAtPath:(NSString *)path;
// 获得目标文件的上级目录
- (NSString *)directoryAtPath:(NSString *)path;
// 删掉文件
- (void)deleteAtPath:(NSString *)path error:(NSError *__autoreleasing *)error;
// 创建路径
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error;
// 复制文件
- (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error;

// 获取 Documents 下的文件
- (NSData *)documentsFileWithPath:(NSString *)name type:(NSString *)type;
// 获取 Documents 下文件夹内的文件名列表
- (NSArray *)documentsDirectoryFilesWithPath:(NSString *)name type:(NSString *)type;
// 获取 Documents 下的plist
- (NSDictionary *)documentsPlistWithPath:(NSString *)name;
// 删除 Documents 下的文件
- (void)deleteDocumentsFileWithName:(NSString *)name;
// 保存文件到 Documents 下
- (BOOL)saveToDocumentsWithData:(id)data toPath:(NSString *)name type:(NSString *)type;
// 创建文件夹到 Documents 下
- (void)createDocumentsDocWithName:(NSString *)docName;

@end

