//
//  CC_CoreCrash.m
//  bench_ios
//
//  Created by gwh on 2020/1/15.
//

#import "CC_CoreCrash.h"
#import "CC_Foundation.h"
#import "CC_Function.h"
#import "CC_SandboxStore.h"

// 我的捕获handler
static NSUncaughtExceptionHandler cc_exceptionHandler;
static NSUncaughtExceptionHandler *oldhandler;

@implementation CC_CoreCrash

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

// 注册
- (void)setupUncaughtExceptionHandler {
    
    // 设置异常捕获 bench的monitor会定期检查是否被其他库比如bugly替换
    if(NSGetUncaughtExceptionHandler() != cc_exceptionHandler) {

        oldhandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(&cc_exceptionHandler);
    }
    
}

// 注册回原有的
void releaseUncaughtExceptionHandler() {
    NSSetUncaughtExceptionHandler(oldhandler);
}

void cc_exceptionHandler(NSException *exception) {
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    CCLOG(@"%@", exceptionInfo);

    // 保存崩溃日志
    [CC_CoreCrash.shared saveCrashLog:exceptionInfo document:@"Crash"];
    
    // 注册回之前的handler
    releaseUncaughtExceptionHandler();
}

- (void)saveCrashLog:(NSString *)log document:(NSString *)document {

    NSLock *lock = NSLock.new;
    [lock lock];
    
    CC_SandboxStore *sandbox = CC_SandboxStore.sandbox;
    [sandbox createDocumentsDocWithName:document];
    NSArray *list = [sandbox documentsDirectoryFilesWithPath:document type:@"log"];
    if (list.count > 10) {
        // 找到最久的5条删除
        NSMutableArray *sortArr = [NSMutableArray arrayWithArray:list];
        sortArr = [CC_Array cc_sortChineseArr:sortArr depthArr:nil];
        for (int i = 0; i < 5; i++) {
            NSString *name = [NSString stringWithFormat:@"%@/%@",document,sortArr[i]];
            [sandbox deleteDocumentsFileWithName:name];
        }
    }
    NSDate *date = NSDate.cc_localDate;
    NSString *dateStr = [NSString stringWithFormat:@"%@",date];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@" +0000" withString:@""];
    NSString *savePath = [NSString stringWithFormat:@"%@/%@.log",document,dateStr];
    [sandbox saveToDocumentsWithData:log toPath:savePath type:nil];
    
    CCLOG(@"%@",sandbox.documentsPath);
    [lock unlock];
}

- (void)addWarningStackSymbols:(NSArray *)stackSymbols {
    
    [self addWarningStackSymbols:stackSymbols info:nil];
}

- (void)addWarningStackSymbols:(NSArray *)stackSymbols info:(NSString *)info {

    #ifdef DEBUG
        NSLog(@"%@",stackSymbols);
        if (!_ignoreCrashWarning) {
            CCLOGAssert()
        }
    #endif
    
    NSString *log = [NSString stringWithFormat:@"%@ %@",info?info:@"",stackSymbols];
    [self saveCrashLog:log document:@"CrashWarning"];
}

- (void)addCrashStackSymbols:(NSArray *)stackSymbols {
    
}

@end
