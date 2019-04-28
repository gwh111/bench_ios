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
    
    _networkError=error;
    if (_debug) {
        
        if ([ccs getLocalKeyNamed:@"service" andKey:_serviceStr]) {
            _resultStr=[ccs getLocalKeyNamed:@"service" andKey:_serviceStr];
            [self parsingResult:_resultStr];
            [CC_Note showAlert:@"_debug Data" atView:nil];
        }else{
            _errorNameStr=error.description;
            CCLOG(@"%@",_errorNameStr);
            _errorNameStr=[NSString stringWithFormat:@"请求失败，请检查网络是否开启(%ld)",(long)error.code];
            _errorMsgStr=_errorNameStr;
        }
    }else{
        
        _errorNameStr=[NSString stringWithFormat:@"请求失败，请检查网络是否开启(%ld)",(long)error.code];
        _errorMsgStr=_errorNameStr;
    }
    
}

- (void)parsingResult:(NSString *)resultStr{
    
    if (!resultStr) {
        _errorNameStr=@"resultStr=nil 无法解析data";
        if (_debug==0) {
            _errorNameStr=@"服务器开小差了";
        }
        _errorMsgStr=_errorNameStr;
        return;
    }
    _resultStr=resultStr;
    NSData *data = [_resultStr dataUsingEncoding:NSUTF8StringEncoding];
    if (data) {
        _resultDic=
        [NSJSONSerialization JSONObjectWithData: data
                                        options: NSJSONReadingMutableLeaves
                                          error: nil];
        if (_resultDic==nil) {
            _parseFail=1;
            _errorNameStr=@"_resultDic=nil 无法解析data";
            if (_debug==0) {
                _errorNameStr=@"服务器开小差了";
            }
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
        }else{
            //纠正出现的小数8.369999999999999问题
            NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:_resultDic];
            mutDic=[mutDic correctDecimalLoss:mutDic];
            _resultDic=(NSDictionary *)mutDic;
        }
        //服务端返回的错误
        NSDictionary *responseDic=_resultDic[@"response"];
        if (!responseDic) {
            responseDic=_resultDic;
            if (_headerEncrypt) {
                _resultDic=@{@"response":responseDic};
            }
        }
        if ([responseDic[@"success"]intValue]==0) {
            
            if (responseDic[@"detailMessage"]) {
                _errorNameStr=responseDic[@"detailMessage"];
                _errorMsgStr=_errorNameStr;
            }else if (responseDic[@"error"]) {
                _errorNameStr=responseDic[@"error"][@"name"];
                _errorMsgStr=responseDic[@"error"][@"message"];
            }else{
                _errorNameStr=nil;
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
            
//            if ([CC_Parser safeCheckStart:self]) {
//                
//            }else{
//                [CC_Parser safeCheckEnd:self];
//            }
        }
    }
}

@end
