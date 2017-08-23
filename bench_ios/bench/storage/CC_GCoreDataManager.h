//
//  GCoreData.h
//  CoreDataLearning
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CC_GCoreDataManager : NSObject

/** 
 * 创建一个模型
 * modelName 模型名字
 */
+ (NSManagedObjectContext*)creatPersistentStoreWithModel:(NSString *)modelName toPath:(NSString *)dbPath;

/** insert和save结合使用

 例子：
 Event *new=(Event *)[GCoreData insertEntityWith:@"Event" inManagedObjectContext:context];
 new.title=titleTextField.text;
 new.body=contentTextField.text;
 
 //存储需要预处理时间
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 [dateFormatter setLocale:[NSLocale currentLocale]];
 NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
 [dateFormatter setTimeZone:GTMzone];
 
 NSDate *beginDate = [dateFormatter dateFromString:@"2017-02-07 10:19:05"];
 new.creationDate=beginDate;
 [GCoreData saveContextWithManagedObjectContext:context];
 
 */
+ (NSManagedObject *)insertEntityWith:(NSString *)EntityName inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)saveContextWithManagedObjectContext:(NSManagedObjectContext *)context;

/** 数据获取
 fetchLimit=0
 fetchOffset=0时不筛选
 
 NSPredicate
 http://blog.csdn.net/primer_programer/article/details/10035057
 例子：
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
 NSDate *beginDate = [dateFormatter dateFromString:@"2017-02-07 10:19:05"];
 NSPredicate *predicate_date =[NSPredicate predicateWithFormat:@"creationDate = %@", beginDate];
 
 NSArray *arr=[GCoreData queryObjectWithPredicate:predicate_date from:@"Event" withManagedObjectContext:context withFetchLimit:10 withFetchOffset:0];
 for (Event *entry in arr) {
 NSLog(@"OldTitle:%@---Content:%@---Date:%@ new2:%@",entry.title,entry.body,entry.creationDate,entry.new2);
 }
 
 */
+ (NSArray *)queryObjectWithPredicate:(NSPredicate *)predicate from:(NSString *)entityName withManagedObjectContext:(NSManagedObjectContext *)context withFetchLimit:(NSInteger)fetchLimit withFetchOffset:(NSInteger)fetchOffset;

/** 数据删除*/
+ (void)deleteObjectWithPredicate:(NSPredicate *)predicate from:(NSString *)entityName withManagedObjectContext:(NSManagedObjectContext *)context withFetchLimit:(NSInteger)fetchLimit withFetchOffset:(NSInteger)fetchOffset;

@end
