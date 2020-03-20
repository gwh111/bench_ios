//
//  TestServiceAPI.m
//  bench_ios
//
//  Created by gwh on 2019/11/5.
//

#import "TestServiceAPI.h"

@implementation TestServiceAPI

// 比较真实的例子 对于下面这个接口
// http://api-mgr.legend.net/project/project/interface/detail?appCode=user.account.api.mobile.base&interfaceId=871&moduleId=345&projectId=223
// 会生成如下代码

/**
* 账户日志跳转地址
* @param accountLogId  账户日志id
*/
+ (void)accountLogGoToUrlWithAccountLogId:(NSString *)accountLogId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:@"account/accountLogGoToUrl"];
    [params cc_setKey:@"accountLogId" value:accountLogId];
    
    [ccs.httpTask post:ccs.mainURL params:params model:nil finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

// 所有数据类型的例子
// 地址 + With + 大驼峰参数 + :(对象或基本数据类型) + 小驼峰参数 + ...... + success...fail...
    
+ (void)testAllAPIWithXxx1:(NSString *)string
                      Xxx2:(int)aInt
                      Xxx3:(float)aFloat
                      Xxx4:(double)aDouble
                      Xxx5:(NSArray *)array
                      Xxx6:(NSDictionary *)dictionary
                      Xxx7:(NSDecimalNumber *)money
                      Xxx8:(NSDate *)date
                      Xxx9:(NSData *)data
                   success:(void(^)(HttpModel *result))successBlock
                      fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    
    [ccs maskStart];
    
    NSMutableDictionary *params = ccs.mutDictionary;
    [params cc_setKey:@"service" value:@"xxx"];
    [params cc_setKey:@"xxx1" value:string];
    [params cc_setKey:@"xxx2" value:@(aInt)];
    [params cc_setKey:@"xxx3" value:@(aFloat)];
    [params cc_setKey:@"xxx4" value:@(aDouble)];
    [params cc_setKey:@"xxx5" value:array];
    [params cc_setKey:@"xxx6" value:dictionary];
    [params cc_setKey:@"xxx7" value:money];
    [params cc_setKey:@"xxx8" value:date];
    [params cc_setKey:@"xxx9" value:data];
    
    [ccs.httpTask post:ccs.mainURL params:params model:nil finishBlock:^(NSString *error, HttpModel *result) {
        
        [ccs maskStop];
        if (error) {
            failBlock(error, result);
            return;
        }
        successBlock(result);
    }];
    
}

@end
