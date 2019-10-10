//
//  CC_DataBaseStore.h
//  DataStorageDemo
//
//  Created by relax on 2019/9/11.
//  Copyright © 2019 qq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_DataBaseStore : NSObject

@property (nonatomic, readonly, nullable) NSString *databasePath;

+ (instancetype)shared;
/**
 * 说明: 自定义SQL进行增 改 删 查
 * @param sql sql
 * @return 是否成功
 */
- (BOOL)executeCustomUpdate:(NSString *)sql, ...;
/**
 * 说明: 存储模型到本地 表名称为模型名称
 * @param modelObject 模型对象
 * @return 是否成功
 */
- (BOOL)insert:(id)modelObject;
/**
 * 说明: 自定义表名称 & 存储模型到本地
 * @param modelObject 模型对象
 * @param tableName 自定义表名称
 * @return 是否成功
 */
- (BOOL)insert:(id)modelObject
     tableName:(NSString *)tableName;
/**
 * 说明: 存储模型数组到本地(事务方式) 表名称为模型名称
 * @param modelArray 模型数组对象(modelArray 里对象类型要一致)
 * @return 是否成功
 */
- (BOOL)inserts:(NSArray *)modelArray;
/**
 * 说明: 自定义表名称 & 存储模型数组到本地(事务方式)
 * @param modelArray 模型数组对象(modelArray 里对象类型要一致)
 * @param tableName 自定义表名称
 * @return 是否成功
 */
- (BOOL)inserts:(NSArray *)modelArray
      tableName:(nullable NSString *)tableName;
/**
 * 说明: 查询本地模型对象
 * @param modelClass 模型类
 * @return 查询模型对象数组
 */
- (NSArray *)query:(Class)modelClass;
/**
 * 说明: 根据表名称 查询本地模型对象
 * @param modelClass 模型类
 * @param tableName 自定义表名称
 * @return 查询模型对象数组
 */
- (NSArray *)query:(Class)modelClass
         tableName:(NSString *)tableName;
/**
 * 说明: 根据查询条件 查询本地模型对象
 * @param modelClass 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @return 查询模型对象数组
 */
- (NSArray *)query:(Class)modelClass
             where:(NSString *)where;
/**
 * 说明: 根据查询条件&表名称 查询本地模型对象
 * @param modelClass 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @param tableName 自定义表名称
 * @return 查询模型对象数组
 */
- (NSArray *)query:(Class)modelClass
             where:(nullable NSString *)where
         tableName:(nullable NSString *)tableName;
/**
 * 说明: 根据条件 更新本地模型对象
 * @param modelObject 模型对象
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则更新所有)
 * @return 是否成功
 */
- (BOOL)update:(id)modelObject
         where:(NSString *)where;
/**
 * 说明: 根据条件 & 表名称 更新本地模型对象
 * @param modelObject 模型对象
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则更新所有)
 * @param tableName 自定义表名称
 * @return 是否成功
 */
- (BOOL)update:(id)modelObject
         where:(NSString *)where
     tableName:(nullable NSString *)tableName;
/**
 * 说明: 更新数据表字段
 * @param modelClass 模型类
 * @param value 更新的值
 * @param where 更新条件
 * @return 是否成功
 */
- (BOOL)update:(Class)modelClass
         value:(NSString *)value
         where:(NSString *)where;
/**
 * 说明: 更新数据表字段
 * @param tableName 自定义表名称
 * @param value 更新的值
 * @param where 更新条件
 * @return 是否成功
 */
- (BOOL)updateWithTableName:(NSString *)tableName
                      value:(NSString *)value
                      where:(NSString *)where;
/**
 * 说明: 清空本地模型对象
 * @param tableName 清空本地模型对象表名称
 * @return 是否成功
 */
- (BOOL)clear:(NSString *)tableName;
/**
 * 说明: 删除本地模型对象
 * @param tableName 删除对象表名称
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则删除所有)
 * @return 是否成功
 */
- (BOOL)delete:(NSString *)tableName
         where:(nullable NSString *)where;
/**
 * 说明: 清空所有本地模型数据库
 */
- (void)removeDBFile;

@end

NS_ASSUME_NONNULL_END
