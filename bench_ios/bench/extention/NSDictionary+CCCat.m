//
//  NSDictionary+Property.m
//  1.字典转模型KVC
//
//  Created by 王玲峰 on 2019/2/28.
//  Copyright © 2019年 王玲峰. All rights reserved.
//

#import "NSDictionary+CCCat.h"

@implementation NSDictionary (CCCat)
- (void)creatPropertyCode{
    NSMutableString *codes = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@",key];
        }else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@",key];
        }else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@",key];
        }else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@",key];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@",key];
        }
        [codes appendFormat:@"\n%@;\n",code];

    }];
    NSLog(@"%@",codes);
}
@end
