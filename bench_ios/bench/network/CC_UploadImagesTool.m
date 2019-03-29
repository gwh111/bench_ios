//
//  CC_UploadImagesTool.m
//  AFNetworking
//
//  Created by 路飞  on 2019/3/12.
//

#import "CC_UploadImagesTool.h"
#import "CC_Share.h"
#import "CC_FormatDic.h"

@implementation CC_UploadImagesTool
+(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<ResModel *> *, NSArray<ResModel *> *))uploadImageBlock{
    
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl=url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl=[NSURL URLWithString:url];
    }else{
        CCLOG(@"url 不合法");
    }
    [CC_HookTrack catchTrack];
    
    CC_HttpTask *executorDelegate = [[CC_HttpTask alloc] init];
    executorDelegate.finishUploadImagesCallbackBlock = uploadImageBlock; // 绑定执行完成时的block
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];//子线程
    
    //组装参数
    if ([paramsDic isKindOfClass:[NSDictionary class]]) {
        paramsDic=[[NSMutableDictionary alloc]initWithDictionary:paramsDic];
    }
    if (![paramsDic objectForKey:@"service"]) {
        [paramsDic setObject:@"IMAGE_TEMP_UPLOAD" forKey:@"service"];
    }
    if (paramsDic == nil) {
        paramsDic = [[NSMutableDictionary alloc]init];
    }
    if ([CC_HttpTask getInstance].forbiddenTimestamp==0) {
        if (!paramsDic[@"timestamp"]) {
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
            [paramsDic setObject:timeSp forKey:@"timestamp"];
        }
    }
    if ([CC_HttpTask getInstance].extreDic) {
        NSArray *keys=[[CC_HttpTask getInstance].extreDic allKeys];
        for (int i=0; i<keys.count; i++) {
            [paramsDic setObject:[CC_HttpTask getInstance].extreDic[keys[i]] forKey:keys[i]];
        }
    }
    
    NSString *paraString=[CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:[CC_HttpTask getInstance].signKeyStr];
    NSMutableURLRequest *urlReq=[[CC_HttpTask getInstance] postRequestWithUrl:tempUrl andParamters:paraString];
    
    //图片请求结果
    __block NSMutableArray* resModelResultArr = [[NSMutableArray alloc]init];
    __block NSMutableArray* errorResultArr = [[NSMutableArray alloc]init];
    
    //通过dispatch_group 管理多个请求
    dispatch_queue_t dispatchQueue = dispatch_queue_create("uploadImageQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    for (int i = 0; i < images.count; i++) {
        
        ResModel* model=[[ResModel alloc]init];
        model.serviceStr=paramsDic[@"service"];
        if (![CC_HttpTask getInstance].signKeyStr) {
            if (model.debug) {
                CCLOG(@"_signKeyStr为空");
            }
        }
        model.requestUrlStr=urlReq.URL.absoluteString;
        model.requestStr=ccstr(@"%@%@",urlReq.URL.absoluteString,paraString);
        
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
            dispatch_group_enter(dispatchGroup);
            NSURLRequest* request = [CC_UploadImagesTool recaculateImageDatas:images[i] imageScale:imageScale paramsDic:paramsDic request:urlReq];
            
            [CC_UploadImagesTool requestSingleImageWithSession:session executorDelegate:executorDelegate request:request index:i+1 reConnectTimes:times model:model finishBlock:^(NSString *error, ResModel *resModel) {
                if (error) {
                    [errorResultArr addObject:resModel];
                }else{
                    [resModelResultArr addObject:resModel];
                }
                dispatch_group_leave(dispatchGroup);
            }];
        });
    }
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        CCLOG(@"所有图片上传完成-----end");
        [session finishTasksAndInvalidate];
        executorDelegate.finishUploadImagesCallbackBlock(errorResultArr, resModelResultArr);
    });
}

+(void)requestSingleImageWithSession:(NSURLSession*)session executorDelegate:(CC_HttpTask *)executorDelegate request:(NSURLRequest*)request index:(int)index reConnectTimes:(NSInteger)reConnectTimes model:(ResModel*)model finishBlock:(void (^)(NSString *, ResModel *))block{
    
    executorDelegate.finishCallbackBlock = block; // 绑定执行完成时的block
    
    __block NSInteger reTryTimes = reConnectTimes;
    __weak __typeof(self)weakSelf = self;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong __typeof(self)strongSelf = weakSelf;
        if (error) {
            //重新发起请求
            if (reTryTimes == 0) {
                [model parsingError:error];
                executorDelegate.finishCallbackBlock(model.errorMsgStr, model);
            }else{
                CCLOG(@"上传第%d张图片失败-----重连还剩%ld次", index, (long)reTryTimes);
                reTryTimes--;
                [strongSelf requestSingleImageWithSession:session executorDelegate:executorDelegate request:request index:index reConnectTimes:reTryTimes model:model finishBlock:block];
            }
        }else{
            [model parsingResult:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            if (model.errorMsgStr) {
                CCLOG(@"上传第%d张图片失败-----result:%@", index, model.resultDic);
            }else{
                CCLOG(@"上传第%d张图片成功-----result:%@", index, model.resultDic);
            }
            executorDelegate.finishCallbackBlock(model.errorMsgStr, model);
        }
    }];
    [task resume];
}

+(NSURLRequest*)recaculateImageDatas:(UIImage*)image imageScale:(CGFloat)imageScale paramsDic:(NSDictionary*)paramsDic request:(NSMutableURLRequest*)urlReq{
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [paramsDic allKeys];
    //遍历keys
    for(int i=0;i<[keys count];i++) {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[paramsDic objectForKey:key]];
    }
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //要上传的图片--得到图片的data
    NSData* data = UIImageJPEGRepresentation(image, imageScale);
    NSMutableString *imgbody = [[NSMutableString alloc] init];
    //添加分界线，换行
    [imgbody appendFormat:@"%@\r\n",MPboundary];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    [imgbody appendFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n", fileName];
    //声明上传文件的格式
    [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    [myRequestData appendData:[ @"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [urlReq setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [urlReq setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [urlReq setHTTPBody:myRequestData];
    
    return urlReq;
}

@end
