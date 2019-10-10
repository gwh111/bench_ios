//
//  CC_Database.h
//  DataStorageDemo
//
//  Created by relax on 2019/9/9.
//  Copyright © 2019 qq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Database : NSObject

/** The path of the database file
 */
@property (nonatomic, readonly, nullable) NSString *databasePath;

/**
* 说明: 初始化 数据库存储path
* @param path path
* @return instancetype
*/
- (instancetype)initWithPath:(NSString *)path;
/**
* 说明: 打开数据库
* @return 打开结果
*/
- (BOOL)open;
/**
* 说明: 关闭数据库
* @return 关闭结果
*/
- (BOOL)close;
/**
* 说明: 插入 更新 删除
* @param sql sql
* @return 状态结果
*/
- (BOOL)executeUpdate:(NSString *)sql;
/**
* 说明: 插入 更新 删除
* @param sql sql
* @param args 参数
* @return 状态结果
*/
- (BOOL)executeUpdate:(NSString *)sql VAList:(va_list)args;
/**
* 说明: 插入 更新 删除
* @param sql sql
* @param argumentsArray 参数数组
* @return 状态结果
*/
- (BOOL)executeUpdate:(NSString *)sql
       argumentsArray:(NSArray *)argumentsArray;
/**
* 说明: 查询
* @param sql sql
* @param fieldDictionary 模型解析字典 {key:name,value:attributes}
* @param modelObject 模型对象
* @return NSArray 查询结果
*/
- (NSArray *)executeQuery:(NSString *)sql
          fieldDictionary:(NSDictionary *)fieldDictionary
              modelObject:(id)modelObject;

@end

NS_ASSUME_NONNULL_END
