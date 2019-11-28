//
//  CC_Service.h
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import <Foundation/Foundation.h>
#import "CC_HttpResponseModel.h"
#import "CC_Lib+NSDictionary.h"

NS_ASSUME_NONNULL_BEGIN

// overload request

@interface CC_Service : NSObject

@property (nonatomic, retain) NSMutableDictionary *requestMap;
@property (nonatomic, retain) NSMutableDictionary *responseMap;

@property (nonatomic, retain) NSString *appCode;
@property (nonatomic, retain) NSString *sourceVersion;

// re-config request
- (void)config:(NSString *)service block:(void(^)(HttpModel *httpModel))block;

// check-config request
// return YES if has config
- (BOOL)checkConfig:(NSString *)service httpModel:(HttpModel *)model success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock;

// output-config request
- (void)config:(NSString *)service finish:(HttpModel *)resultDic;

@end

NS_ASSUME_NONNULL_END
