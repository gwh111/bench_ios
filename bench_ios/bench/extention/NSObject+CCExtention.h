//
//  NSObject+CCExtention.h
//  tower2
//
//  Created by gwh on 2018/12/18.
//  Copyright © 2018 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(CCExtention)

- (id)setClassKVDic:(NSDictionary *)dic;
- (NSDictionary *)getClassKVDic;
- (NSArray *)getClassNameList;
- (NSArray *)getClassTypeList;

@end

NS_ASSUME_NONNULL_END
