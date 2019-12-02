//
//  CC_HttpResponseModel.m
//  bench_ios
//
//  Created by gwh on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_HttpResponseModel.h"
//#import "CC_Share.h"
#import "CC_HttpConfig.h"

@implementation HttpModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _debug = [CC_Base shared].cc_debug;
        _responseDateFormatStr = @"dd MM yyyy HH:mm:ss";
    }
    return self;
}

- (void)parsingError:(NSError *)error{
    _networkError = error;
    if (_debug) {
        _errorNameStr = error.description;
        CCLOG(@"%@",_errorNameStr);
        if ([CC_SandboxStore cc_sandboxPlistWithPath:@"service"][_service]) {
            _resultStr = [CC_SandboxStore cc_sandboxPlistWithPath:@"service"][_service];
            CCLOG(@"Debug Data '%@'",_service);
            [self parsingResult:_resultStr];
        }else{
            _errorNameStr = [NSString stringWithFormat:@"请求失败，请检查网络是否开启(%ld)",(long)error.code];
            _errorMsgStr = _errorNameStr;
        }
    }else{
        _errorNameStr = [NSString stringWithFormat:@"请求失败，请检查网络是否开启(%ld)",(long)error.code];
        _errorMsgStr = _errorNameStr;
    }
}

- (void)parsingResult:(NSString *)resultStr{
    if (!resultStr) {
        _errorNameStr = @"服务器开小差了";
        _errorMsgStr = _errorNameStr;
        return;
    }
    _resultStr = resultStr;
    NSData *data = [_resultStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        _resultDic = [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableLeaves
                                          error:nil];
        if (_resultDic == nil) {
            _parseFail = 1;
            _errorNameStr = @"服务器开小差了";
            _errorMsgStr = _errorNameStr;
            if (_debug) {
                NSLog(@"%@",_errorMsgStr);
                if ([CC_SandboxStore cc_sandboxPlistWithPath:@"service"][_service]) {
                    _resultStr = [CC_SandboxStore cc_sandboxPlistWithPath:@"service"][_service];
                    _errorNameStr = nil;
                    _errorMsgStr = nil;
                    NSLog(@"Debug Data '%@'",_service);
                    [self parsingResult:_resultStr];
                }
            }
            return;
        }else{
            // 纠正出现的小数8.369999999999999问题
            NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:_resultDic];
            mutDic = [mutDic cc_correctDecimalLoss:mutDic];
            _resultDic = (NSDictionary *)mutDic;
        }
        // 服务端返回的错误
        NSDictionary *responseDic = _resultDic[@"response"];
        if (!responseDic) {
            responseDic = _resultDic;
            if (_headerEncrypt) {
                _resultDic = @{@"response":responseDic};
            }
        }
        if ([responseDic[@"success"]intValue] == 0) {
            
            if (responseDic[@"detailMessage"]) {
                _errorNameStr = responseDic[@"detailMessage"];
                _errorMsgStr = _errorNameStr;
            }else if (responseDic[@"error"]) {
                _errorNameStr = responseDic[@"error"][@"name"];
                _errorMsgStr = responseDic[@"error"][@"message"];
            }else{
                if (responseDic[@"success"]) {
                    _errorNameStr = @"undefined error";
                }else{
                    _errorNameStr = nil;
                }
                _errorMsgStr = _errorNameStr;
            }
        }
    }else{
        // 解析错误
        _errorNameStr = @"data=nil";
        _errorMsgStr = _errorNameStr;
        if (_debug) {
            CCLOG(@"%@",_errorMsgStr);
        }
        return;
    }
    
    // 添加debug回查
    if (!_errorNameStr) {
        if (_debug) {
            if (![CC_SandboxStore cc_sandboxPlistWithPath:@"service"][_service]) {
                NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:[CC_SandboxStore cc_sandboxPlistWithPath:@"service"]];
                [mutDic cc_setKey:_service value:_resultStr];
                [CC_SandboxStore cc_saveToSandboxWithData:mutDic toPath:@"service" type:@"plist"];
            }
        }
    }
}

@end
