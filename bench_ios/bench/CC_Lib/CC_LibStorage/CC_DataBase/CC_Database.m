//
//  CC_Database.m
//  DataStorageDemo
//
//  Created by relax on 2019/9/9.
//  Copyright © 2019 qq. All rights reserved.
//

#import "CC_Database.h"
#import <objc/message.h>

#ifdef SQLITE_HAS_CODEC
#import "sqlite3.h"
#else
#import <sqlite3.h>
#endif

#define MAX_BUSYRETRY_TIMEINTERVAL 2

static const void * const kDispatchQueueSpecificKey = &kDispatchQueueSpecificKey;

@interface CC_Database ()
{
    void* _db;
}
@property (nonatomic, assign) NSTimeInterval startBusyRetryTime;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isExecutingStatement;

@end

@implementation CC_Database

/*
 SQLite支持三种线程模式，分别为单线程模式、多线程模式和串行模式
 sqlite3_threadsafe()的返回值可以确定编译时指定的线程模式，其中对于单线程模式，sqlite3_threadsafe()返回false，对于另外两个模式，则返回true。这是因为单线程模式下没有进行互斥，所以多线程下是不安全的
 */
- (instancetype)initWithPath:(NSString *)path {
    assert(sqlite3_threadsafe());
    self = [super init];
    if (self) {
        _databasePath               = [path copy];
        _db                         = nil;
        _isOpen                     = NO;
    }
    return self;
}

- (BOOL)open {
    if (_isOpen) {
        return YES;
    }

    // if we previously tried to open and it failed, make sure to close it before we try again
    if (_db) {
        [self close];
    }
    // now open database
    int err = sqlite3_open([self sqlitePath], (sqlite3**)&_db);
    if(err != SQLITE_OK) {
        NSLog(@"error opening!: %d", err);
        return NO;
    }
    if (_db) {
        // set the handler
        sqlite3_busy_handler(_db, &FMDBDatabaseBusyHandler, (__bridge void *)(self));
    }
    _isOpen = YES;
    return YES;
}

- (BOOL)close {
    if (!_db) return YES;
    
    int  rc;
    BOOL retry;
    BOOL triedFinalizingOpenStatements = NO;
    
    do {
        retry   = NO;
        rc      = sqlite3_close(_db);
        if (SQLITE_BUSY == rc || SQLITE_LOCKED == rc) {
            if (!triedFinalizingOpenStatements) {
                triedFinalizingOpenStatements = YES;
                sqlite3_stmt *pStmt;
                while ((pStmt = sqlite3_next_stmt(_db, nil)) !=0) {
                    NSLog(@"Closing leaked statement");
                    sqlite3_finalize(pStmt);
                    retry = YES;
                }
            }
        }
        else if (SQLITE_OK != rc) {
            NSLog(@"error closing!: %d", rc);
        }
    }
    while (retry);
    
    _db = nil;
    _isOpen = NO;
    
    return YES;
}

- (BOOL)executeUpdate:(NSString *)sql {
    
     return [self executeUpdate:sql argumentsInArray:nil VAList:nil];
}

- (BOOL)executeUpdate:(NSString *)sql VAList:(va_list)args {

    return [self executeUpdate:sql argumentsInArray:nil VAList:args];
}

- (BOOL)executeUpdate:(NSString *)sql argumentsArray:(NSArray *)argumentsArray {
    
    return [self executeUpdate:sql argumentsInArray:argumentsArray VAList:nil];
}

#pragma mark Execute updates

- (NSArray *)executeQuery:(NSString *)sql
          fieldDictionary:(NSDictionary *)fieldDictionary
              modelObject:(id)modelObject {
    NSMutableArray * modelObjectArray = [NSMutableArray array];
    if (!_isOpen) {
        NSLog(@"The Database %@ is not open.", self);
        return modelObjectArray;
    }
    
    if (_isExecutingStatement) {
        NSLog(@"The Database %@ is currently in use.", self);
        return modelObjectArray;
    }
    
    _isExecutingStatement = YES;
    
    int rc                   = 0x00;
    sqlite3_stmt *pStmt      = 0x00;
    if (!pStmt) {
        rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
        
        if (SQLITE_OK != rc) {
            NSLog(@"DB Error: %d \"%@\"", sqlite3_errcode(_db), [NSString stringWithUTF8String:sqlite3_errmsg(_db)]);
            NSLog(@"DB Query: %@", sql);
            NSLog(@"DB Path: %@", _databasePath);
            //释放所有的内部资源和sqlite3_stmt数据结构，有效删除prepared语句
            sqlite3_finalize(pStmt);
            _isExecutingStatement = NO;
            return modelObjectArray;
        }
    }
    
    int colum_count = sqlite3_column_count(pStmt);
    while (sqlite3_step(pStmt) == SQLITE_ROW) {
//        id currentModelObject = [modelObject copy];
        Class cla = [modelObject class];
        id currentModelObject = cla.new;
        
        for (int column = 1; column < colum_count; column++) {
            NSString *fieldName = [NSString stringWithCString:sqlite3_column_name(pStmt, column) encoding:NSUTF8StringEncoding];
            NSString *propertyType = fieldDictionary[fieldName];
            if (!propertyType) continue;
//            id currentModelObject = modelObject;
//            id newObject = [modelObject copy];
            // 子类 name
            if ([fieldName rangeOfString:@"$"].location != NSNotFound)
            {
                NSString *handleFieldName = [fieldName stringByReplacingOccurrencesOfString:@"$" withString:@"."];
                NSRange backwardsRange = [handleFieldName rangeOfString:@"." options:NSBackwardsSearch];
                NSString *subKeyPath = [handleFieldName substringWithRange:NSMakeRange(0, backwardsRange.location)];
                currentModelObject = [modelObject valueForKeyPath:subKeyPath];
                fieldName = [handleFieldName substringFromIndex:backwardsRange.length + backwardsRange.location];
                if (!currentModelObject) continue;
            }

            if ([propertyType isEqualToString:@"NSData"] ||
                [propertyType isEqualToString:@"NSArray"] ||
                [propertyType isEqualToString:@"NSMutableArray"] ||
                [propertyType isEqualToString:@"NSDictionary"] ||
                [propertyType isEqualToString:@"NSMutableDictionary"])
            {
                int length = sqlite3_column_bytes(pStmt, column);
                const void * blob = sqlite3_column_blob(pStmt, column);
                if (blob != nil) {
                    NSData *value = [NSData dataWithBytes:blob length:length];
                    if ([propertyType isEqualToString:@"NSData"])
                    {
                        [currentModelObject setValue:value forKey:fieldName];
                        continue;
                    }
                    @try {
                        id set_value = [NSKeyedUnarchiver unarchiveObjectWithData:value];
                        if (set_value) {
                            if ([propertyType isEqualToString:@"NSMutableArray"] && [set_value isKindOfClass:[NSArray class]])
                            {
                                set_value = [NSMutableArray arrayWithArray:set_value];
                            }
                            else if ([propertyType isEqualToString:@"NSMutableDictionary"] && [set_value isKindOfClass:[NSDictionary class]])
                            {
                                set_value = [NSMutableDictionary dictionaryWithDictionary:set_value];
                            }
                            
                            [currentModelObject setValue:set_value forKey:fieldName];
                        }
                        
                    } @catch (NSException *exception) {
                        NSLog(@"query 查询异常 Array/Dictionary 元素没实现NSCoding协议解归档失败");
                    }
                }
            }
            else if ([propertyType isEqualToString:@"NSDate"])
            {
                double value = sqlite3_column_double(pStmt, column);
                if (value > 0) {
                    NSDate *date_value = [NSDate dateWithTimeIntervalSince1970:value];
                    if (date_value) {
                        [currentModelObject setValue:date_value forKey:fieldName];
                    }
                }
            }
            else if ([propertyType isEqualToString:@"NSString"])
            {
                const unsigned char * text = sqlite3_column_text(pStmt, column);
                if (text != nil) {
                    NSString *value = [NSString stringWithCString:(const char *)text encoding:NSUTF8StringEncoding];
                    [currentModelObject setValue:value forKey:fieldName];
                }
            }
            else if ([propertyType isEqualToString:@"NSNumber"] ||
                     [propertyType isEqualToString:@"float"] ||
                     [propertyType isEqualToString:@"double"])
            {
                double value = sqlite3_column_double(pStmt, column);
                [currentModelObject setValue:@(value) forKey:fieldName];
            }
            else if ([propertyType isEqualToString:@"int"])
            {
                sqlite3_int64 value = sqlite3_column_int64(pStmt, column);
                [currentModelObject setValue:@(value) forKey:fieldName];
            }
            else if ([propertyType isEqualToString:@"BOOL"] || [propertyType isEqualToString:@"Char"])
            {
                int value = sqlite3_column_int(pStmt, column);
                [currentModelObject setValue:@(value) forKey:fieldName];
            }
        }
//        [modelObjectArray addObject:modelObject];
        [modelObjectArray addObject:currentModelObject];
    }
    
    sqlite3_finalize(pStmt);
    _isExecutingStatement = NO;
    return modelObjectArray;
}

- (BOOL)executeUpdate:(NSString *)sql argumentsInArray:(NSArray *)arrayArgs VAList:(va_list)args {
    
    if (!_isOpen) {
        NSLog(@"The FMDatabase %@ is not open.", self);
        return NO;
    }
    
    if (_isExecutingStatement) {
        NSLog(@"The FMDatabase %@ is currently in use.", self);
        return NO;
    }
    
    _isExecutingStatement = YES;
    
    int rc                   = 0x00;
    sqlite3_stmt *pStmt      = 0x00;

    if (!pStmt) {
        rc = sqlite3_prepare_v2(_db, [sql UTF8String], -1, &pStmt, 0);
        
        if (SQLITE_OK != rc) {
            NSLog(@"DB Error: %d \"%@\"", sqlite3_errcode(_db), [NSString stringWithUTF8String:sqlite3_errmsg(_db)]);
            NSLog(@"DB Query: %@", sql);
            NSLog(@"DB Path: %@", _databasePath);
            //释放所有的内部资源和sqlite3_stmt数据结构，有效删除prepared语句
            sqlite3_finalize(pStmt);
            _isExecutingStatement = NO;
            return NO;
        }
    }
    
    id obj;
    int idx = 0;
    int queryCount = sqlite3_bind_parameter_count(pStmt);
    
    while (idx < queryCount) {
        
        if (arrayArgs && idx < (int)[arrayArgs count])
            {
                obj = [arrayArgs objectAtIndex:(NSUInteger)idx];}
        else if (args) {
            obj = va_arg(args, id);
        }
        idx++;
        [self bindObject:obj toColumn:idx inStatement:pStmt];
    }

    if (idx != queryCount) {
        
        NSLog(@"Error: the bind count (%d) is not correct for the # of variables in the query (%d) (%@) (executeUpdate)", idx, queryCount, sql);
        
        sqlite3_finalize(pStmt);
        _isExecutingStatement = NO;
        return NO;
    }
    
    /* Call sqlite3_step() to run the virtual machine. Since the SQL being
     ** executed is not a SELECT statement, we assume no data will be returned.
     */
    
    rc = sqlite3_step(pStmt);
    
    if (SQLITE_DONE != rc) {
       NSLog(@"DB Error: %d \"%@\"", sqlite3_errcode(_db), [NSString stringWithUTF8String:sqlite3_errmsg(_db)]);
    }
    
    int closeErrorCode = sqlite3_finalize(pStmt);
    
    if (closeErrorCode != SQLITE_OK) {
        NSLog(@"Unknown error finalizing or resetting statement (%d: %s)", closeErrorCode, sqlite3_errmsg(_db));
        NSLog(@"DB Query: %@", sql);
    }
    
    _isExecutingStatement = NO;
    return (rc == SQLITE_DONE || rc == SQLITE_OK);
}

static int FMDBDatabaseBusyHandler(void *f, int count) {
    CC_Database *self = (__bridge CC_Database*)f;
    
    if (count == 0) {
        self->_startBusyRetryTime = [NSDate timeIntervalSinceReferenceDate];
        return 1;
    }
    
    NSTimeInterval delta = [NSDate timeIntervalSinceReferenceDate] - (self->_startBusyRetryTime);
    
    if (delta < MAX_BUSYRETRY_TIMEINTERVAL) {
        int requestedSleepInMillseconds = (int) arc4random_uniform(50) + 50;
        int actualSleepInMilliseconds = sqlite3_sleep(requestedSleepInMillseconds);
        if (actualSleepInMilliseconds != requestedSleepInMillseconds) {
            NSLog(@"WARNING: Requested sleep of %i milliseconds, but SQLite returned %i. Maybe SQLite wasn't built with HAVE_USLEEP=1?", requestedSleepInMillseconds, actualSleepInMilliseconds);
        }
        return 1;
    }
    return 0;
}

- (const char*)sqlitePath {
    if (!_databasePath) {
        return ":memory:";
    }
    if ([_databasePath length] == 0) {
        return ""; // this creates a temporary database (it's an sqlite thing).
    }
    return [_databasePath fileSystemRepresentation];
}


#pragma mark SQL manipulation

- (void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt*)pStmt {

    if ((!obj) || ((NSNull *)obj == [NSNull null])) {
        sqlite3_bind_null(pStmt, idx);
    }
    
    // FIXME - someday check the return codes on these binds.
    else if ([obj isKindOfClass:[NSData class]]) {
        const void *bytes = [obj bytes];
        if (!bytes) {
            // it's an empty NSData object, aka [NSData data].
            // Don't pass a NULL pointer, or sqlite will bind a SQL null instead of a blob.
            bytes = "";
        }
        sqlite3_bind_blob(pStmt, idx, bytes, (int)[obj length], SQLITE_STATIC);
    }
    else if ([obj isKindOfClass:[NSMutableDictionary class]] ||
             [obj isKindOfClass:[NSDictionary class]] ||
             [obj isKindOfClass:[NSMutableArray class]] ||
             [obj isKindOfClass:[NSArray class]]) {
        @try {
            if ([obj isKindOfClass:[NSArray class]] ||
                [obj isKindOfClass:[NSDictionary class]]) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
                sqlite3_bind_blob(pStmt, idx, [data bytes], (int)[data length], SQLITE_STATIC);
            }else {
                sqlite3_bind_blob(pStmt, idx, [obj bytes], (int)[obj length], SQLITE_STATIC);
            }
        } @catch (NSException *exception) {
            NSLog(@"insert 异常 Array/Dictionary类型元素未实现NSCoding协议归档失败");
        }
    }
    else if ([obj isKindOfClass:[NSDate class]]) {
        sqlite3_bind_double(pStmt, idx, [obj timeIntervalSince1970]);
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        
        if (strcmp([obj objCType], @encode(char)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj charValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned char)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj unsignedCharValue]);
        }
        else if (strcmp([obj objCType], @encode(short)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj shortValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned short)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj unsignedShortValue]);
        }
        else if (strcmp([obj objCType], @encode(int)) == 0) {
            sqlite3_bind_int(pStmt, idx, [obj intValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned int)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedIntValue]);
        }
        else if (strcmp([obj objCType], @encode(long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedLongValue]);
        }
        else if (strcmp([obj objCType], @encode(long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, [obj longLongValue]);
        }
        else if (strcmp([obj objCType], @encode(unsigned long long)) == 0) {
            sqlite3_bind_int64(pStmt, idx, (long long)[obj unsignedLongLongValue]);
        }
        else if (strcmp([obj objCType], @encode(float)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj floatValue]);
        }
        else if (strcmp([obj objCType], @encode(double)) == 0) {
            sqlite3_bind_double(pStmt, idx, [obj doubleValue]);
        }
        else if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            sqlite3_bind_int(pStmt, idx, ([obj boolValue] ? 1 : 0));
        }
        else {
            sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
        }
    }
    else {
        sqlite3_bind_text(pStmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
    }
}

@end
