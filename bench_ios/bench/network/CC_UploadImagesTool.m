//
//  CC_UploadImagesTool.m
//  AFNetworking
//
//  Created by 路飞  on 2019/3/12.
//

#import "CC_UploadImagesTool.h"
#import "CC_Share.h"
#import "CC_FormatDic.h"

typedef NS_ENUM(NSUInteger, CCCompressionType) {
    CCCompressionTypeScale,//指定比例压缩
    CCCompressionTypeSize,//指定大小压缩
};

@interface CC_UploadImagesTool ()

@property (nonatomic, assign) CCCompressionType compressionType;
@property (nonatomic, assign) CGFloat scalePercent;//指定压缩比例
@property (nonatomic, assign) NSUInteger scaleSize;//指定压缩大小
@property (nonatomic, strong) CC_HttpTask* task;

@end

@implementation CC_UploadImagesTool

static CC_UploadImagesTool *instance = nil;
static dispatch_once_t onceToken;

+(instancetype)shareInstance{
    dispatch_once(&onceToken, ^{
        instance = [[CC_UploadImagesTool alloc] init];
    });
    return instance;
}

-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times task:(CC_HttpTask*)task finishBlock:(void (^)(NSArray<ResModel *> *, NSArray<ResModel *> *))uploadImageBlock{
    self.task = task;
    self.scalePercent = imageScale;
    self.compressionType = CCCompressionTypeScale;
    [self uploadImages:images url:url params:paramsDic reConnectTimes:times finishBlock:uploadImageBlock];
}

-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times task:(CC_HttpTask*)task finishBlock:(void (^)(NSArray<ResModel *> * _Nonnull, NSArray<ResModel *> * _Nonnull))uploadImageBlock{
    self.task = task;
    self.scaleSize = imageSize;
    self.compressionType = CCCompressionTypeSize;
    [self uploadImages:images url:url params:paramsDic reConnectTimes:times finishBlock:uploadImageBlock];
}

-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<ResModel *> *, NSArray<ResModel *> *))uploadImageBlock{
    
    NSURL *tempUrl;
    if ([url isKindOfClass:[NSURL class]]) {
        tempUrl=url;
    }else if ([url isKindOfClass:[NSString class]]) {
        tempUrl=[NSURL URLWithString:url];
    }else{
        CCLOG(@"url 不合法");
    }
    
    CC_HttpTask *executorDelegate = [[CC_HttpTask alloc] init];
    executorDelegate.finishUploadImagesCallbackBlock = uploadImageBlock; // 绑定执行完成时的block
    
    //图片判空 若为空 直接返回错误
    if (images.count < 1) {
        ResModel* model=[[ResModel alloc]init];
        model.serviceStr=paramsDic[@"service"];
        model.errorMsgStr = @"上传图片为空";
        executorDelegate.finishUploadImagesCallbackBlock(@[model], @[]);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:executorDelegate delegateQueue:nil];//子线程
    
    //组装参数
    paramsDic = [[NSMutableDictionary alloc]initWithDictionary:paramsDic];
    if ([paramsDic isKindOfClass:[NSDictionary class]]) {
        paramsDic=[[NSMutableDictionary alloc]initWithDictionary:paramsDic];
    }
    if (![paramsDic objectForKey:@"service"]) {
        [paramsDic setObject:@"IMAGE_TEMP_UPLOAD" forKey:@"service"];
    }
    if (self.task.extreDic) {
        NSArray *keys=[self.task.extreDic allKeys];
        for (int i=0; i<keys.count; i++) {
            [paramsDic setObject:self.task.extreDic[keys[i]] forKey:keys[i]];
        }
    }
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]*1000];
    [paramsDic setObject:timeSp forKey:@"timestamp"];
    
    NSString *paraString=[CC_FormatDic getSignFormatStringWithDic:paramsDic andMD5Key:self.task.signKeyStr];
    NSMutableURLRequest *urlReq=[self.task requestWithUrl_post:tempUrl andParamters:paraString];
    
    NSString *signStr = [CC_FormatDic getSignValueWithDic:paramsDic andMD5Key:self.task.signKeyStr];
    [paramsDic setObject:signStr forKey:@"sign"];
    
    //图片请求结果
    __block NSMutableArray* resModelResultArr = [[NSMutableArray alloc]init];
    __block NSMutableArray* errorResultArr = [[NSMutableArray alloc]init];
    
    //通过dispatch_group 管理多个请求
    dispatch_queue_t dispatchQueue = dispatch_queue_create("uploadImageQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    for (int i = 0; i < images.count; i++) {
        
        ResModel* model=[[ResModel alloc]init];
        model.serviceStr=paramsDic[@"service"];
        if (!self.task.signKeyStr) {
            if (model.debug) {
                CCLOG(@"_signKeyStr为空");
            }
        }
        model.requestUrlStr=urlReq.URL.absoluteString;
        model.requestStr=ccstr(@"%@%@",urlReq.URL.absoluteString,paraString);
        
        dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
            dispatch_group_enter(dispatchGroup);
            NSURLRequest* request = [self recaculateImageDatas:images[i] paramsDic:paramsDic request:urlReq];
            
            [self requestSingleImageWithSession:session executorDelegate:executorDelegate request:request index:i+1 reConnectTimes:times model:model finishBlock:^(NSString *error, ResModel *resModel) {
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

-(void)requestSingleImageWithSession:(NSURLSession*)session executorDelegate:(CC_HttpTask *)executorDelegate request:(NSURLRequest*)request index:(int)index reConnectTimes:(NSInteger)reConnectTimes model:(ResModel*)model finishBlock:(void (^)(NSString *, ResModel *))block{
    
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
                CCLOG(@"上传第%d张图片失败-----\n requestStr:%@\n result:%@", index, model.requestStr, model.resultDic);
            }else{
                CCLOG(@"上传第%d张图片成功-----\n requestStr:%@\n result:%@", index, model.requestStr, model.resultDic);
            }
            executorDelegate.finishCallbackBlock(model.errorMsgStr, model);
        }
    }];
    [task resume];
}

-(NSURLRequest*)recaculateImageDatas:(UIImage*)image paramsDic:(NSDictionary*)paramsDic request:(NSMutableURLRequest*)urlReq{
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
    NSData* data;
    if (_compressionType == CCCompressionTypeScale) {
        //指定比例
        data = UIImageJPEGRepresentation(image, _scalePercent);
    }else{
        //指定大小
        data = [CC_UploadImagesTool compressWithMaxLength:_scaleSize*1000*1000 image:image];
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

+(NSData *)compressWithMaxLength:(NSUInteger)maxLength image:(UIImage*)image{
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}
@end
