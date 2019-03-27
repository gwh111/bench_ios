//
//  NSObject+CCExtention.h
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(CCCat)

/**
 *  遍历model所有属性对model赋值
 */
- (id)setClassKVDic:(NSDictionary *)dic;

/**
 *  对model所有属性输出字典
 */
- (NSDictionary *)getClassKVDic;
/**
 *  对model所有属性输出字典 去除下划线_
 */
- (NSDictionary *)getClassKVDic_equal;

/**
 *  获取所有类名
 */
- (NSArray *)getClassNameList;

/**
 *  获取所有类的类型
 */
- (NSArray *)getClassTypeList;

@end

NS_ASSUME_NONNULL_END
