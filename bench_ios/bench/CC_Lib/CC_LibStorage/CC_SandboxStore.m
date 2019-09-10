//
//  CC_SandboxStorage.m
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_SandboxStore.h"

@implementation CC_SandboxStore

+ (NSString *)cc_sandboxPath
{
    NSString *path = [NSString stringWithFormat:@"%@", NSHomeDirectory()];
    CCLOG(@"%@",path);
    return path;
}

+ (NSData *)cc_sandboxFileWithPath:(NSString *)name type:(NSString *)type
{
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

+ (NSDictionary *)cc_sandboxPlistWithPath:(NSString *)name
{
    if (!name) return nil;
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        NSMutableDictionary *setupDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        return setupDic;
    }
    CCLOG(@"no such file '%@'",name);
    return nil;
}

+ (NSArray *)cc_sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type
{
    if (!name) return nil;
    
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
    NSArray *fileList = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    if (!type.length) return nil;
    
    NSMutableArray *fileMutList = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < fileList.count; i++)
    {
        NSString *file = fileList[i];
        
        if (![file hasSuffix:type]) continue;
        
        [fileMutList addObject:file];
        
    }
    return fileMutList;
}

+ (BOOL)cc_deleteSandboxFileWithName:(NSString *)name
{
    if (!name) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //文件名
    NSString *uniquePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    
    if (![fileManager fileExistsAtPath:uniquePath])
    {
        CCLOG(@"no such file '%@'",name);
        return NO;
    }
    return [fileManager removeItemAtPath:uniquePath error:nil];
}

+ (BOOL)cc_saveToSandboxWithData:(id)data
                          toPath:(NSString *)name
                            type:(NSString *)type
{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath = documentsDirectory;
    NSString *fileName;
    if (type.length>0) {
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

@end
