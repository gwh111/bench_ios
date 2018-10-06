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
        _debug=[CC_Share getInstance].ccDebug;
        _responseDateFormatStr=@"dd MM yyyy HH:mm:ss";
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
            _errorNameStr=error.description;
            CCLOG(@"%@",_errorNameStr);
            _errorNameStr=[NSString stringWithFormat:@"网络连接失败(%ld)",(long)error.code];
            _errorMsgStr=_errorNameStr;
        }
    }else{
        
        _errorNameStr=[NSString stringWithFormat:@"网络连接失败(%ld)",(long)error.code];
        _errorMsgStr=_errorNameStr;
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
            _errorNameStr=@"_resultDic=nil 无法解析data";
            _errorMsgStr=_errorNameStr;
            if (_debug) {
                [CC_Note showAlert:_errorMsgStr];
                if ([ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
                    _resultStr=[ccs getLocalKeyNamed:@"service" andKey:_serviceStr];
                    _errorNameStr=nil;
                    _errorMsgStr=nil;
                    [self parsingResult:_resultStr];
                    [CC_Note showAlert:@"_debug Data" atView:nil];
                }
            }
            return;
        }
        //服务端返回的错误
        if ([_resultDic[@"response"][@"success"]intValue]==0) {
            
            if (_resultDic[@"response"][@"detailMessage"]) {
                _errorNameStr=_resultDic[@"response"][@"detailMessage"];
                _errorMsgStr=_errorNameStr;
            }else if (_resultDic[@"response"][@"error"]) {
                _errorNameStr=_resultDic[@"response"][@"error"][@"name"];
                _errorMsgStr=_resultDic[@"response"][@"error"][@"message"];
            }else{
                _errorNameStr=@"success=false 但没有 detailMessage&error";
                _errorMsgStr=_errorNameStr;
            }
        }
        
    }else{//解析错误
        _errorNameStr=@"data=nil";
        _errorMsgStr=_errorNameStr;
        if (_debug) {
            [CC_Note showAlert:_errorMsgStr];
        }
        return;
    }
    
    if (_errorNameStr) {
        
    }else{
        
        if (_debug) {
            if (![ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
                [ccs saveLocalKeyNamed:@"service" andKey:_serviceStr andValue:_resultStr];
            }
        }
    }
}

@end
