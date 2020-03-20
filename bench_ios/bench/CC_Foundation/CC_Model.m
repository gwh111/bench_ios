//
//  CC_Model.m
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Model.h"

@interface CC_Model (){
    NSDictionary *arrMap;
}

@end

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

- (void)cc_setObjectClassInArrayWithDic:(NSDictionary *)dic {
    // 类中的两个数组中存放的是哪两个模型
    arrMap = dic;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    CCLOG(@"UndefinedKey: %@",key);
}

#pragma mark private
- (id)cc_setClassKVDic:(NSDictionary *)dic modelKVDic:(NSDictionary *)modelKVDic {
    NSArray *names = [self cc_getClassNameList];
    NSArray *types = [self cc_getClassTypeList];
    for (int i = 0; i < names.count; i++) {
        NSString *name = names[i];
        name = [name substringFromIndex:1];
        if (modelKVDic[name]) {
            name = modelKVDic[name];
        }
        id value = [dic valueForKey:name];
        NSString *type = types[i];
        if (!value) {
            if ([type containsString:@"NSString"]) {
                [self setValue:@"" forKey:names[i]];
            }
            continue;
        }
        [self scanDeepStepWithValue:value type:type name:names[i] model:self];
    }
    return self;
}

- (void)scanDeepStepWithValue:(id)value type:(NSString *)type name:(NSString *)name model:(id)model {
    if ([value isKindOfClass:NSDictionary.class] && (![type containsString:@"NSDictionary"] && ![type containsString:@"NSMutableDictionary"])) {
        id tempM = [[NSClassFromString(type) alloc]init];
        NSArray *names = [tempM cc_getClassNameList];
        NSArray *types = [tempM cc_getClassTypeList];
        for (int i = 0; i < names.count; i++) {
            NSString *tempName = names[i];
            tempName = [tempName substringFromIndex:1];
            id tempValue = [value valueForKey:tempName];
            NSString *tempType = types[i];
            if (!tempValue) {
                if ([tempType containsString:@"NSString"]) {
                    [tempM setValue:@"" forKey:names[i]];
                }
                continue;
            }
            [self scanDeepStepWithValue:tempValue type:tempType name:tempName model:tempM];
        }
        [model setValue:tempM forKey:name];
        return;
    }
    else if ([value isKindOfClass:NSArray.class]) {
        NSString *tempName = name;
        tempName = [tempName substringFromIndex:1];
        if (arrMap[tempName]) {
            NSMutableArray *list = NSMutableArray.new;
            for (id tempValue in value) {
                id tempM = [[NSClassFromString(arrMap[tempName]) alloc]init];
                NSArray *names = [tempM cc_getClassNameList];
                NSArray *types = [tempM cc_getClassTypeList];
                for (int i = 0; i < names.count; i++) {
                    NSString *tempName = names[i];
                    tempName = [tempName substringFromIndex:1];
                    id tempValue2 = [tempValue valueForKey:tempName];
                    NSString *tempType = types[i];
                    if (!tempValue2) {
                        if ([tempType containsString:@"NSString"]) {
                            [tempM setValue:@"" forKey:names[i]];
                        }
                        continue;
                    }
                    [self scanDeepStepWithValue:tempValue2 type:tempType name:tempName model:tempM];
                }
                [list addObject:tempM];
            }
            [model setValue:list forKey:name];
            return;
        }
    }
    if ([type containsString:@"CC_Money"]) {
        CC_Money *money = CC_Money.new;
        [money moneyWithString:[NSString stringWithFormat:@"%@", value]];
        [model setValue:money forKey:name];
        return;
    }
    if ([type containsString:@"NSString"]) {
        [model setValue:[NSString stringWithFormat:@"%@", value] forKey:name];
        return;
    }
    [model setValue:value forKey:name];
}

@end
