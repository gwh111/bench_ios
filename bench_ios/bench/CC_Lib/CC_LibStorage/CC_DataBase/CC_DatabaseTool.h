//
//  CC_DatabaseTool.h
//  DataStorageDemo
//
//  Created by relax on 2019/9/16.
//  Copyright © 2019 qq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_DatabaseTool : NSObject
/**
* 说明: modelClass property name&attributes
* @param modelClass 模型类
* @return NSDictionary {key:name,value:attributes}
*/
+ (NSDictionary *)parserModelObjectFieldsWithModelClass:(Class)modelClass;

/**
* 说明: 建表sql
* @param modelClass 模型类
* @param tableName 表名称
* @return NSString 建表sql @"CREATE TABLE IF NOT EXISTS tableName (_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT)"
*/
+ (NSString *)createTableSQL:(Class)modelClass
                   tableName:(NSString *)tableName;
/**
* 说明: 插入model sql
* @param modelObject 模型对象
* @param tableName 插入model表名称
* @return NSDictionary {key:insert_sql,value:value_array}
*/
+ (NSDictionary *)insertSQL:(id)modelObject
                  tableName:(NSString *)tableName;
/**
* 说明: 更新model sql
* @param modelObject 模型对象
* @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则更新所有)
* @param tableName 更新model表名称
* @return NSDictionary {key:update_sql,value:value_array}
*/
+ (NSDictionary *)updateSQL:(id)modelObject
                      where:(NSString *)where
                  tableName:(NSString *)tableName;
/**
* 说明: 更新model sql
* @param tableName 更新model表名称
* @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则更新所有)
* @param value 更新的值
* @return NSString 更新sql
*/
+ (NSString *)updateSQLWithTableName:(NSString *)tableName
                               value:(NSString *)value
                               where:(NSString *)where;
/**
* 说明: 删除model sql
* @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则删除所有)
* @param tableName 删除model表名称
* @return NSString 删除sql
*/
+ (NSString *)deleteSQL:(NSString *)tableName
                  where:(NSString *)where;
/**
* 说明: 查询model sql
* @param modelClass 模型类
* @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则删除所有)
* @param tableName 查询model表名称
* @return NSArray 查询的数据
*/
+ (NSArray *)querySQL:(Class)modelClass
                where:(NSString *)where
            tableName:(NSString *)tableName;

@end

NS_ASSUME_NONNULL_END
