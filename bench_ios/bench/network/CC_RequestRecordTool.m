//
//  BBRequestRecordTool.m
//  BananaBall
//
//  Created by 路飞  on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_RequestRecordTool.h"
//记录网络请求的 URL、Response
@implementation CCReqRecord

+(CCReqRecord *)getInstance{
    static CCReqRecord *recordTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recordTool = [[CCReqRecord alloc]init];
    });
    return recordTool;
}

-(BOOL)insertRequestDataWithHHSService:(NSString *)service requestUrl:(NSString *)requestUrl parameters:(NSString *)parameters resModelDic:(NSDictionary *)dic{
    
    BOOL isSuccess = NO;
    
    NSString *plistPath = [self pathForPlist];
//    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    if (usersDic == nil) {
//        usersDic = [[NSMutableDictionary alloc]init];
//    }
//    if (service) {
//        [usersDic setObject:@{@"requestUrl":requestUrl, @"parameters":parameters, @"resultDic":dic} forKey:service];
//    }else if(requestUrl){
//        [usersDic setObject:@{@"requestUrl":requestUrl, @"parameters":parameters, @"resultDic":dic} forKey:requestUrl];
//    }
//
//    isSuccess = [usersDic writeToFile:plistPath atomically:YES];
    
    NSMutableArray *usersArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (usersArr == nil) {
        usersArr = [[NSMutableArray alloc]init];
    }
    
    [usersArr insertObject:@{@"requestUrl":requestUrl, @"parameters":parameters, @"resultDic":dic} atIndex:0];
    
    isSuccess = [usersArr writeToFile:plistPath atomically:YES];
    
    return isSuccess;
}

-(NSString *)pathForPlist{
    BOOL isDir = NO;
    // temp路径
    NSString * docsdir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:@"requestRecod"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [dataFilePath stringByAppendingPathComponent:@"record.plist"];
    
    return path;
}

-(NSString *)totalParameters{
    NSString *plistPath = [self pathForPlist];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!usersDic) {
        return nil;
    }
    NSString * paraStr = @"";
    for (NSDictionary * dic in usersDic.allValues) {
        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@", dic[@"parameters"]]];
    }
    paraStr = [paraStr substringFromIndex:1];
    return paraStr;
}
-(NSString *)totalRequestUrls{
    NSString *plistPath = [self pathForPlist];
//    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    if (!usersDic) {
//        return nil;
//    }
//    NSString * paraStr = @"";
//    for (NSDictionary * dic in usersDic.allValues) {
//        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@", dic[@"requestUrl"]]];
//    }
//    paraStr = [paraStr substringFromIndex:1];
//    return paraStr;
    NSMutableArray *arr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (arr.count < 1) {
        return nil;
    }
    NSDictionary *dic = arr[0];
    return dic[@"resultDic"][@"_requestUrlStr"];
    
}
-(NSString *)getTotalStr{
    NSString *plistPath = [self pathForPlist];
//    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//    if (!usersDic) {
//        return nil;
//    }
//    NSString * paraStr = @"";
//    for (NSDictionary * dic in usersDic.allValues) {
//        NSString *urlS=dic[@"requestUrl"];
//        if (![urlS hasSuffix:@"?"]) {
//            urlS=[urlS stringByAppendingString:@"?"];
//        }
//        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@%@",urlS,dic[@"parameters"]]];
//    }
//    paraStr = [paraStr substringFromIndex:1];
//    return paraStr;
    NSMutableArray *arr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (arr.count < 1) {
        return nil;
    }
    NSDictionary *dic = arr[0];
    return dic[@"resultDic"][@"_requestUrlStr"];
}

- (void)clearPlistWithcompletion:(void (^)(BOOL, NSError *))completion{
    
    BOOL isDir = NO;
    // temp路径
    NSString * docsdir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:@"requestRecod"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (isDir && existed) {
        //删除
        NSError *err;
        BOOL isSuccess = [fileManager removeItemAtPath:dataFilePath error:&err];
        if (isSuccess) {
            completion(isSuccess ,nil);
        }else{
            completion(isSuccess ,err);
        }
    }else{
        completion(false , nil);
    }
    
}

-(void)clearPlistAtIndex:(NSInteger)index Withcompletion:(void (^)(BOOL, NSError *))completion {
    
    NSString *plistPath = [self pathForPlist];
    
    NSMutableArray *arr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (arr && arr.count > index) {
        //进行删除操作
        [arr removeObjectAtIndex:index];
        BOOL isSuccess = [arr writeToFile:plistPath atomically:YES];
        completion(isSuccess , nil);
        
    }else{
        completion(false , nil);
    }

    
}

@end
