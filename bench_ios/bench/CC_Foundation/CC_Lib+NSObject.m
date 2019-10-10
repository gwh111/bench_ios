//
//  NSObject+CCExtention.m
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import "CC_Lib+NSObject.h"
#import <objc/runtime.h>

@implementation NSObject(CC_Lib)

#pragma mark kv help
- (id)cc_setClassKVDic:(NSDictionary *)dic{
    NSArray *names = [self cc_getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name = names[i];
        id value = [dic valueForKey:name];
        if (!value) {
            continue;
        }
        [self setValue:value forKey:name];
    }
    return self;
}

- (NSDictionary *)cc_getClassKVDic{
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSArray *names = [self cc_getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name = names[i];
        id value=[self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    return mutDic;
}

- (NSDictionary *)cc_getClassKVDic_{
    NSMutableDictionary *mutDic = [[NSMutableDictionary alloc]init];
    NSArray *names = [self cc_getClassNameList];
    for (int i=0; i<names.count; i++) {
        NSString *name = names[i];
        if (name.length>1) {
            name = [name substringFromIndex:1];
        }
        id value = [self valueForKey:name];
        if (!value) {
            continue;
        }
        [mutDic setObject:[self valueForKey:name] forKey:name];
    }
    return mutDic;
}

- (NSArray *)cc_getClassNameList{
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        [mutArr addObject:name];
    }
    free(ivars);
    return mutArr;
}

- (NSArray *)cc_getClassTypeList{
    NSMutableArray *mutArr = [[NSMutableArray alloc]init];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        // 取出成员变量类型
        Ivar ivar = *(ivars + i);
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getTypeEncoding(ivar)];
        name = [name stringByReplacingOccurrencesOfString:@"@" withString:@""];
        name = [name stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        [mutArr addObject:name];
    }
    free(ivars);
    return mutArr;
}

- (void)cc_encode:(NSCoder *)encoder
{
    Class superClass = class_getSuperclass(self.class);
    if (superClass != nil && superClass != [NSObject class] && superClass != NSClassFromString(@"CC_Model")) {
        NSObject * superObject = superClass.new;
        [superClass cc_enumeratePropertyNameUsingBlock:^(NSString *propertyName, NSUInteger index, BOOL *stop) {
            [superObject setValue:[self valueForKey:propertyName] forKey:propertyName];
        }];
        [superObject cc_encode:encoder];
    }
    [self.class cc_enumeratePropertyNameUsingBlock:^(NSString *propertyName, NSUInteger index, BOOL *stop) {
        id value = [self valueForKey:propertyName];
        if (value == nil) return ;
        [encoder encodeObject:value forKey:propertyName];
    }];
}

- (void)cc_decode:(NSCoder *)decoder
{
    Class superClass = class_getSuperclass(self.class);
    if (superClass != nil && superClass != [NSObject class] && superClass != NSClassFromString(@"CC_Model")) {
        NSObject * superObject = superClass.new;
        [superObject cc_decode:decoder];
        [superClass cc_enumeratePropertyNameUsingBlock:^(NSString *propertyName, NSUInteger index, BOOL *stop) {
            [self setValue:[superObject valueForKey:propertyName] forKey:propertyName];
        }];
    }
    [self.class cc_enumeratePropertyAttributesUsingBlock:^(NSString *propertyName, objc_property_t property, NSUInteger index, BOOL *stop) {
        id value = [decoder decodeObjectForKey:propertyName];
        if (value == nil) return;
        [self setValue:value forKey:propertyName];
    }];
}

+ (void)cc_enumeratePropertyNameUsingBlock:(void (NS_NOESCAPE ^)(NSString * propertyName, NSUInteger index, BOOL * stop))block {
    unsigned int propertyCount = 0;
    BOOL stop = NO;
    objc_property_t * properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        block([NSString stringWithUTF8String:name],i,&stop);
        if (stop) break;
    }
    free(properties);
}

+ (void)cc_enumeratePropertyAttributesUsingBlock:(void (NS_NOESCAPE ^)(NSString * propertyName,objc_property_t property, NSUInteger index, BOOL * stop))block {
    unsigned int propertyCount = 0;
    BOOL stop = NO;
    objc_property_t * properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        block([NSString stringWithUTF8String:name],property,i,&stop);
        if (stop) break;
    }
    free(properties);
}

@end
