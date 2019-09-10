//
//  NSObject+CCExtention.h
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(CC_Lib)

/** set model property with NSDictionary */
- (id)cc_setClassKVDic:(NSDictionary *)dic;

/** output NSDictionary from model property */
- (NSDictionary *)cc_getClassKVDic;

/** output NSDictionary from model property without "_" */
- (NSDictionary *)cc_getClassKVDic_;

- (NSArray *)cc_getClassNameList;

- (NSArray *)cc_getClassTypeList;

@end

NS_ASSUME_NONNULL_END
