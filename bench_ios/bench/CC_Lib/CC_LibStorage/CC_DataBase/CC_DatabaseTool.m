//
//  CC_DatabaseTool.m
//  DataStorageDemo
//
//  Created by relax on 2019/9/16.
//  Copyright © 2019 qq. All rights reserved.
//

#import "CC_DatabaseTool.h"
#import <objc/runtime.h>

@implementation CC_DatabaseTool

+ (NSDictionary *)parserModelObjectFieldsWithModelClass:(Class)modelClass {
    return [self parserSubModelObjectFieldsWithModelClass:modelClass
                                         mainPropertyName:nil
                                                 complete:nil];
}

+ (NSDictionary *)parserSubModelObjectFieldsWithModelClass:(Class)modelClass
                                          mainPropertyName:(NSString *)mainPropertyName
                                                  complete:(void(^)(NSString *key, NSString *propertyClass))complete {
    BOOL needDictionaryDave = !mainPropertyName && !complete;
    NSMutableDictionary *fieldsDic = needDictionaryDave ? [NSMutableDictionary dictionary] : nil;
    Class superClass = class_getSuperclass(modelClass);
    
    if (superClass != nil && superClass != [NSObject class] && superClass != NSClassFromString(@"CC_Model"))
    {
        NSDictionary *superFieldsDic = [self parserSubModelObjectFieldsWithModelClass:superClass
                                                                     mainPropertyName:mainPropertyName
                                                                             complete:complete];
        if (needDictionaryDave) [fieldsDic setValuesForKeysWithDictionary:superFieldsDic];
    }
    
    unsigned int propertyCount = 0;
    objc_property_t * propertys = class_copyPropertyList(modelClass, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t property = propertys[i];
        
        NSString *propertyNameString = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyAttributesString = [NSString stringWithUTF8String:property_getAttributes(property)];
        
        NSArray *propertyAttributesList = [propertyAttributesString componentsSeparatedByString:@"\""];
      
        if (!needDictionaryDave)
        {
            propertyNameString = [NSString stringWithFormat:@"%@$%@",mainPropertyName,propertyNameString];
        }
        NSString *propertyType = nil;
        if (propertyAttributesList.count == 1) {
            // base type
            propertyType = [self parserFieldTypeWithAttr:propertyAttributesList[0]];
            NSLog(@"propertyType = %@ name = %@",propertyType,propertyNameString);
        }
        else {
            // refernece type
            Class class_type = NSClassFromString(propertyAttributesList[1]);
            if (class_type == [NSNumber class] ||
                class_type == [NSString class] ||
                class_type == [NSData class] ||
                class_type == [NSArray class] ||
                class_type == [NSDictionary class] ||
                class_type == [NSDate class] ||
                class_type == [NSMutableArray class] ||
                class_type == [NSMutableDictionary class]){
                propertyType = NSStringFromClass(class_type);
            }
            else if (class_type == [NSSet class] ||
                class_type == [NSValue class] ||
                class_type == [NSError class] ||
                class_type == [NSURL class] ||
                class_type == [NSStream class] ||
                class_type == [NSScanner class] ||
                class_type == [NSException class] ||
                class_type == [NSBundle class])
            {
                NSLog(@"检查模型类异常数据类型");
            }
            else
            {
                if (needDictionaryDave)
                {
                    [self parserSubModelObjectFieldsWithModelClass:class_type mainPropertyName:propertyNameString complete:^(NSString * key, NSString *propertyClass) {
                        [fieldsDic setObject:propertyClass forKey:key];
                        NSLog(@"propertyClass = %@ key = %@",propertyClass,key);
                    }];
                }
                else
                {
                    [self parserSubModelObjectFieldsWithModelClass:class_type mainPropertyName:propertyNameString complete:complete];
                }
            }
        }
        if (needDictionaryDave && propertyType)
        {
            [fieldsDic setObject:propertyType forKey:propertyNameString];
            NSLog(@"propertyType = %@ name = %@",propertyType,propertyNameString);
        }
        if (propertyType && complete)
        {
            complete(propertyNameString,propertyType);
        }
    }
    free(propertys);
    return fieldsDic;
}

+ (NSString *)createTableSQL:(Class)modelClass
                   tableName:(NSString *)tableName {
    
    NSString *table_name = NSStringFromClass(modelClass);
    if (tableName && tableName.length) table_name = tableName;
    NSDictionary *fieldDictionary = [CC_DatabaseTool parserModelObjectFieldsWithModelClass:modelClass];
    if (fieldDictionary.count > 0) {
        __block NSString *create_table_sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,",table_name,@"_id"];
        [fieldDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *field, NSString *propertyType, BOOL * _Nonnull stop) {
            create_table_sql = [create_table_sql stringByAppendingFormat:@"%@ %@",field, [CC_DatabaseTool databaseFieldTypeWithType:propertyType]];
        }];
        create_table_sql = [create_table_sql substringWithRange:NSMakeRange(0, create_table_sql.length - 1)];
        create_table_sql = [create_table_sql stringByAppendingString:@")"];
        return create_table_sql;
    }
    return @"";
}

+ (NSDictionary *)insertSQL:(id)modelObject
                  tableName:(NSString *)tableName {
    
    NSString *table_name = NSStringFromClass([modelObject class]);
    if (tableName && tableName.length) table_name = tableName;
    
    NSDictionary *fieldDictionary = [CC_DatabaseTool parserModelObjectFieldsWithModelClass:[modelObject class]];
    __block NSString * insert_sql = [NSString stringWithFormat:@"INSERT INTO %@ (",table_name];
    NSArray *fieldArray = fieldDictionary.allKeys;
    
    NSMutableArray *value_array = [NSMutableArray array];
    [fieldArray enumerateObjectsUsingBlock:^(NSString * field, NSUInteger idx, BOOL * _Nonnull stop) {
        insert_sql = [insert_sql stringByAppendingFormat:@"%@,",field];
        id value = nil;
        if ([field rangeOfString:@"$"].location == NSNotFound)
        {
            value = [modelObject valueForKey:field];
        }
        else
        {
            value = [modelObject valueForKeyPath:[field stringByReplacingOccurrencesOfString:@"$" withString:@"."]];
        }
        [value_array addObject:value ? : [NSNull null]];
    }];
    
    insert_sql = [insert_sql substringWithRange:NSMakeRange(0, insert_sql.length - 1)];
    insert_sql = [insert_sql stringByAppendingString:@") VALUES ("];
    
    [fieldArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        insert_sql = [insert_sql stringByAppendingString:@"?,"];
    }];
    insert_sql = [insert_sql substringWithRange:NSMakeRange(0, insert_sql.length - 1)];
    insert_sql = [insert_sql stringByAppendingString:@")"];
    
    return @{insert_sql:value_array};
}

+ (NSDictionary *)updateSQL:(id)modelObject
                      where:(NSString *)where
                  tableName:(NSString *)tableName {

    NSString *table_name = NSStringFromClass([modelObject class]);
    if (tableName && tableName.length) table_name = tableName;
    
    NSDictionary *fieldDictionary = [CC_DatabaseTool parserModelObjectFieldsWithModelClass:[modelObject class]];
    __block NSString *update_sql = [NSString stringWithFormat:@"UPDATE %@ SET ",table_name];
    NSArray *fieldArray = fieldDictionary.allKeys;
    
    NSMutableArray *value_array = [NSMutableArray array];
    [fieldArray enumerateObjectsUsingBlock:^(id  _Nonnull field, NSUInteger idx, BOOL * _Nonnull stop) {
        update_sql = [update_sql stringByAppendingFormat:@"%@ = ?,",field];
        id value = nil;
        if ([field rangeOfString:@"$"].location == NSNotFound)
        {
            value = [modelObject valueForKey:field];
        }
        else
        {
            value = [modelObject valueForKeyPath:[field stringByReplacingOccurrencesOfString:@"$" withString:@"."]];
        }
        [value_array addObject:value ? : [NSNull null]];
    }];
    update_sql = [update_sql substringWithRange:NSMakeRange(0, update_sql.length - 1)];
    if (where != nil && where.length > 0) {
        update_sql = [update_sql stringByAppendingFormat:@" WHERE %@", [CC_DatabaseTool handleWhere:where]];
    }
    return @{update_sql:value_array};
}

+ (NSString *)updateSQLWithTableName:(NSString *)tableName
                               value:(NSString *)value
                               where:(NSString *)where {
    
    NSString *update_sql = [NSString stringWithFormat:@"UPDATE %@ SET %@",tableName,value];
    if (where != nil && where.length) {
        update_sql = [update_sql stringByAppendingFormat:@" WHERE %@", [self handleWhere:where]];
    }
    return update_sql;
}

+ (NSString *)deleteSQL:(NSString *)tableName
                  where:(NSString *)where {
    
    NSString *delete_sql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    if (where != nil && where.length > 0) {
        delete_sql = [delete_sql stringByAppendingFormat:@" WHERE %@",[self handleWhere:where]];
    }
    return delete_sql;
}

+ (NSArray *)querySQL:(Class)modelClass
                where:(NSString *)where
            tableName:(NSString *)tableName {
    
    NSString *table_name = NSStringFromClass(modelClass);
    if (tableName && tableName.length) table_name = tableName;
    NSDictionary *fieldDictionary = [CC_DatabaseTool parserModelObjectFieldsWithModelClass:modelClass];
    
    NSString *select_sql = [NSString stringWithFormat:@"SELECT * FROM %@",table_name];
    if (where != nil && where.length > 0) {
        select_sql = [select_sql stringByAppendingFormat:@" WHERE %@",[self handleWhere:where]];
    }
    id modelObject = [CC_DatabaseTool autoNewSubmodelWithClass:modelClass];
    
    return @[select_sql,fieldDictionary,modelObject];
}

+ (NSString *)handleWhere:(NSString *)where {
    NSString *whereString = @"";
    if (!where && !where.length) return whereString;
    
    NSArray *whereList = [where componentsSeparatedByString:@" "];
    NSMutableString * handle_where = [NSMutableString string];
    
    [whereList enumerateObjectsUsingBlock:^(NSString * sub_where, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange dot_range = [sub_where rangeOfString:@"."];
        if (dot_range.location != NSNotFound && ![sub_where hasPrefix:@"'"] && ![sub_where hasSuffix:@"'"]) {
            __block BOOL has_number = NO;
            NSArray * dot_sub_list = [sub_where componentsSeparatedByString:@"."];
            [dot_sub_list enumerateObjectsUsingBlock:^(NSString * dot_string, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString * before_char = nil;
                if (dot_string.length) {
                    before_char = [dot_string substringToIndex:1];
                    int value;
                    NSScanner *scan = [NSScanner scannerWithString:before_char];
                    if ([scan scanInt:&value] && [scan isAtEnd]) {
                        has_number = YES;
                        *stop = YES;
                    }
                }
            }];
            [handle_where appendFormat:@"%@ ",has_number ? sub_where : [sub_where stringByReplacingOccurrencesOfString:@"." withString:@"$"]];
        }
        else {
            [handle_where appendFormat:@"%@ ",sub_where];
        }
    }];
    if ([handle_where hasSuffix:@" "]) {
        [handle_where deleteCharactersInRange:NSMakeRange(handle_where.length - 1, 1)];
    }
    return handle_where;
}

#pragma private
+ (id)autoNewSubmodelWithClass:(Class)modelClass {
    if (modelClass) {
        id model = modelClass.new;
        unsigned int propertyCount = 0;
        objc_property_t * propertys = class_copyPropertyList(modelClass, &propertyCount);
        for (int i = 0; i < propertyCount; i++) {
            objc_property_t property = propertys[i];
       
            NSString *propertyAttributesString = [NSString stringWithUTF8String:property_getAttributes(property)];
            NSArray *propertyattributesList = [propertyAttributesString componentsSeparatedByString:@"\""];
            
            if (propertyattributesList.count > 1) {
                // refernece type
                Class class_type = NSClassFromString(propertyattributesList[1]);
                if ([self isSubModelWithClass:class_type]) {
                    NSString *propertyNameString = [NSString stringWithUTF8String:property_getName(property)];
                    [model setValue:[self autoNewSubmodelWithClass:class_type] forKey:propertyNameString];
                }
            }
        }
        free(propertys);
        return model;
    }
    return nil;
}

+ (BOOL)isSubModelWithClass:(Class)modelClass {
    return (modelClass != [NSString class] &&
            modelClass != [NSNumber class] &&
            modelClass != [NSArray class] &&
            modelClass != [NSSet class] &&
            modelClass != [NSData class] &&
            modelClass != [NSDate class] &&
            modelClass != [NSDictionary class] &&
            modelClass != [NSValue class] &&
            modelClass != [NSError class] &&
            modelClass != [NSURL class] &&
            modelClass != [NSStream class] &&
            modelClass != [NSURLRequest class] &&
            modelClass != [NSURLResponse class] &&
            modelClass != [NSBundle class] &&
            modelClass != [NSScanner class] &&
            modelClass != [NSException class]);
}

+ (NSString *)parserFieldTypeWithAttr:(NSString *)attr {
    NSArray * sub_attrs = [attr componentsSeparatedByString:@","];
    NSString * first_sub_attr = sub_attrs.firstObject;
    first_sub_attr = [first_sub_attr substringFromIndex:1];
    NSString *class_type = @"NSString";
    const char type = *[first_sub_attr UTF8String];
    switch (type) {
        case 'B':
            class_type = @"BOOL";
            break;
        case 'c':
        case 'C':
            class_type = @"Char";
            break;
        case 's':
        case 'S':
        case 'q':
        case 'Q':
        case 'i':
        case 'I':
        case 'l':
        case 'L':
            class_type = @"int";
            break;
        case 'f':
            class_type = @"float";
            break;
        case 'd':
        case 'D':
            class_type = @"double";
            break;
        default:
            break;
    }
    return class_type;
}

+ (const NSString *)databaseFieldTypeWithType:(NSString *)type {
    
    if ([type isEqualToString:@"NSString"])
    {
        return @"TEXT DEFAULT NULL,";
    }
    if ([type isEqualToString:@"Char"])
    {
        return @"NVARCHAR DEFAULT NULL,";
    }
    if ([type isEqualToString:@"int"] ||
        [type isEqualToString:@"BOOL"])
    {
        return @"INTERGER DEFAULT 0,";
    }
    if ([type isEqualToString:@"float"] ||
        [type isEqualToString:@"double"] ||
        [type isEqualToString:@"NSDate"] ||
        [type isEqualToString:@"NSNumber"])
    {
        return @"DOUBLE DEFAULT 0.0,";
    }
    if ([type isEqualToString:@"NSData"] ||
        [type isEqualToString:@"NSArray"] ||
        [type isEqualToString:@"NSMutableArray"] ||
        [type isEqualToString:@"NSDictionary"] ||
        [type isEqualToString:@"NSMutableDictionary"])
    {
        return @"BLOB DEFAULT NULL,";
    }
    return @"TEXT DEFAULT NULL,";
}

@end
