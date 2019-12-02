//
//  CC_HttpResponseModel.h
//  bench_ios
//
//  Created by gwh on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_LibStorage.h"

@interface HttpModel : NSObject

// 在线下debug配置1，错误会弹窗提示打印，会根据服务名缓存上一次成功的数据，会记录成功的请求列表
@property(nonatomic,assign) BOOL debug;

// 图片上传时需要用到每个请求的索引
@property (nonatomic, assign) NSUInteger index;

// 请求接口的服务名
@property(nonatomic,retain) NSString *service;

// 请求的头、域名
@property(nonatomic,retain) NSURL *requestDomain;

// 完整的请求链接
@property(nonatomic,retain) NSString *requestUrl;

// 完整的请求内容
@property(nonatomic,retain) NSDictionary *requestParams;

// 完整的请求内容
@property(nonatomic,retain) NSString *requestParamsStr;

// 响应的字符串
@property(nonatomic,retain) NSString *resultStr;

// 响应的json字符串装换成字典
@property(nonatomic,retain) NSDictionary *resultDic;

// 英文错误
@property(nonatomic,retain) NSString *errorNameStr;

// 中文错误
@property(nonatomic,retain) NSString *errorMsgStr;

// 网络环境的错误
@property(nonatomic,retain) NSError *networkError;

// 响应时间显示格式
@property(nonatomic,retain) NSString *responseDateFormatStr;

// 响应的时间
// Thu, 19 Apr 2018 02:18:39 GMT
@property(nonatomic,retain) NSDate *responseDate;

// 响应的本地时间
@property(nonatomic,retain) NSDate *responseLocalDate;

// json解析失败
@property(nonatomic,assign) int parseFail;

// http头部加密标识
@property(nonatomic,assign) BOOL headerEncrypt;

#pragma mark open property. Set property outside.

// 单次请求的超时设置
@property(nonatomic,assign) BOOL timeoutInterval;
// 当前请求不加密 即使默认全局设置了加密
@property(nonatomic,assign) BOOL forbiddenEncrypt;

// 响应数据不一定是json格式，如果YES，对不是json的数据不报错
@property(nonatomic,assign) BOOL forbiddenJSONParseError;

// mock 系统调用参数
// 路径 服务名
@property(nonatomic,retain) NSString *mockRequestPath;

// 应用代码 不能为空，应用的代码，如app.test.web.base
@property(nonatomic,retain) NSString *mockAppCode;

// 源码版本 不能为空，主干默认为1.0，分支则根据项目的源码版本来传递，比如：1.2.20190628.626-SNAPSHOT
@property(nonatomic,retain) NSString *mockSourceVersion;

// 接口版本
@property(nonatomic,retain) NSString *mockExterfaceVersion;

- (void)parsingError:(NSError *)error;
- (void)parsingResult:(NSString *)resultStr;

@end
