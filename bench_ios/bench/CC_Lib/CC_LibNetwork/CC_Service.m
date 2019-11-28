//
//  CC_Service.m
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "CC_Service.h"

@implementation CC_Service

const NSString *TEXT_SUCCESS = @"success";
const NSString *TEXT_FAIL = @"fail";

- (void)start {
    _requestMap = NSMutableDictionary.new;
    _responseMap = NSMutableDictionary.new;
}

- (void)config:(NSString *)service block:(void(^)(HttpModel *httpModel))block {
    [self.requestMap cc_setKey:service value:block];
}

- (BOOL)checkConfig:(NSString *)service httpModel:(HttpModel *)model success:(void(^)(HttpModel *result))successBlock fail:(void(^)(NSString *errorMsg, HttpModel *result))failBlock {
    if (self.requestMap[service]) {
        [self.responseMap cc_setKey:service value:@{TEXT_SUCCESS:successBlock, TEXT_FAIL:failBlock}];
        void(^requestBlock)(HttpModel *params) = self.requestMap[service];
        requestBlock(model);
        return YES;
    }
    return NO;
}

- (void)config:(NSString *)service finish:(HttpModel *)resultDic {
    
    if (resultDic.errorMsgStr) {
        
        void(^failBlock)(NSString *errorMsg, HttpModel *result) = self.responseMap[service][TEXT_FAIL];
        [self.responseMap cc_removeKey:service];
        failBlock(resultDic.errorMsgStr, resultDic);
    } else {
        
        void(^successBlock)(HttpModel *result) = self.responseMap[service][TEXT_SUCCESS];
        [self.responseMap cc_removeKey:service];
        successBlock(resultDic);
    }
    
}


@end
