//
//  GCoreData.m
//  CoreDataLearning
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 apple . All rights reserved.
//

#import "CC_GCoreDataManager.h"

@implementation CC_GCoreDataManager

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSManagedObjectContext *)creatPersistentStoreWithModel:(NSString *)modelName toPath:(NSString *)dbPath{
    
    if (!dbPath) {
        dbPath=[NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.sqlite",modelName]];
    }
    
    //读取数据库的模型文件
    //加载数据库模型文件的地址,数据库模型文件的后缀为 momd
    NSURL *url=[[NSBundle mainBundle]URLForResource:modelName withExtension:@"momd"];
    
    NSManagedObjectModel *dataModel=[[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    
    //创建持久化数据文件
    //将数据模型文件绑定给数据持久化协调器
    NSPersistentStoreCoordinator *coordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:dataModel];
    
    //指定持久化文件的地址
    //注意:需要把字符串转化为地址的 url
    NSURL *pathURL=[NSURL fileURLWithPath:dbPath];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:pathURL options:nil error:nil];
    
    //制作数据操作的上下文
    NSManagedObjectContext *context =[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    //将数据持久化协调器绑定给上下文,却似那个上下文操作的数据持久化文件
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}

+ (NSManagedObject *)insertEntityWith:(NSString *)EntityName inManagedObjectContext:(NSManagedObjectContext *)context{
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:EntityName inManagedObjectContext:context];
    
    return object;
}

+ (void)saveContextWithManagedObjectContext:(NSManagedObjectContext *)context{
    
    //数据存储
    NSError *error;
    BOOL isSuc=[context save:&error];
    if (!isSuc) {
        NSLog(@"Error:%@,%@",error,[error userInfo]);
    }else{
        NSLog(@"Success");
    }
    
    NSAssert(isSuc, @"数据存储失败");
}

+ (NSArray *)queryObjectWithPredicate:(NSPredicate *)predicate from:(NSString *)entityName withManagedObjectContext:(NSManagedObjectContext *)context withFetchLimit:(NSInteger)fetchLimit withFetchOffset:(NSInteger)fetchOffset{
    
    //创建查询请求 需要绑定查询的子类名称
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:entityName];
    
    //设置查询的实体
    request.entity=[NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    //设置查询条件
    request.predicate=predicate;
    NSArray *arr=[context executeFetchRequest:request error:nil];
    
    //设置分页查询
    if (fetchLimit>0||fetchOffset>0) {
        request.fetchLimit=fetchLimit;
        request.fetchOffset=fetchOffset;
        return arr;
    }
    
    return arr;
    
}

+ (void)deleteObjectWithPredicate:(NSPredicate *)perdicate from:(NSString *)entityName withManagedObjectContext:(NSManagedObjectContext *)context withFetchLimit:(NSInteger)fetchLimit withFetchOffset:(NSInteger)fetchOffset{
    
    NSArray *arr=[self queryObjectWithPredicate:perdicate from:entityName withManagedObjectContext:context withFetchLimit:fetchLimit withFetchOffset:fetchOffset];
    for (NSManagedObject *obj in arr) {
        [context deleteObject:obj];
    }
    [self saveContextWithManagedObjectContext:context];
}

@end
