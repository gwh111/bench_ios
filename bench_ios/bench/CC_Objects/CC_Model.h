//
//  CC_Model.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_Model : CC_Object

@property (nonatomic,retain) NSDictionary *cc_modelDictionary;

+ (instancetype)cc_modelWithDictionary:(NSDictionary *)dic;

// property/model
- (void)cc_setObjectClassInArrayWithDic:(NSDictionary *)dic;

// Use json data to set property.
- (void)cc_setProperty:(NSDictionary *)dic;

// @param modelKVDic: key = 'your model property', value = 'key in dic'
- (void)cc_setProperty:(NSDictionary *)dic modelKVDic:(NSDictionary *)modelKVDic;

// You can write 'cc_update' in your model to do calculation, otherwise, there is no need to call it.
- (void)cc_update;

@end
