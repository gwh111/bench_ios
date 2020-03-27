//
//  NSObject+CCExtention.h
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(CC_Foundation)

- (id)cc_copy;

// set model property with NSDictionary
- (id)cc_setClassKVDic:(NSDictionary *)dic;

// output NSDictionary from model property
- (NSDictionary *)cc_getClassKVDic;

// output NSDictionary from model property without "_"
- (NSDictionary *)cc_getClassKVDicWithout_;

- (NSArray *)cc_getClassNameList;

- (NSArray *)cc_getClassTypeList;

// 解码（从文件中解析对象）
- (void)cc_decode:(NSCoder *)decoder;

// 编码（将对象写入文件中）
- (void)cc_encode:(NSCoder *)encoder;

@end

NS_ASSUME_NONNULL_END


/**
 归档的实现
 */
#define CCCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self cc_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self cc_encode:encoder]; \
}
