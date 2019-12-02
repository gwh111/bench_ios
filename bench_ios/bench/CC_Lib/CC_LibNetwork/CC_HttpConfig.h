//
//  CC_HTTPConfigure.h
//  testbenchios
//
//  Created by gwh on 2019/8/9.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_HttpConfig : NSObject

// 和服务端交互的方式
typedef NS_ENUM(NSUInteger, CCHttpRequestType) {
    CCHttpRequestTypeNormal,// 服务端使用service字段判断服务
    CCHttpRequestTypeMock,// 线下使用 httphead 的 Web-Exterface-RequestPath 字段f判断服务，线上使用 url 的路径判断服务
};

@property(nonatomic,assign) CCHttpRequestType httpRequestType;

@property(nonatomic,retain) NSMutableDictionary *httpHeaderFields;

// 设置一次 额外的 每个接口都要发送的数据
// 可放入 比如 authedUserId
@property(nonatomic,retain) NSMutableDictionary *extreParameter;

// 设置登录后拿到的signKey
@property(nonatomic,retain) NSString *signKeyStr;

// 访问ip
@property(nonatomic,retain) NSString *scopeIp;

// 超时时间
@property(nonatomic,assign) NSTimeInterval httpTimeoutInterval;

@property(nonatomic,assign) BOOL forbiddenTimestamp;

// 设置通用响应结果特殊处理回调集合
@property(nonatomic,retain) NSMutableDictionary *logicBlockMap;

// 加密请求的code 如每次从本地读取会影响速度 故存到内存之中
// AESCode是给用户自己使用 每人的AESCode是不同的 即使反编译暴露也是自己的手机
@property(nonatomic,retain) NSString *AESCode;

// http头部加密标识
@property(nonatomic,assign) BOOL headerEncrypt;

// 设置要加密的域名
// 必须添加 CC_HttpEncryption文件
@property(nonatomic,retain) NSString *encryptDomain;

// 忽略 mock 系统给的错误
@property(nonatomic,assign) BOOL ignoreMockError;

- (void)start;

- (void)httpHeaderAdd:(NSString *)key value:(id)value;
- (void)httpHeaderRemove:(NSString *)key;

// Parameters for each request will append.
- (void)extreDicAdd:(NSString *)key value:(id)value;
- (void)extreDicRemove:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
