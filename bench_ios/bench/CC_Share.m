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

+ (void)getUpdate{
    NSString *currentVersion=@"1.3.93";
    //@"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json"
    NSString *bench_ios_update=[ccs getDefault:@"bench_ios_update"];
    if (bench_ios_update) {
        if ([CC_Logic compareV1:bench_ios_update cutV2:currentVersion]>0) {
            CCLOG(@"bench_ios需要更新%@",bench_ios_update);
            [ccs delay:3 block:^{
                [CC_Notice show:ccstr(@"bench_ios需要更新到v%@",bench_ios_update)];
            }];
        }
        return;
    }
    CC_HttpTask *tempTask=[[CC_HttpTask alloc]init];
    tempTask.httpTimeoutInterval=3;
    ResModel *model=[[ResModel alloc]init];
    model.forbiddenJSONParseError=YES;
    [tempTask get:@"http://d.net/" params:nil model:model finishCallbackBlock:^(NSString *error, ResModel *result) {
        if ([[NSString stringWithFormat:@"%@",result.resultStr] containsString:@"http://d.net"]){
            
            [tempTask get:@"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json" params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
                if (error) {
                    return ;
                }
                NSString *version=result.resultDic[@"version"];
                if ([CC_Logic compareV1:version cutV2:currentVersion]>0) {
                    CCLOG(@"bench_ios需要更新%@",version);
                    [ccs delay:3 block:^{
                        [CC_Notice show:ccstr(@"bench_ios需要更新到v%@",version)];
                    }];
                }
                [ccs saveDefaultKey:@"bench_ios_update" andV:version];
            }];
        }else{
            [ccs saveDefaultKey:@"bench_ios_update" andV:currentVersion];
        }
    }];
    
}

@end

@implementation ccs

+ (NSDictionary *)getBundle{
    return [[NSBundle mainBundle]infoDictionary];
}

+ (NSString *)getBid{
    return [self getBundle][@"CFBundleIdentifier"];
}

+ (NSString *)getVersion{
    return [self getBundle][@"CFBundleShortVersionString"];
}

+ (NSString *)getBundleVersion{
    return [self getBundle][@"CFBundleVersion"];
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

+ (void)saveKeychainName:(NSString *)key str:(NSString *)str{
    [CC_KeyChainStore save:key data:str];
}

+ (NSString *)getKeychainName:(NSString *)str{
    NSString *strUUID = (NSString*)[CC_KeyChainStore load:str];
    return strUUID;
}

+ (NSString *)getKeychainUUID{
    NSString *strUUID = (NSString*)[CC_KeyChainStore load:[self getBid]];
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
        //生成一个uuid的方法
        strUUID = [NSUUID UUID].UUIDString;
        
        //将该uuid保存到keychain
        [self saveKeychainName:[self getBid] str:strUUID];
        
    }
    return strUUID;
}

+ (NSString *)getFileWithPath:(NSString *)name andType:(NSString *)type{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSString *file=[NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil];
    return file;
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
+ (NSArray *)getLocalFileListWithDocumentName:(NSString *)name withType:(NSString *)type{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *path=[documentsDirectory stringByAppendingString:@"/"];
    path=[path stringByAppendingString:name];
    NSArray *fileList=[[NSFileManager defaultManager] subpathsAtPath:path];
    if (type) {
        NSMutableArray *fileMutList=[[NSMutableArray alloc]init];
        for (int i=0; i<fileList.count; i++) {
            NSString *file=fileList[i];
            if ([file hasSuffix:type]) {
                [fileMutList addObject:file];
            }
        }
        return fileMutList;
    }
    return fileList;
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
            CCLOG(@"dele success");
        }else {
            CCLOG(@"dele fail");
        }
    }
}
//保存到本地
+ (void)saveLocalPlistNamed:(NSString *)name{
    if (!name) {
        CCLOG(@"没有name");
        return;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (!setupDic) {
        if ([self getPlistDic:name]) {
            CCLOG(@"初始化新的1");
            setupDic=[[NSMutableDictionary alloc]initWithDictionary:[self getPlistDic:name]];
        }else{
            CCLOG(@"初始化新的2");
            setupDic=[[NSMutableDictionary alloc]init];
        }
    }
    if (setupDic) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
        [setupDic writeToFile:fileName atomically:YES];
    }else{
        CCLOG(@"name 不存在");
    }
}
//通过键值获取设置的具体属性
+ (id)getLocalKeyNamed:(NSString *)name andKey:(NSString *)key{
    if (!name) {
        CCLOG(@"没有name");
        return nil;
    }
    if (!key) {
        CCLOG(@"没有key");
        return nil;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (setupDic[key]) {
        return setupDic[key];
    }
    CCLOG(@"获取失败");
    return nil;
}

+ (NSString *)saveLocalFile:(id)data withPath:(NSString *)name andType:(NSString *)type{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath=documentsDirectory;
    
    NSString *fileName;
    if (type.length>0) {
        fileName=[NSString stringWithFormat:@"%@/%@.%@",dataFilePath,name,type];
    }else{
        fileName=[NSString stringWithFormat:@"%@/%@",dataFilePath,name];
    }
    
    if ([name containsString:@"/"]) {
        NSArray *tempArr=[name componentsSeparatedByString:@"/"];
        NSString *lastName=[tempArr lastObject];
        name=[name stringByReplacingOccurrencesOfString:lastName withString:@""];
        dataFilePath=[dataFilePath stringByAppendingString:@"/"];
        dataFilePath=[dataFilePath stringByAppendingString:name];
    }
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success=[data writeToFile:fileName atomically:YES];
    if (success) {
        return fileName;
    }else{
        CCLOG(@"保存失败");
        return nil;
    }
}

+ (NSString *)getLocalFileWithPath:(NSString *)name andType:(NSString *)type{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *fileName;
    if (type.length>0) {
        fileName=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name,type]];
    }else{
        fileName=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    }
    NSString *file=[NSString stringWithContentsOfFile:fileName usedEncoding:nil error:nil];
    return file;
}

+ (NSString *)saveLocalFile:(id)data toPath:(NSString *)path withName:(NSString *)name andType:(NSString *)type{
    if (!data) {
        return nil;
    }
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *dataFilePath=documentsDirectory;
    if (path) {
        dataFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    }
    NSString *fileName;
    if ([path hasSuffix:@"/"]) {
        fileName=[NSString stringWithFormat:@"%@%@.%@",dataFilePath,name,type];
    }else{
        fileName=[NSString stringWithFormat:@"%@/%@.%@",dataFilePath,name,type];
    }
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success=[data writeToFile:fileName atomically:YES];
    if (success) {
        
        return fileName;
    }else{
        
        CCLOG(@"保存失败");
        return nil;
    }
    return @"";
}

//设置字典数据
+ (NSString *)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value{
    if (!name) {
        CCLOG(@"没有name");
        return nil;
    }
    if (!key) {
        CCLOG(@"没有key");
        return nil;
    }
    if (!value) {
        CCLOG(@"没有value");
        return nil;
    }
    NSMutableDictionary *setupDic=[self getLocalPlistNamed:name];
    if (!setupDic) {
        if ([self getPlistDic:name]) {
            CCLOG(@"初始化新的1");
            setupDic=[[NSMutableDictionary alloc]initWithDictionary:[self getPlistDic:name]];
        }else{
            CCLOG(@"初始化新的2");
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
            
            CCLOG(@"保存失败");
            return nil;
        }
    }else{
        CCLOG(@"name 不存在");
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
    NSData *decodeData = [CC_AES decryptData:oriData key:aeskey];
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
        return;
    }
    NSData *data =[v dataUsingEncoding:NSUTF8StringEncoding];
    NSData *aeskey = [aesk dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodeData3 = [CC_AES encryptData:data key:aeskey];
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

+ (BOOL)isEmpty:(id)obj{
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        
        NSString *trimStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([trimStr isEqualToString:@""] || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"<nil>"]) {
            return YES;
        }
    } else if ([obj respondsToSelector:@selector(length)]
               && [(NSData *)obj length] == 0) {
        return YES;
    } else if ([obj respondsToSelector:@selector(count)]
               && [(NSArray *)obj count] == 0) {
        return YES;
    }
    return NO;
    
}

@end
