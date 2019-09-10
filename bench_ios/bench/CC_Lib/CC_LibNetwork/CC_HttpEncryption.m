//
//  CC_HttpEncryption.m
//  bench_ios
//
//  Created by gwh on 2019/4/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_HttpEncryption.h"
#import "CC_LibSecurity.h"

@interface  CC_HttpEncryption(){
    NSString *publicKey;
}

@end

@implementation CC_HttpEncryption

- (void)addResponseLogic:(CC_HttpTask *)httpTask {
    
    __block CC_HttpTask *blockSelf = httpTask;
    [httpTask addResponseLogic:@"ACCESS_INTERFACE_NEED_ENCRYPT" logicStr:@"response,error,name=ACCESS_INTERFACE_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //访问接口需要加密
        blockSelf.configure.headerEncrypt = NO;
        [self prepare:^{
            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
    [httpTask addResponseLogic:@"ACCESS_INTERFACE_NOT_NEED_ENCRYPT" logicStr:@"response,error,name=ACCESS_INTERFACE_NOT_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //访问接口不需加密
        blockSelf.configure.headerEncrypt = NO;
        [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
    }];
    [httpTask addResponseLogic:@"PRESENT_ACCESS_INTERFACE_NOT_NEED_ENCRYPT" logicStr:@"response,error,name=PRESENT_ACCESS_INTERFACE_NOT_NEED_ENCRYPT" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //当前接口不需加密
        HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
        model.forbiddenEncrypt = YES;
        [blockSelf post:result.requestDomain params:result.requestParams model:model finishBlock:finishCallbackBlock];
    }];
    [httpTask addResponseLogic:@"INTERFACE_DECRYPT_FAILED" logicStr:@"response,error,name=INTERFACE_DECRYPT_FAILED" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //接口解密错误，则请求UUID和加密秘钥的更新接口
        blockSelf.configure.headerEncrypt = NO;
        [self updateAESKey:^(BOOL success) {
            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
    [httpTask addResponseLogic:@"RSA_DECRYPT_FAILED" logicStr:@"response,error,name=RSA_DECRYPT_FAILED" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //接口RSA解密错误，则重新请求获取公钥接口
        blockSelf.configure.headerEncrypt = NO;
        [self prepare:^{
            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
    [httpTask addResponseLogic:@"AES_DECRYPT_SYSTEM_ERROR" logicStr:@"response,error,name=AES_DECRYPT_SYSTEM_ERROR" stop:YES popOnce:YES logicBlock:^(HttpModel *result, void (^finishCallbackBlock)(NSString *error, HttpModel *result)) {
        //aes加密错误
        blockSelf.configure.headerEncrypt = NO;
        [self updateAESKey:^(BOOL success) {
            [blockSelf post:result.requestDomain params:result.requestParams model:nil finishBlock:finishCallbackBlock];
        }];
    }];
}

- (void)prepare:(void (^)(void))block {
    
    [self addResponseLogic:[CC_HttpTask shared]];
    
    BOOL hasPrepared = NO;
    NSString *aesCode;
    if ([CC_DefaultStore cc_safeDefault:@"randCode"]) {
        aesCode = [CC_DefaultStore cc_safeDefault:@"randCode"];
        hasPrepared = YES;
    }else{
        aesCode = [self getRandCode];
        [CC_DefaultStore cc_saveSafeDefault:@"randCode" value:aesCode];
    }
    [CC_HttpTask shared].configure.AESCode = aesCode;
    
    if (hasPrepared) {
        [CC_HttpTask shared].configure.headerEncrypt=YES;
        block();
        return;
    }
    
    [self getPublicKey:^(BOOL success) {
        if (success) {
            [self updateAESKey:^(BOOL success) {
                if (success) {
                    CCLOG(@"updateAESKey success!!!");
                    block();
                }else{
                    [CC_CoreThread.shared cc_delay:1 block:^{
                        [self prepare:block];
                    }];
                }
            }];
        }else{
            [CC_CoreThread.shared cc_delay:1 block:^{
                [self prepare:block];
            }];
        }
    }];
}

- (void)getPublicKey:(void (^)(BOOL success))block {
    [[CC_HttpTask shared] post:[CC_HttpTask shared].configure.encryptDomain params:@{@"service":@"CLIENT_KEY_DOWNLOAD"} model:nil finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            [CC_DefaultStore cc_saveSafeDefault:@"randCode" value:nil];
            block(NO);
            return;
        }
        self->publicKey = result.resultDic[@"response"][@"publicKey"];
        block(YES);
    }];
}

- (void)updateAESKey:(void (^)(BOOL success))block {
    NSString *uuid = [CC_KeyChainStore cc_keychainUUID];
    CCLOG(@"updateAESKey %@ %lu",uuid,(unsigned long)uuid.length);
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timeSp = [CC_HttpEncryption polishingStr:timeSp];
    
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    
    NSString *encStr = [NSString stringWithFormat:@"%@%@",uuid,aesCode];
    NSString *rsaStr = [CC_RSA cc_encryptStr:encStr publicKey:publicKey];
    
    NSDictionary *paraDic = @{@"service":@"AES_SERCRET_KEY_UPDATE",
                            @"ciphertext":rsaStr
                            };
    
    [[CC_HttpTask shared]post:[CC_HttpTask shared].configure.encryptDomain params:paraDic model:nil finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            [CC_DefaultStore cc_saveSafeDefault:@"randCode" value:nil];
            block(NO);
            return;
        }
        [CC_HttpTask shared].configure.headerEncrypt = YES;
        block(YES);
    }];
}

+ (NSString *)getCiphertext:(NSMutableDictionary *)paraDic httpTask:(CC_HttpTask *)httpTask {
    if (!paraDic) {
        return nil;
    }
    NSString *ciphertext;
    
    NSString *uuid;
    if ([CC_DefaultStore cc_default:@"uuid"]) {
        uuid = [CC_DefaultStore cc_default:@"uuid"];
    }else{
        uuid = [CC_KeyChainStore cc_keychainUUID];
        [CC_DefaultStore cc_saveDefault:@"uuid" value:uuid];
    }
    NSData *uuidData = [uuid cc_convertToUTF8data];
    
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f", [datenow timeIntervalSince1970]];
    timeSp=[self polishingStr:timeSp];
    [paraDic setObject:timeSp forKey:@"timestamp"];
    
    NSString *paraStr = [CC_String cc_MD5SignWithDic:paraDic andMD5Key:httpTask.configure.signKeyStr];
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    if (aesCode.length <= 0) {
        CCLOG(@"get aesCode fail!");
        return @"";
    }
    NSData *aesdata = [CC_AES cc_encryptWithKey:aesCode iv:timeSp data:[paraStr cc_convertToUTF8data]];
    
    NSMutableData *mutData = [[NSMutableData alloc]init];
    [mutData appendData:[CC_Function cc_dataWithInt:36]];//uuid length
    [mutData appendData:uuidData];//uuid
    [mutData appendData:[CC_Function cc_dataWithInt:(int)aesdata.length]];//code length
    [mutData appendData:aesdata];//code
    [mutData appendData:[CC_Function cc_dataWithInt:(int)timeSp.length]];//time length
    [mutData appendData:[timeSp cc_convertToUTF8data]];//time
    
    NSData *data = [NSData dataWithData:mutData];
    ciphertext = [data cc_convertToBase64String];
    
    return ciphertext;
}

+ (NSString *)getDecryptText:(NSDictionary *)resultDic {
    
    NSString *ciphertext = resultDic[@"response"][@"ciphertext"];
    if (!ciphertext) {
        return [CC_Function cc_stringWithJson:resultDic];
    }
    NSData *ciphertextdata = [ciphertext cc_convertToBase64data];
    
    NSString *nowTimestamp = [NSString stringWithFormat:@"%@",resultDic[@"response"][@"nowTimestamp"]];
    NSString *aesCode = [CC_HttpTask shared].configure.AESCode;
    nowTimestamp = [self polishingStr:nowTimestamp];
    NSData *aesdata = [CC_AES cc_decryptWithKey:aesCode iv:nowTimestamp data:ciphertextdata];
    
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
        NSMutableString* newStr = oldStr.mutableCopy;
        
        for (NSInteger i = length - 1; i >= (length*2-16); i --) {
            unichar character = [oldStr characterAtIndex:i];
            [newStr appendFormat:@"%c",character];
        }
        return [newStr copy];
    }
}

- (NSString *)getRandCode {
    NSArray *changeArr=[[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:5];
    NSMutableString *changeStr = [[NSMutableString alloc]initWithCapacity:16];
    for(int i =0; i<16; i++) {
        NSInteger index = arc4random()%([changeArr count]);
        getStr = changeArr[index];
        changeStr = (NSMutableString *)[changeStr stringByAppendingString:getStr];
    }
    return changeStr;
}

@end
