//
//  GHttpSessionTask.m
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CC_GHttpSessionTask.h"
#import "CC_FormatDic.h"
#import "CC_Share.h"

@implementation CC_GHttpSessionTask
@synthesize finishCallbackBlock;

+ (void)postSessionWithJsonUrl:(NSURL *)url ParamterStr:(NSMutableDictionary *)paramsDic Info:(id)info FinishCallbackBlock:(void (^)(NSDictionary *, NSString *, NSString *))block{
    CC_GHttpSessionTask *executorDelegate = [[CC_GHttpSessionTask alloc] init];
    executorDelegate.finishCallbackBlock = block; // 绑定执行完成时的block
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];

    NSError *error = nil;
    
    //时间转时间戳的方法:
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
    [paramsDic setObject:timeSp forKey:@"timestamp"];
    if (!paramsDic[@"timestamp"]) {
        [paramsDic setObject:timeSp forKey:@"timestamp"];
    }
    
    NSDictionary *diccc=[[NSDictionary alloc]initWithDictionary:paramsDic];
    NSData *data = [NSJSONSerialization dataWithJSONObject:diccc options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *signKey = info;
    if ([CC_Share shareInstance].user_signKey) {
        signKey=[CC_Share shareInstance].user_signKey;
    }
    NSString *paraString=[CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:signKey];
    
    NSLog(@"GhttpUrl=:%@?%@",paraString,paramsDic);
    NSURLSessionDownloadTask *mytask=[session downloadTaskWithRequest:[self postRequestWithUrl:url andParamters:paraString data:data] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (error) {
                
                if (executorDelegate.finishCallbackBlock) { // 如果设置了回调的block，直接调用
                    if (error) {
                        
                        NSString *errorString=[error description];
                        NSLog(@"network error=%@ code=%ld",errorString,error.code);
                        errorString=[NSString stringWithFormat:@"网络有问题或服务器开小差了~稍后再试吧（%ld）",error.code];
                        //            if (error.code==-1001) {
                        //                errorString=@"请求超时";
                        //            }else{
                        //                errorString=[NSString stringWithFormat:@"网络有问题或服务器开小差了~稍后再试吧（%ld）",error.code];
                        //            }
                        executorDelegate.finishCallbackBlock(nil,nil,errorString);
                        executorDelegate.finishCallbackBlock=nil;
                    }
                }
                return ;
            }
            
            //成功获取
            //判断回调的数据是否为空
            //判断回调的数据格式是否正确
            //判断签名是否正确
            NSError *error;
            
            if (executorDelegate.finishCallbackBlock) {
                //        NSData *data=[NSData dataWithContentsOfURL:location];
                NSString *resultString= [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:&error];
                NSLog(@"finish callback block, result json string: %@，err:%@", resultString,error);
                //        if (error) {
                //            resultString= [NSString stringWithContentsOfURL:location encoding:NSUTF8StringEncoding error:&error];
                //        }
                
                
                NSData *data = [resultString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *JSON =
                [NSJSONSerialization JSONObjectWithData: data
                                                options: NSJSONReadingMutableLeaves
                                                  error: nil];
                NSString *service=[paramsDic objectForKey:@"service"];
                NSLog(@"JSON_service=%@%@",service,JSON);

                //对于sp的double类型精度丢失的问题 使用sbjson来解析
//                if ([service isEqualToString:@""]) {
//                    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
//                    JSON = [jsonParser objectWithString:resultString];
//                }
                if (JSON) {
                    if ([[[JSON objectForKey:@"response"] objectForKey:@"success"]intValue]==1) {
                        executorDelegate.finishCallbackBlock(JSON,resultString,nil);
                        executorDelegate.finishCallbackBlock=nil;
                    }else
                    {
                        if ([[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"name"]isEqualToString:@"LOGIN_EXPIRED"]) {
                            executorDelegate.finishCallbackBlock(nil,resultString,[error description]);
                            executorDelegate.finishCallbackBlock=nil;
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_EXPIRED object:nil];
                            
                            
                        }else if ([[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"name"] isEqualToString:@"USER_LOGIN_FORBID"]){
                            executorDelegate.finishCallbackBlock(nil,nil,nil);
                            executorDelegate.finishCallbackBlock=nil;
                            NSLog(@"禁止登录了");
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGIN_FORBID object:JSON];
                        }else if ([[[JSON objectForKey:@"response"]objectForKey:@"jumpLogin"] boolValue]){
                            executorDelegate.finishCallbackBlock(nil,nil,nil);
                            executorDelegate.finishCallbackBlock=nil;
                            NSLog(@"弹出登录页（jumpLogin=1）");
                            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_jumpLogin object:nil];
                        }
                        else{
                            if ([JSON objectForKey:@"response"]) {
                                executorDelegate.finishCallbackBlock(JSON,resultString,[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"message"]]);
                                executorDelegate.finishCallbackBlock=nil;
                            }
                            else
                            {
                                executorDelegate.finishCallbackBlock(JSON,resultString,nil);
                                executorDelegate.finishCallbackBlock=nil;
                            }
                        }
                        
                    }
                    
                }else{
                    executorDelegate.finishCallbackBlock(nil,nil,@"网络有问题或服务器开小差了~稍后再试吧");
                    executorDelegate.finishCallbackBlock=nil;
                }
            }
            
        });
        
        
    }];
    
    [mytask resume];
}

//创建request
+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString data:(NSData *)data{
    
    NSMutableURLRequest *request = [CC_Share shareInstance].httpRequest;
    request.URL=url;
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];

    return request;
}

@end


