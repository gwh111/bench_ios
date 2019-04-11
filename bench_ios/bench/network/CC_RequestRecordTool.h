//
//  BBRequestRecordTool.h
//  BananaBall
//
//  Created by 路飞  on 2018/6/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCReqRecord : NSObject

@property (nonatomic, strong) NSArray* parametersArr;

+(CCReqRecord*)getInstance;

/**
 插入请求数据

 @param service 请求的域名
 @param requestUrl 请求URL地址
 @param parameters 请求参数
 @param  dic 请求结果
 @return 是否记录成功
 */
-(BOOL)insertRequestDataWithHHSService:(NSString *)service requestUrl:(NSString *)requestUrl parameters:(NSString *)parameters resModelDic:(NSDictionary *)dic;

/**
 记录的plist文件地址

 @return 输出plist文件地址
 */
-(NSString *)pathForPlist;


/**
 输出所有请求参数

 @return 所有请求参数
 */
-(NSString *)totalParameters;

-(NSString *)totalRequestUrls;
-(NSString *)getTotalStr;

/**
 删除plist文件
 */
-(void)clearPlistWithcompletion:(void (^)(BOOL isSussecc ,NSError * error))completion;

/**
 删除具体某条记录
 */
-(void)clearPlistAtIndex:(NSInteger)index Withcompletion:(void (^)(BOOL isSussecc ,NSError * error))completion;


@end
