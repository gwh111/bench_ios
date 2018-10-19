//
//  CC_Share.m
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Share.h"
#import "CC_KeyChainStore.h"

@implementation CC_Share

static CC_Share *userManager=nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[CC_Share alloc]init];
    });
    return userManager;
}

@end

@implementation ccs

+ (NSDictionary *)getBundle{
    return [[NSBundle mainBundle]infoDictionary];
}

+ (NSString *)getBid{
    return [[NSBundle mainBundle]infoDictionary][@"CFBundleIdentifier"];
}

+ (NSString *)getVersion{
    return [[NSBundle mainBundle]infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString *)getSandboxPath{
    NSString *path=[NSString stringWithFormat:@"%@", NSHomeDirectory()];
    CCLOG(@"%@",path);
    return path;
}

+ (NSArray *)getPathsOfType:(NSString *)type inDirectory:(NSString *)directory{
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:type inDirectory:directory];
    return paths;
}

+(void)saveKeychainName:(NSString *)key str:(NSString *)str{
    [CC_KeyChainStore save:key data:str];
}

+(NSString *)getKeychainName:(NSString *)str{
    NSString *strUUID = (NSString*)[CC_KeyChainStore load:str];
    return strUUID;
}

+ (NSString *)getPlistStr:(NSString *)name{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath) {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSString *str=[[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    if (str) {
        return str;
    }
    CCLOG(@"读取plist失败");
    return nil;
}
+ (NSDictionary *)getPlistDic:(NSString *)name{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    if (!plistPath) {
        plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    if (data) {
        return data;
    }
    CCLOG(@"读取plist失败");
    return nil;
}
+ (NSMutableDictionary *)getLocalPlistNamed:(NSString *)name{
    if (!name) {
        CCLOG(@"没有name");
        return nil;
    }
    //读取本地沙盒中的数据
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    //判断路径是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        NSMutableDictionary *setupDic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
        return setupDic;
    }
    CCLOG(@"读取失败%@",name);
    return nil;
}

+ (void)removeLocalPlistNamed:(NSString *)name{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        return ;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
    }
}
//保存到本地
+ (void)saveLocalPlistNamed:(NSString *)name{
    if (!name) {
        NSLog(@"没有name");
        return;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (!setupDic) {
        if ([self getPlistDic:name]) {
            NSLog(@"初始化新的1");
            setupDic=[[NSMutableDictionary alloc]initWithDictionary:[self getPlistDic:name]];
        }else{
            NSLog(@"初始化新的2");
            setupDic=[[NSMutableDictionary alloc]init];
        }
    }
    if (setupDic) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
        [setupDic writeToFile:fileName atomically:YES];
    }else{
        NSLog(@"name 不存在");
    }
}
//通过键值获取设置的具体属性
+ (id)getLocalKeyNamed:(NSString *)name andKey:(NSString *)key{
    if (!name) {
        NSLog(@"没有name");
        return nil;
    }
    if (!key) {
        NSLog(@"没有key");
        return nil;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (setupDic[key]) {
        return setupDic[key];
    }
    CCLOG(@"获取失败");
    return nil;
}

+ (NSString *)saveLocalDic:(NSDictionary *)dic toPath:(NSString *)path name:(NSString *)name{
    if (!dic) {
        NSLog(@"没有dic");
        return nil;
    }
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath=documentsDirectory;
    if (path) {
        dataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    }
    NSString *fileName=[NSString stringWithFormat:@"%@/%@.plist",dataFilePath,name];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success=[dic writeToFile:fileName atomically:YES];
    if (success) {
        
        return fileName;
    }else{
        
        NSLog(@"保存失败");
        return nil;
    }
    return @"";
}

//设置字典数据
+ (NSString *)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value{
    if (!name) {
        NSLog(@"没有name");
        return nil;
    }
    if (!key) {
        NSLog(@"没有key");
        return nil;
    }
    if (!value) {
        NSLog(@"没有value");
        return nil;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (!setupDic) {
        if ([self getPlistDic:name]) {
            NSLog(@"初始化新的1");
            setupDic=[[NSMutableDictionary alloc]initWithDictionary:[self getPlistDic:name]];
        }else{
            NSLog(@"初始化新的2");
            setupDic=[[NSMutableDictionary alloc]init];
        }
    }
    //    如果字典存在并且数据有效
    [setupDic removeObjectForKey:key];
    [setupDic setObject:value forKey:key];
    if (setupDic) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
        BOOL success=[setupDic writeToFile:fileName atomically:YES];
        if (success) {
            
            return fileName;
        }else{
            
            NSLog(@"保存失败");
            return nil;
        }
    }else{
        NSLog(@"name 不存在");
        return nil;
    }
}

+ (id)getDefault:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}
+ (void)saveDefaultKey:(NSString *)key andV:(id)v{
    if (!key) {
        CCLOG(@"error:key=nil");
        return;
    }
    if (!v) {
        CCLOG(@"error:v=nil");
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
        return;
    }
    [[NSUserDefaults standardUserDefaults]setObject:v forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)getSafeDefault:(NSString *)key{
    NSString *aesk=[CC_Share getInstance].aesKey;
    if (!aesk) {
        CCLOG(@"没有设置加密key 不能使用");
        return nil;
    }
    NSData *oriData=[self getDefault:key];
    if (!oriData) {
        return nil;
    }
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decodeData = [CC_AESEncrypt decryptData:oriData key:aeskey];
    NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeString;
}

+ (void)saveSafeDefaultKey:(NSString *)key andV:(id)v{
    NSString *aesk=[CC_Share getInstance].aesKey;
    if (!aesk) {
        CCLOG(@"没有设置加密key 不能使用");
        return;
    }
    if (!v) {
        [self saveDefaultKey:key andV:nil];
    }
    NSData *data =[v dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData3 = [CC_AESEncrypt encryptData:data key:aeskey];
    [self saveDefaultKey:key andV:encodeData3];
}

NSString *ccstr(NSString *format, ...){
    va_list ap;
    va_start (ap, format);
    //函数名称，读取可变参数的过程其实就是在堆栈中，使用指针,遍历堆栈段中的参数列表,从低地址到高地址一个一个地把参数内容读出来的过程
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    
    return body;
}

+ (NSData *)copyToData:(id)object{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:object];
    return tempArchive;
}

+ (id)dataToObject:(id)data{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (id)copyThis:(id)object{
    NSData *tempArchive = [NSKeyedArchiver archivedDataWithRootObject:object];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

+ (void)gotoThread:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作放在这里
        block();
    });
}

+ (void)gotoMain:(void (^)(void))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 回到主线程进行UI操作
        block();
    });
}

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        block();
    });

}

@end
