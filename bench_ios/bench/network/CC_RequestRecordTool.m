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
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (usersDic == nil) {
        usersDic = [[NSMutableDictionary alloc]init];
    }
    if (service) {
        [usersDic setObject:@{@"requestUrl":requestUrl, @"parameters":parameters, @"resultDic":dic} forKey:service];
    }else if(requestUrl){
        [usersDic setObject:@{@"requestUrl":requestUrl, @"parameters":parameters, @"resultDic":dic} forKey:requestUrl];
    }
//    [usersDic setObject:[NSString stringWithFormat:@"%@?%@", requestUrl, parameters] forKey:service];
    isSuccess = [usersDic writeToFile:plistPath atomically:YES];
    
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
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!usersDic) {
        return nil;
    }
    NSString * paraStr = @"";
    for (NSDictionary * dic in usersDic.allValues) {
        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@", dic[@"requestUrl"]]];
    }
    paraStr = [paraStr substringFromIndex:1];
    return paraStr;
}
-(NSString *)getTotalStr{
    NSString *plistPath = [self pathForPlist];
    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (!usersDic) {
        return nil;
    }
    NSString * paraStr = @"";
    for (NSDictionary * dic in usersDic.allValues) {
        NSString *urlS=dic[@"requestUrl"];
        if (![urlS hasSuffix:@"?"]) {
            urlS=[urlS stringByAppendingString:@"?"];
        }
        paraStr = [paraStr stringByAppendingString:[NSString stringWithFormat:@";%@%@",urlS,dic[@"parameters"]]];
    }
    paraStr = [paraStr substringFromIndex:1];
    return paraStr;
}
@end
