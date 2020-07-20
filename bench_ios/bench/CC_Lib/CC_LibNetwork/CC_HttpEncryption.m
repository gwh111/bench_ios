//
//  CC_HttpEncryption.m
//  bench_ios
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_HttpEncryption.h"
#import "CC_LibSecurity.h"
#import "ccs.h"

@interface  CC_HttpEncryption()

@property (nonatomic, copy) NSString *publicKey;

@end

@implementation CC_HttpEncryption

- (void)addResponseLogic:(CC_HttpTask *)httpTask {
    
    __block CC_HttpTask *blockSelf = httpTask;
//    [httpTask addResponseLogic:@"ACCESS_INTERFACE_NEED_ENCRYPT" logicStr:@"response,error,name=ACCESS_INTERFACE_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //访问接口需要加密
//        blockSelf.configure.headerEncrypt = NO;
//        [CC_DefaultStore saveSafeDefault:@"publicKey" value:nil];
//        [self prepare:^{
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
//        }];
//    }];
//    [httpTask addResponseLogic:@"ACCESS_INTERFACE_NOT_NEED_ENCRYPT" logicStr:@"response,error,name=ACCESS_INTERFACE_NOT_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //访问接口不需加密
//        blockSelf.configure.headerEncrypt = NO;
//        [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
//    }];
//    [httpTask addResponseLogic:@"PRESENT_ACCESS_INTERFACE_NOT_NEED_ENCRYPT" logicStr:@"response,error,name=PRESENT_ACCESS_INTERFACE_NOT_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //当前接口不需加密
//        HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
//        model.forbiddenEncrypt = YES;
//        [blockSelf post:result.requestDomain params:result.requestParams model:model finishBlock:finishCallbackBlock];
//    }];
//    [httpTask addResponseLogic:@"INTERFACE_DECRYPT_FAILED" logicStr:@"response,error,name=INTERFACE_DECRYPT_FAILED" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //接口解密错误，则请求UUID和加密秘钥的更新接口
//        blockSelf.configure.headerEncrypt = NO;
//        [self updateAESKey:^(BOOL success) {
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
//        }];
//    }];
//    [httpTask addResponseLogic:@"RSA_DECRYPT_FAILED" logicStr:@"response,error,name=RSA_DECRYPT_FAILED" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //接口RSA解密错误，则重新请求获取公钥接口
//        blockSelf.configure.headerEncrypt = NO;
//        [CC_DefaultStore saveSafeDefault:@"publicKey" value:nil];
//        [self prepare:^{
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
//        }];
//    }];
//    [httpTask addResponseLogic:@"AES_DECRYPT_SYSTEM_ERROR" logicStr:@"response,error,name=AES_DECRYPT_SYSTEM_ERROR" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
//        //aes加密错误
//        blockSelf.configure.headerEncrypt = NO;
//        [self updateAESKey:^(BOOL success) {
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
//        }];
//    }];
    [httpTask addResponseLogic:@"REQUEST_BODY_PARSE_ERROR" logicStr:@"error,name=REQUEST_BODY_PARSE_ERROR" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        blockSelf.configure.headerEncrypt = NO;
        [CC_DefaultStore saveSafeDefault:@"publicKey" value:nil];
        [self prepare:^{
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
    [httpTask addResponseLogic:@"PARAMETER_PARSE_ERROR" logicStr:@"error,name=PARAMETER_PARSE_ERROR" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        blockSelf.configure.headerEncrypt = NO;
        [CC_DefaultStore saveSafeDefault:@"publicKey" value:nil];
        [self prepare:^{
//            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
}

- (void)prepare:(void (^)(void))block {
    
    [self addResponseLogic:[CC_HttpTask shared]];
    
    NSString *aesCode;
    if ([CC_DefaultStore getSafeDefault:@"randCode"]) {
        aesCode = [CC_DefaultStore getSafeDefault:@"randCode"];
    }else{
        aesCode = [self getRandCode];
        [CC_DefaultStore saveSafeDefault:@"randCode" value:aesCode];
    }
    [CC_HttpTask shared].configure.AESCode = aesCode;
    
    [self getPublicKey:^(BOOL success) {
        if (success) {
            [self updateAESKey:^(BOOL success) {
                if (success) {
                    CCLOG(@"updateAESKey success!!!");
                    block();
                }else{
                    [CC_Thread.shared delay:1 block:^{
                        [self prepare:block];
                    }];
                }
            }];
        }else{
            [CC_Thread.shared delay:1 block:^{
                [self prepare:block];
            }];
        }
    }];
}

- (void)getPublicKey:(void (^)(BOOL success))block {
    // http://172.31.0.78/clientKeyDownload.json
    NSString *url = [[CC_HttpTask shared].configure.encryptDomain stringByAppendingString:@"/clientKeyDownload.json"];
    [ccs.httpTask post:url params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            [CC_DefaultStore saveSafeDefault:@"randCode" value:nil];
            block(NO);
            return;
        }
        self.publicKey = result.resultDic[@"key"];
        [CC_DefaultStore saveSafeDefault:@"publicKey" value:self.publicKey];
        block(YES);
    }];
}

- (void)updateAESKey:(void (^)(BOOL success))block {
    // http://172.31.0.78/secretKeyUpdate.json
    NSString *url = [[CC_HttpTask shared].configure.encryptDomain stringByAppendingString:@"/secretKeyUpdate.json"];
    NSString *uuid = [CC_KeyChainStore keychainUUID];
    CCLOG(@"updateAESKey %@ %lu",uuid,(unsigned long)uuid.length);
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timeSp = [CC_HttpEncryption polishingStr:timeSp];
    
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    
    NSString *encStr = [NSString stringWithFormat:@"%@%@",uuid,aesCode];
    NSString *rsaStr = [CC_RSA encryptStr:encStr publicKey:_publicKey];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = rsaStr.cc_convertToUTF8data;
    
    [ccs.httpTask sendRequest:request model:nil finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            [CC_DefaultStore saveSafeDefault:@"randCode" value:nil];
            block(NO);
            return;
        }
        block(YES);
    }];
}

+ (NSDictionary *)configMockCipherHTTPHeader {
    NSMutableDictionary *httpHeader = ccs.mutDictionary;
    NSString *uuid;
    if ([CC_DefaultStore getDefault:@"uuid"]) {
        uuid = [CC_DefaultStore getDefault:@"uuid"];
    }else{
        uuid = [CC_KeyChainStore keychainUUID];
        [CC_DefaultStore saveDefault:@"uuid" value:uuid];
    }
    
    NSDate *datenow = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timestamp = [self polishingStr:timestamp];
    
    [httpHeader cc_setKey:@"timestamp" value:timestamp];
    [httpHeader cc_setKey:@"uuid" value:uuid];
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    if (aesCode.length <= 0) {
        aesCode = [ccs getSafeDefault:@"randCode"];
    }
    
    CC_HttpConfig *config = ccs.httpTask.configure;
    if (config.extreParameter[@"loginKey"]) {
        NSString *userId = config.extreParameter[@"authUserId"];
        NSDictionary *params = @{@"loginKey":config.extreParameter[@"loginKey"],
                                 @"authUserId":userId,
                                 
        };
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSData *aesdata = [CC_AES encryptWithKey:aesCode iv:timestamp data:data];
        NSString *base64Str = [aesdata cc_convertToBase64String];

        [httpHeader cc_setKey:@"token" value:[base64Str cc_convertToUrlString]];
        
    }
    return httpHeader;
}

+ (void)configMockCipherParams:(HttpModel *)model URLRequest:(NSMutableURLRequest *)request {
    if (!model) {
        return;
    }
    NSMutableDictionary *paraDic = model.requestParams.mutableCopy;
    
    NSString *uuid;
    if ([CC_DefaultStore getDefault:@"uuid"]) {
        uuid = [CC_DefaultStore getDefault:@"uuid"];
    }else{
        uuid = [CC_KeyChainStore keychainUUID];
        [CC_DefaultStore saveDefault:@"uuid" value:uuid];
    }
    
    NSDate *datenow = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timestamp = [self polishingStr:timestamp];
    
    [request setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [request setValue:uuid forHTTPHeaderField:@"uuid"];
    
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    if (aesCode.length <= 0) {
        aesCode = [ccs getSafeDefault:@"randCode"];
    }
    
    CC_HttpConfig *config = ccs.httpTask.configure;
    if (config.extreParameter[@"loginKey"]) {
        NSString *userId = config.extreParameter[@"authUserId"];
        NSDictionary *params = @{@"loginKey":config.extreParameter[@"loginKey"],
                                 @"authUserId":userId,
                                 
        };
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSData *aesdata = [CC_AES encryptWithKey:aesCode iv:timestamp data:data];
        NSString *base64Str = [aesdata cc_convertToBase64String];
        
        [request setValue:[base64Str cc_convertToUrlString] forHTTPHeaderField:@"token"];
        
//        NSString *sign = [CC_Tool.shared MD5SignValueWithDic:paraDic andMD5Key:config.signKeyStr];
//        [paraDic cc_setKey:@"sign" value:sign];
    }
    
    model.requestParams = paraDic;
    if (!paraDic) {
        return;
    }

    NSData *data = [NSJSONSerialization dataWithJSONObject:paraDic options:NSJSONWritingPrettyPrinted error:nil];
    if (ccs.httpConfig.headerEncrypt) {

        NSData *aesdata = [CC_AES encryptWithKey:aesCode iv:timestamp data:data];
        request.HTTPBody = aesdata;
    } else {

        request.HTTPBody = data;
    }
    
}

+ (void)configMockParams:(HttpModel *)model URLRequest:(NSMutableURLRequest *)request {
    if (!model) {
        return;
    }
    NSMutableDictionary *paraDic = model.requestParams.mutableCopy;
    NSString *uuid;
    if ([CC_DefaultStore getDefault:@"uuid"]) {
        uuid = [CC_DefaultStore getDefault:@"uuid"];
    }else{
        uuid = [CC_KeyChainStore keychainUUID];
        [CC_DefaultStore saveDefault:@"uuid" value:uuid];
    }
    
    NSDate *datenow = [NSDate date];
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timestamp = [self polishingStr:timestamp];
    
    [request setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [request setValue:uuid forHTTPHeaderField:@"uuid"];
    
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    if (aesCode.length <= 0) {
        aesCode = [ccs getSafeDefault:@"randCode"];
    }
    
    CC_HttpConfig *config = ccs.httpTask.configure;
    if (config.extreParameter[@"loginKey"]) {
        NSString *userId = config.extreParameter[@"authUserId"];
        NSDictionary *params = @{@"loginKey":config.extreParameter[@"loginKey"],
                                 @"authUserId":userId,
                                 
        };
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *base64Str = [data cc_convertToBase64String];
        [request setValue:[base64Str cc_convertToUrlString] forHTTPHeaderField:@"token"];
        
//        NSString *sign = [CC_Tool.shared MD5SignValueWithDic:paraDic andMD5Key:config.signKeyStr];
//        [paraDic cc_setKey:@"sign" value:sign];
    } else {
        return;
    }
    model.requestParams = paraDic;
    if (!paraDic) {
        return;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:paraDic options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data;
}

+ (NSString *)getCiphertext:(NSMutableDictionary *)paraDic httpTask:(CC_HttpTask *)httpTask {
    if (!paraDic) {
        return nil;
    }
    NSString *ciphertext;
    
    NSString *uuid;
    if ([CC_DefaultStore getDefault:@"uuid"]) {
        uuid = [CC_DefaultStore getDefault:@"uuid"];
    }else{
        uuid = [CC_KeyChainStore keychainUUID];
        [CC_DefaultStore saveDefault:@"uuid" value:uuid];
    }
    NSData *uuidData = [uuid cc_convertToUTF8data];
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timeSp = [self polishingStr:timeSp];
    [paraDic setObject:timeSp forKey:@"timestamp"];
    
    NSString *paraStr = [CC_Tool.shared MD5SignWithDic:paraDic andMD5Key:httpTask.configure.signKeyStr];
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    if (aesCode.length <= 0) {
        CCLOG(@"get aesCode fail!");
        return @"";
    }
    NSData *aesdata = [CC_AES encryptWithKey:aesCode iv:timeSp data:[paraStr cc_convertToUTF8data]];
    
    NSMutableData *mutData = [[NSMutableData alloc]init];
    [mutData appendData:[CC_Tool.shared dataWithInt:36]];//uuid length
    [mutData appendData:uuidData];//uuid
    [mutData appendData:[CC_Tool.shared dataWithInt:(int)aesdata.length]];//code length
    [mutData appendData:aesdata];//code
    [mutData appendData:[CC_Tool.shared dataWithInt:(int)timeSp.length]];//time length
    [mutData appendData:[timeSp cc_convertToUTF8data]];//time
    
    NSData *data = [NSData dataWithData:mutData];
    ciphertext = [data cc_convertToBase64String];
    
    return ciphertext;
}

// 获取解密内容
+ (NSString *)getMockDecryptText:(NSData *)data timestamp:(NSString *)timestamp {
    
    NSString *nowTimestamp = timestamp;
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    nowTimestamp = [self polishingStr:nowTimestamp];
    NSData *aesdata = [CC_AES decryptWithKey:aesCode iv:nowTimestamp data:data];
    
    return [aesdata cc_convertToUTF8String];
}

+ (NSString *)getDecryptText:(NSDictionary *)resultDic {
    
    NSString *ciphertext = resultDic[@"response"][@"ciphertext"];
    if (!ciphertext) {
        return [CC_Tool.shared stringWithJson:resultDic];
    }
    NSData *ciphertextdata = [ciphertext cc_convertToBase64data];
    
    NSString *nowTimestamp = [NSString stringWithFormat:@"%@",resultDic[@"response"][@"nowTimestamp"]];
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    nowTimestamp = [self polishingStr:nowTimestamp];
    NSData *aesdata = [CC_AES decryptWithKey:aesCode iv:nowTimestamp data:ciphertextdata];
    
    return [aesdata cc_convertToUTF8String];
}

//转换16位时间戳
+ (NSString *)polishingStr:(NSString *)oldStr {
    NSInteger length = oldStr.length;
    if (length >= 16) {
        return oldStr;
    }else if (length == 0) {
        return @"";
    }else{
        NSMutableString *newStr = oldStr.mutableCopy;
        
        for (NSInteger i = length - 1; i >= (length*2-16); i --) {
            unichar character = [oldStr characterAtIndex:i];
            [newStr appendFormat:@"%c",character];
        }
        return [newStr copy];
    }
}

- (NSString *)getRandCode {
    NSArray *changeArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:5];
    NSMutableString *changeStr = [[NSMutableString alloc]initWithCapacity:16];
    for(int i = 0; i < 16; i++) {
        NSInteger index = arc4random()%([changeArr count]);
        getStr = changeArr[index];
        changeStr = (NSMutableString *)[changeStr stringByAppendingString:getStr];
    }
    return changeStr;
}

@end
