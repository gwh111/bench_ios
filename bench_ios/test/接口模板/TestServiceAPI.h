//
//  TestServiceAPI.h
//  bench_ios
//
//  Created by gwh on 2019/11/5.
//

#import <Foundation/Foundation.h>
#import "ccs.h"
#import "ccs+TestServiceAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestServiceAPI : NSObject

/**
* 账户日志跳转地址
* @param accountLogId  账户日志id
*/
+ (void)accountLogGoToUrlWithAccountLogId:(NSString *)accountLogId
                                  success:(void(^)(HttpModel *result))successBlock
                                     fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

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
                      fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

@end

NS_ASSUME_NONNULL_END
