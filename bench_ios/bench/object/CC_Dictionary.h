//
//  CC_Dictionary.h
//  bench_ios
//
//  Created by gwh on 2018/8/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_Dictionary : NSDictionary

+ (void)ccsetObject:(id)object forKey:(id)key dic:(NSMutableDictionary *)dic;

@end
