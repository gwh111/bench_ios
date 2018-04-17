//
//  CC_Share.m
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Share.h"

@implementation CC_Share

static CC_Share *userManager=nil;
static dispatch_once_t onceToken;

+ (instancetype)shareInstance{
    dispatch_once(&onceToken, ^{
        userManager=[[CC_Share alloc]init];
    });
    return userManager;
}

@end

@implementation ccs

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
    NSLog(@"获取失败");
    return nil;
}

//设置字典数据
+ (void)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value{
    if (!name) {
        NSLog(@"没有name");
        return;
    }
    if (!key) {
        NSLog(@"没有key");
        return;
    }
    if (!value) {
        NSLog(@"没有value");
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
    //    如果字典存在并且数据有效
    [setupDic removeObjectForKey:key];
    [setupDic setObject:value forKey:key];
    if (setupDic) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *fileName = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
        [setupDic writeToFile:fileName atomically:YES];
    }else{
        NSLog(@"name 不存在");
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
}

NSString *ccstr(NSString *format, ...){
    va_list ap;
    va_start (ap, format);
    //函数名称，读取可变参数的过程其实就是在堆栈中，使用指针,遍历堆栈段中的参数列表,从低地址到高地址一个一个地把参数内容读出来的过程
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    
    return body;
}

@end
