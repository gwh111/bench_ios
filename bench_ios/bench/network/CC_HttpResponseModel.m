//
//  CC_HttpResponseModel.m
//  bench_ios
//
//  Created by gwh on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_HttpResponseModel.h"
#import "CC_Share.h"

@implementation ResModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _debug=[CC_Share shareInstance].ccDebug;
    }
    return self;
}

- (void)parsingError:(NSError *)error{
    
    if (_debug) {
        if ([ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
            _resultStr=[ccs getLocalKeyNamed:@"service" andKey:_serviceStr];
            [self parsingResult:_resultStr];
            [CC_Note showAlert:@"_debug Data" atView:nil];
        }else{
            _errorStr=error.description;
        }
    }else{
        _errorStr=error.description;
    }
}

- (void)parsingResult:(NSString *)resultStr{
    
    _resultStr=resultStr;
    NSData *data = [_resultStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        _resultDic=
        [NSJSONSerialization JSONObjectWithData: data
                                        options: NSJSONReadingMutableLeaves
                                          error: nil];
        if (_resultDic==nil) {
            _errorStr=@"_resultDic=nil 无法解析data";
            [CC_Note showAlert:_errorStr];
            if (_debug) {
                if ([ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
                    _resultStr=[ccs getLocalKeyNamed:@"service" andKey:_serviceStr];
                    [self parsingResult:_resultStr];
                    [CC_Note showAlert:@"_debug Data" atView:nil];
                }
            }
            return;
        }
        if (_resultDic[@"response"][@"error"]) {//服务端的错误
            _errorStr=_resultDic[@"response"][@"error"][@"name"];
        }
    }else{//解析错误
        _errorStr=@"data=nil 可能是GBK";
        [CC_Note showAlert:_errorStr];
        return;
    }
    
    if (_errorStr) {
        
    }else{
        
//        CCLOG(@"path=%@",[NSString stringWithFormat:@"%@", NSHomeDirectory()]);
        if (![ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
            [ccs saveLocalKeyNamed:@"service" andKey:_serviceStr andValue:_resultStr];
        }
    }
}

@end
