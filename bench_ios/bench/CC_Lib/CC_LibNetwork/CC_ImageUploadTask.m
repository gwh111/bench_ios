//
//  CC_UploadImagesTool.m
//  AFNetworking
//
//  Created by 路飞  on 2019/3/12.
//

#import "CC_ImageUploadTask.h"
#import "CC_HttpHelper.h"
#import "CC_Image.h"

typedef NS_ENUM(NSUInteger, CCCompressionType) {
    CCCompressionTypeScale,//指定比例压缩
    CCCompressionTypeSize,//指定大小压缩
    CCCompressionTypeNone,//不指定类型
};

@interface CC_ImageUploadTask (){
    CC_HttpConfig *tempConfigure;
    CCCompressionType tempCompressionType;
    CGFloat tempScalePercent;//指定压缩比例
    NSUInteger tempScaleSize;//指定压缩大小
}

@end

@implementation CC_ImageUploadTask

- (void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock{
    tempConfigure = configure;
    tempScalePercent = imageScale;
    tempCompressionType = CCCompressionTypeScale;
    [self uploadImages:images url:url params:paramsDic reConnectTimes:times finishBlock:uploadImageBlock];
}

- (void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock{
    tempConfigure = configure;
    tempScaleSize = imageSize;
    tempCompressionType = CCCompressionTypeSize;
    [self uploadImages:images url:url params:paramsDic reConnectTimes:times finishBlock:uploadImageBlock];
}

- (void)uploadImages:(NSArray<NSData *> *)imageDatas url:(id)url params:(id)paramsDic reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock{
    tempConfigure = configure;
    tempCompressionType = CCCompressionTypeNone;
    [self uploadImages:imageDatas url:url params:paramsDic reConnectTimes:times finishBlock:uploadImageBlock];
}

- (void)uploadImages:(NSArray<id> *)images url:(id)url params:(id)paramsDic reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock{

    CC_HttpTask *executorDelegate = [[CC_HttpTask alloc] init];
    executorDelegate.finishUploadImagesBlock = uploadImageBlock; // 绑定执行完成时的block
    
    //图片判空 若为空 直接返回错误
    if (images.count < 1) {
        HttpModel *model = [[HttpModel alloc]init];
        model.service = paramsDic[@"service"];
        model.errorMsgStr = @"上传图片为空";
        executorDelegate.finishUploadImagesBlock(@[model], @[]);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];//子线程
    
    //图片请求结果
    __block NSMutableArray *resModelResultArr = [[NSMutableArray alloc]init];
    __block NSMutableArray *errorResultArr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < images.count; i++) {
        [resModelResultArr addObject:[HttpModel new]];
    }
    
    //通过dispatch_group 管理多个请求
    dispatch_queue_t dispatchQueue = dispatch_queue_create("uploadImageQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    for (int i = 0; i < images.count; i++) {
        
        HttpModel *model = [CC_HttpHelper.shared commonModel:nil url:url params:paramsDic configure:tempConfigure type:CCHttpTaskTypeImage];
        model.forbiddenEncrypt = YES;
        

        NSMutableURLRequest *urlReq = [CC_HttpHelper.shared requestWithUrl:model.requestDomain andParamters:model.requestParamsStr model:model configure:tempConfigure type:CCHttpTaskTypeImage];
        urlReq = [self recaculateImageDatas:images[i] paramsStr:model.requestParamsStr request:urlReq];
        
        model.requestUrl = [NSString stringWithFormat:@"%@?%@",urlReq.URL.absoluteString,model.requestParamsStr];
        
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
            dispatch_group_enter(dispatchGroup);
            [self requestSingleImageWithSession:session executorDelegate:executorDelegate request:urlReq index:i+1 reConnectTimes:times model:model finishBlock:^(NSString *error, HttpModel *resModel) {
                if (error) {
                    [errorResultArr addObject:resModel];
                }
                [resModelResultArr replaceObjectAtIndex:resModel.index withObject:resModel];
                dispatch_group_leave(dispatchGroup);
            }];
        });
    }
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        CCLOG(@"所有图片上传完成-----end");
        [session finishTasksAndInvalidate];
        executorDelegate.finishUploadImagesBlock(errorResultArr, resModelResultArr);
    });
}

- (void)requestSingleImageWithSession:(NSURLSession *)session executorDelegate:(CC_HttpTask *)executorDelegate request:(NSURLRequest *)request index:(NSUInteger)index reConnectTimes:(NSInteger)reConnectTimes model:(HttpModel*)model finishBlock:(void (^)(NSString *, HttpModel *))block{
    
    executorDelegate.finishBlock = block; // 绑定执行完成时的block
    
    __block NSInteger reTryTimes = reConnectTimes;
    __weak __typeof(self)weakSelf = self;
    
    model.index = index - 1;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __strong __typeof(self)strongSelf = weakSelf;
        if (error) {
            //重新发起请求
            if (reTryTimes == 0) {
                [model parsingError:error];
                executorDelegate.finishBlock(model.errorMsgStr, model);
            }else{
                CCLOG(@"上传第%lu张图片失败-----重连还剩%ld次", (unsigned long)index, (long)reTryTimes);
                reTryTimes--;
                [strongSelf requestSingleImageWithSession:session executorDelegate:executorDelegate request:request index:index reConnectTimes:reTryTimes model:model finishBlock:block];
            }
        }else{
            [model parsingResult:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
            if (model.errorMsgStr) {
                CCLOG(@"上传第%lu张图片失败-----\n requestStr:%@\n result:%@", (unsigned long)index, model.requestUrl, model.resultDic);
            }else{
                CCLOG(@"上传第%lu张图片成功-----\n requestStr:%@\n result:%@", (unsigned long)index, model.requestUrl, model.resultDic);
            }
            executorDelegate.finishBlock(model.errorMsgStr, model);
        }
    }];
    [task resume];
}

- (NSMutableURLRequest *)recaculateImageDatas:(id)image paramsStr:(NSString *)paramsStr request:(NSMutableURLRequest *)urlReq{
    
    NSArray *paraArr=[paramsStr componentsSeparatedByString:@"&"];
    NSMutableArray *dataArr=@[].mutableCopy;
    for (NSString *str in paraArr) {
        //index=0为key,index=1为value
        NSString *newStr = [str stringByRemovingPercentEncoding];
        [dataArr addObject:[newStr componentsSeparatedByString:@"="]];
    }
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary = [[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary = [[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http body的字符串
    NSMutableString *body = [[NSMutableString alloc]init];
    //参数的集合的所有key的集合
//    NSArray *keys= [paramsDic allKeys];
    //遍历keys
    for(int i = 0; i < [dataArr count]; i++) {
        //得到当前key
        NSString *key = [dataArr objectAtIndex:i][0];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[dataArr objectAtIndex:i][1]];
    }
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData = [NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    //要上传的图片--得到图片的data
    NSData *data;
    if (tempCompressionType == CCCompressionTypeScale) {
        //指定比例
        data = UIImageJPEGRepresentation((UIImage *)image, tempScalePercent);
    }else if (tempCompressionType == CCCompressionTypeSize){
        //指定大小
        data = [(UIImage *)image cc_compressWithMaxLength:tempScaleSize*1000*1000];
    }else{
        data = (NSData *)image;
    }
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
    NSString *end = [[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [urlReq setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [urlReq setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [urlReq setHTTPBody:myRequestData];
    
    return urlReq;
}

@end
