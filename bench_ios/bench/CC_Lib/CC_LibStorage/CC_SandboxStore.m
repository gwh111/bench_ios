//
//  CC_SandboxStorage.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_SandboxStore.h"

@implementation CC_SandboxStore

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (NSString *)homePath {
    NSString *path = [NSString stringWithFormat:@"%@", NSHomeDirectory()];
    CCLOG(@"%@",path);
    return path;
}

- (NSString *)documentsPath {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentPaths objectAtIndex:0];
    // NSString *uniquePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    CCLOG(@"%@",documentsPath);
    return documentsPath;
}

// 判断文件(夹)是否存在
- (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

// 获得目标文件的上级目录
- (NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}

// 删掉文件
- (void)deleteAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    if (!path) {
        return;
    }
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;

    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray *dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString *subPath = nil;
            for (NSString * str in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                if (issubDir) {
                    [self deleteAtPath:subPath error:error];
                } else {
                    [fileManger removeItemAtPath:path error:error];
                }
            }
        } else {
            [fileManger removeItemAtPath:path error:error];
        }
    }
    
//    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}

// 删掉Documents里的文件
- (void)deleteDocuments:(NSString *)name {
    if (!name) {
        return;
    }
    NSString *uniquePath = [[self homePath] stringByAppendingPathComponent:name];
    [self deleteAtPath:uniquePath error:nil];
}

// 创建路径
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}

// 复制文件
- (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径" format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [self directoryAtPath:toPath];
    if (![self isExistsAtPath:toDirPath]) {
        // 创建复制路径
        if (![self createDirectoryAtPath:toDirPath error:error]) {
            return NO;
        }
    }
    // 如果覆盖，那么先删掉原文件
    if (overwrite) {
        if ([self isExistsAtPath:toPath]) {
            [self deleteAtPath:toPath error:error];
        }
    }
    // 复制文件，如果不覆盖且文件已存在则会复制失败
    BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:error];
    
    return isSuccess;
}

- (NSData *)documentsFileWithPath:(NSString *)name type:(NSString *)type {
    if (!name) return nil;
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:type.length ? [NSString stringWithFormat:@"%@.%@",name,type] : [NSString stringWithFormat:@"%@",name]];
    
    if (!filePath)
    {
        CCLOG(@"cannot find file path '%@'",name);
        return nil;
    }
    
    return [NSData dataWithContentsOfFile:filePath options:0 error:NULL];
}

- (NSDictionary *)documentsPlistWithPath:(NSString *)name {
    if (!name) return nil;
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSMutableDictionary *setupDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        return setupDic;
    }
    CCLOG(@"no such file '%@'",name);
    return nil;
}

- (void)deleteDocumentsFileWithName:(NSString *)name {
    if (!name) {
        return;
    }
    
    //文件名
    NSString *uniquePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    
    [self deleteAtPath:uniquePath error:nil];
}

- (BOOL)saveToDocumentsWithData:(id)data toPath:(NSString *)name type:(NSString *)type {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath = documentsDirectory;
    NSString *fileName;
    if (type.length > 0) {
        fileName = [NSString stringWithFormat:@"%@/%@.%@",dataFilePath,name,type];
    }else{
        fileName = [NSString stringWithFormat:@"%@/%@",dataFilePath,name];
    }
    if ([name containsString:@"/"]) {
        NSArray *tempArr = [name componentsSeparatedByString:@"/"];
        NSString *lastName = [tempArr lastObject];
        name = [name stringByReplacingOccurrencesOfString:lastName withString:@""];
        dataFilePath = [dataFilePath stringByAppendingString:@"/"];
        dataFilePath = [dataFilePath stringByAppendingString:name];
    }
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    BOOL success = [data writeToFile:fileName atomically:YES];
    if (success) {
        return YES;
    }else{
        CCLOG(@"保存失败");
        return NO;
    }
}

- (void)createDocumentsDocWithName:(NSString *)docName {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath = documentsDirectory;
    dataFilePath = [dataFilePath stringByAppendingPathComponent:docName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (NSArray *)documentsDirectoryFilesWithPath:(NSString *)name type:(NSString *)type {
    if (!name) return nil;
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    NSArray *fileList = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    if (!type.length) return nil;
    
    NSMutableArray *fileMutList = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < fileList.count; i++) {
        NSString *file = fileList[i];
        
        if (![file hasSuffix:type]) continue;
        
        [fileMutList addObject:file];
    }
    return fileMutList;
}

@end
