//
//  CC_Model.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Model.h"

@implementation CC_Model
@synthesize cc_modelDic;

- (void)cc_update{}

- (void)cc_setProperty:(NSDictionary *)dic {
    cc_modelDic = dic;
    [self cc_setClassKVDic:dic modelKVDic:nil];
}

- (void)cc_setProperty:(NSDictionary *)dic modelKVDic:(NSDictionary *)modelKVDic {
    cc_modelDic = dic;
    [self cc_setClassKVDic:dic modelKVDic:modelKVDic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    CCLOG(@"UndefinedKey: %@",key);
}

#pragma mark private
- (id)cc_setClassKVDic:(NSDictionary *)dic modelKVDic:(NSDictionary *)modelKVDic {
    NSArray *names = [self cc_getClassNameList];
    NSArray *types = [self cc_getClassTypeList];
    for (int i=0; i<names.count; i++) {
        NSString *name = names[i];
        name = [name substringFromIndex:1];
        if (modelKVDic[name]) {
            name = modelKVDic[name];
        }
        id value = [dic valueForKey:name];
        if (!value) {
            NSString *type = types[i];
            if ([type containsString:@"NSString"]) {
                [self setValue:@"" forKey:names[i]];
            }
            continue;
        }
        [self setValue:value forKey:names[i]];
    }
    return self;
}

@end
