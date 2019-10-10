//
//  CC_HttpEncryption.h
//  bench_ios
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_Foundation.h"
#import "CC_HttpTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_HttpEncryption : NSObject
//加密域名
@property (nonatomic, copy) NSString *encryptDomain;

// 准备阶段 需要放在所有接口请求前 在回调后才是准备完毕
// 会有生成AES key、拉取RSA public key、更新服务端秘钥等操作
- (void)prepare:(void (^)(void))block;

// 如果拆分模块 需要拷贝加密逻辑代码到独立的httpTask
- (void)addResponseLogic:(CC_HttpTask *)httpTask;

#pragma mark Selector接口
// 获取密文
// 从CC_HttpTask中发送调用请求获取
+ (NSString *)getCiphertext:(NSMutableDictionary *)paraDic httpTask:(CC_HttpTask *)httpTask;

// 获取解密内容
+ (NSString *)getDecryptText:(NSDictionary *)resultDic;

@end

NS_ASSUME_NONNULL_END
