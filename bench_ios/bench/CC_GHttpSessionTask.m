//
//  GHttpSessionTask.m
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CC_GHttpSessionTask.h"
#import "CC_FormatDic.h"

@implementation CC_GHttpSessionTask
@synthesize resultData,finishCallbackBlock;

+ (void)postSessionWithJsonUrl:(NSURL *)url ParamterStr:(NSMutableDictionary *)paramsDic Info:(id)info FinishCallbackBlock:(void (^)(NSDictionary *, NSString *))block{
    CC_GHttpSessionTask *executorDelegate = [[CC_GHttpSessionTask alloc] init];
    executorDelegate.finishCallbackBlock = block; // 绑定执行完成时的block
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];
#warning md5key set
//    paraDic=paramsDic;
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
    
//    NSString *signKey = [UserStateManager shareInstance].user_signKey?[UserStateManager shareInstance].user_signKey:nil;
//    if (info) {
//        signKey = info;
//    }
    NSString *signKey = info;
    NSString *paraString=[CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:signKey];
    
    NSLog(@"GhttpUrl=:%@?%@",paraString,paramsDic);
    NSURLSessionDownloadTask *mytask=[session downloadTaskWithRequest:[self postRequestWithUrl:url andParamters:paraString data:data] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (error) {
//                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
                        executorDelegate.finishCallbackBlock(nil,errorString);
                        executorDelegate.finishCallbackBlock=nil;
                    }
                }
                return ;
            }
            
            //成功获取
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
                        executorDelegate.finishCallbackBlock(JSON,nil);
                        executorDelegate.finishCallbackBlock=nil;
                    }else
                    {
                        if ([[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"name"]isEqualToString:@"LOGIN_EXPIRED"]) {
                            executorDelegate.finishCallbackBlock(nil,[error description]);
                            executorDelegate.finishCallbackBlock=nil;
                            
//                            [[CC_CodeLib getRootNav]popToRootViewControllerAnimated:YES];
//                            [[LiveListViewController shareInstance]onMyForceOfflineWithText:nil];
//                            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PRESENT_LOGINVC object:nil];
                            
                            
                        }else if ([[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"name"] isEqualToString:@"USER_LOGIN_FORBID"]){
                            executorDelegate.finishCallbackBlock(nil,nil);
                            executorDelegate.finishCallbackBlock=nil;
                            NSLog(@"禁止登录了");
                            NSDictionary *resonseDic = [JSON objectForKey:@"response"];
                            NSString* jumpLogin = [resonseDic objectForKey:@"jumpLogin"];
                            NSDictionary *jumpLoginDic = [NSDictionary dictionaryWithObject:jumpLogin forKey:@"jumpLogin"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ForbidLogin" object:jumpLoginDic];
                        }else if ([[[JSON objectForKey:@"response"]objectForKey:@"jumpLogin"] boolValue]){
                            executorDelegate.finishCallbackBlock(nil,nil);
                            executorDelegate.finishCallbackBlock=nil;
                            NSLog(@"弹出登录页（jumpLogin=1）");
//                            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PRESENT_LOGINVC object:nil];
                        }
                        else{
                            if ([JSON objectForKey:@"response"]) {
                                executorDelegate.finishCallbackBlock(JSON,[NSString stringWithFormat:@"%@",[[[JSON objectForKey:@"response"]objectForKey:@"error"]objectForKey:@"message"]]);
                                executorDelegate.finishCallbackBlock=nil;
                            }
                            else
                            {
                                executorDelegate.finishCallbackBlock(JSON ,nil);
                                executorDelegate.finishCallbackBlock=nil;
                            }
                        }
                        
                    }
                    
                }else{
                    executorDelegate.finishCallbackBlock(nil,@"网络有问题或服务器开小差了~稍后再试吧");
                    executorDelegate.finishCallbackBlock=nil;
                }
            }
            
        });
        
        
    }];
    
    [mytask resume];
}

//创建request
+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url andParamters:(NSString *)paramsString data:(NSData *)data{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = [paramsString dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody=data;
    [request setTimeoutInterval:20];
    NSLog(@"GhttpUrl=:%@?%@",url,paramsString);
    //设置请求头
#warning appName,appUserAgent
    [request setValue:@"live-iphone" forHTTPHeaderField:@"appName"];
    [request setValue:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"appVersion"];
    
//    [request setValue:[NSString stringWithFormat:@"IOS_VERSION%fSCREEN_HEIGHT%d",IOS_VERSION,(int)SCREEN_HEIGHT] forHTTPHeaderField:@"appUserAgent"];
//    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //[request setAllHTTPHeaderFields:nil];
    //    NSLog(@"header=%@",[request allHTTPHeaderFields]);
    return request;
}

@end


