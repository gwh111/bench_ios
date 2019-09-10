//
//  ccs.h
//  testbenchios
//
//  Created by gwh on 2019/8/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_UIKit.h"
#import "CC_LibKit.h"
#import "CC_Macro.h"

@interface ccs : NSObject

+ (void)start;

// Function keyword
// Get can be omitted. Get 'xxx' from its own, without parameter.
// update: action will do modify, append or any other step to decorate or make one thing to a new thing.
// result: compare two things or do calculation.
// action: return void, do as command.
// after "_" is a shot description to describe what this function will do. "to" means make one thing to it. "with" is something used to help make change, it will be omit.

#pragma mark configure
+ (void)configureAppStandard:(NSDictionary *)defaultDic;

// CC_CommonConfig.xcconfig
// CC_ReleaseConfig.xcconfig
// CC_TrunkConfig.xcconfig
// CC_Branch1Config.xcconfig
// ...
// GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
// CCBUILDTAG=0
// #include "CC_CommonConfig.xcconfig"
/** @[@[线上地址1,线上地址2...], @[主干地址1,主干地址2...], @[分支1地址1,分支1地址2...] ...] */
+ (void)configureDomainWithReqGroupList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block;

// 直接配置域名
+ (void)configureDomainWithReqList:(NSArray *)domainReqList block:(void (^)(HttpModel *result))block;

#pragma mark monitor
// 启动监控 默认开启
+ (void)openLaunchMonitor:(BOOL)open;
// 启动监控日志 默认开启
+ (void)openLaunchMonitorLog:(BOOL)open;
// 定期检查 默认开启
+ (void)openPatrolMonitor:(BOOL)open;
// 定期检查日志 默认关闭
+ (void)openPatrolMonitorLog:(BOOL)open;

#pragma mark object
+ (id)convert:(id)obj;
+ (UIApplication *)appApplication;
+ (CC_AppDelegate *)appDelegate;

// cluster
// 类簇的优点：
// 1.可以将抽象基类背后的复杂细节隐藏起来
// 2.程序员不会需要记住各种创建对象的具体类实现，简化了开发成本，提高了开发效率
// 3.便于进行封装和组件化
// 4.减少了if else 这样缺乏扩展性的代码
// 5.增加新功能支持不影响其他代码
+ (NSString *)string:(NSString *)format, ...;
+ (NSMutableString *)mutString;
+ (NSMutableString *)mutString:(NSString *)format, ...;

+ (NSArray *)array:(NSArray *)arr;
+ (NSMutableArray *)mutArray;
+ (NSMutableArray *)mutArray:(NSMutableArray *)arr;

+ (NSDictionary *)dictionary:(NSDictionary *)dic;
+ (NSMutableDictionary *)mutDictionary;
+ (NSMutableDictionary *)mutDictionary:(NSMutableDictionary *)dic;

+ (UIColor *)colorHexA:(NSString *)hex alpha:(float)alpha;
+ (UIColor *)colorRgbA:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

+ (id)model:(Class)class;

#pragma mark CC_UIKit

#define APP_STANDARD(name) [ccs appStandard:name]
#pragma mark function
+ (id)appStandard:(NSString *)name;
+ (float)statusBarHeight;
+ (float)x;
+ (float)y;
+ (float)width;
+ (float)height;
+ (float)safeHeight;
+ (float)relativeHeight:(float)height;
+ (UIFont *)relativeFont:(float)fontSize;
+ (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize;

+ (CC_View *)view;
// create a subclass of 'CC_View'
#define View(class) [ccs view:class]
+ (id)view:(Class)class;

+ (CC_Label *)label;
// create a subclass of 'CC_Label'
#define Label(class) [ccs label:class]
+ (id)label:(Class)class;

+ (CC_Button *)button;
// create a subclass of 'CC_Button'
#define Button(class) [ccs button:class]
+ (id)button:(Class)class;

+ (CC_TextView *)textView;
// create a subclass of 'CC_TextView'
#define TextView(class) [ccs textView:class]
+ (id)textView:(Class)class;

+ (CC_TextField *)textField;
// create a subclass of 'CC_TextField'
#define TextField(class) [ccs textField:class]
+ (id)textField:(Class)class;

+ (CC_ImageView *)imageView;
// create a subclass of 'CC_ImageView'
#define ImageView(class) [ccs imageView:class]
+ (id)imageView:(Class)class;

+ (CC_ScrollView *)scrollView;
// create a subclass of 'CC_ScrollView'
#define ScrollView(class) [ccs scrollView:class]
+ (id)scrollView:(Class)class;

+ (CC_TableView *)tableView;
// create a subclass of 'CC_TableView'
#define TableView(class) [ccs tableView:class]
+ (id)tableView:(Class)class;

#define IMAGE(name) [ccs image:name]
+ (CC_Image *)image:(NSString *)imageName;

+ (CC_Mask *)mask;


+ (CC_Notice *)notice;
+ (void)showNotice:(NSString *)str;
+ (void)showNotice:(NSString *)str atView:(UIView *)view;
+ (void)showNotice:(NSString *)str atView:(UIView *)view delay:(int)delay;

#pragma mark alert
+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block;

+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block;
+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block;

+ (CC_LabelGroup *)labelGroup;

// object
+ (CC_TextAttachment *)textAttachment;
+ (NSAttributedString *)attributedString;
+ (NSMutableAttributedString *)mutAttributedString;

+ (id)viewController:(Class)class;
+ (id)controller:(Class)class;

#pragma mark action
+ (void)pushViewController:(id)vc;
// push to viewController && remove current viewController
+ (void)pushViewController:(id)vc withDismissVisible:(BOOL)dismissVisible;
+ (void)popViewController;
+ (void)popToViewController:(Class)class;
+ (void)pushWebViewControllerWithUrl:(NSString *)urlStr;

#pragma mark CC_LibNetwork
+ (CC_HttpTask *)httpTask;
+ (CC_HttpHelper *)httpHelper;

#pragma mark CC_LibStorage
// keychain
+ (NSString *)keychainKey:(NSString *)name;
+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value;
+ (NSString *)keychainUUID;

// NSUserDefaults
+ (id)defaultKey:(NSString *)key;
+ (void)saveDefaultKey:(NSString *)key value:(id)value;

+ (id)safeDefaultKey:(NSString *)key;
+ (void)saveSafeDefaultKey:(NSString *)key value:(id)value;

// NSBundle
+ (NSString *)appName;
+ (NSString *)appBid;
+ (NSString *)appVersion;
+ (NSString *)appBundleVersion;
+ (NSDictionary *)appBundle;

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name type:(NSString *)type;
+ (NSData *)bundleFileWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;

+ (BOOL)copyBunldFileToSandboxToPath:(NSString *)name type:(NSString *)type;
+ (BOOL)copyBunldPlistToSandboxToPath:(NSString *)name;

// 沙盒 Documents 
+ (NSString *)sandboxPath;
+ (NSArray *)sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type;

+ (NSData *)sandboxFileWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)sandboxPlistWithPath:(NSString *)name;

+ (BOOL)deleteSandboxFileWithName:(NSString *)name;
+ (BOOL)saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type;

#pragma mark CC_CoreThread
+ (void)gotoThread:(void (^)(void))block;
+ (void)gotoMain:(void (^)(void))block;
+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
+ (void)threadGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block;
+ (void)threadBlockFinish:(id)sema;
+ (void)threadBlockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;
+ (void)threadBlockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;

+ (void)delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block;
+ (void)delayStop:(NSString *)key;

#pragma mark CC_CoreTimer
+ (void)timerRegister:(NSString *)name interval:(float)interval block:(void (^)(void))block;
+ (void)timerCancel:(NSString *)name;

+ (NSString *)uniqueNowTimestamp;
+ (NSString *)nowTimeTimestamp;

#pragma mark CC_CoreFoundation
// Init class
+ (id)init:(Class)class;

+ (void)registerAppDelegate:(id)module;
// Shared Instance
+ (id)registerSharedInstance:(id)shared;
+ (id)registerSharedInstance:(id)shared block:(void(^)(void))block;

// data sharing, shared data in app, such as update a model in controller A when you are in controller B
// app共享的数据存储 如在控制器B更新控制器A里的model
+ (id)shared:(NSString *)key;
+ (id)removeShared:(NSString *)key;
+ (id)setShared:(NSString *)key obj:(id)obj;
+ (id)resetShared:(NSString *)key obj:(id)obj;

#pragma mark CC_Function
+ (NSData *)function_dataWithInt:(int)i;

+ (BOOL)function_isEmpty:(id)obj;
+ (BOOL)function_isInstallFromAppStore;
+ (BOOL)function_isJailBreak;

+ (int)function_compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;

+ (NSString *)function_stringWithJson:(id)object;
+ (NSString *)function_formatDate:(NSString *)date nowDate:(NSString *)nowDate;
+ (NSString *)function_formatDate:(NSString *)date nowDate:(NSString *)nowDate formatArr:(NSArray *)formatArr;

+ (NSString *)function_replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace;
+ (NSArray *)function_getHtmlLabel:(NSString *)htmlStr start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd;

+ (NSMutableString *)function_MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;
+ (NSMutableString *)function_MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString;

+ (NSMutableArray *)function_sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr;
+ (NSMutableArray *)function_sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc;
+ (NSMutableArray *)function_mapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap;
+ (NSMutableArray *)function_addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap;

+ (NSTimeInterval)function_compareDate:(id)date1 cut:(id)date2;

+ (NSData *)function_archivedDataWithObject:(id)object;

+ (UIImage *)function_imageWithColor:(UIColor*)color width:(CGFloat)width height:(CGFloat)height;

+ (id)function_unarchivedObjectWithData:(id)data;
+ (id)function_copyObject:(id)object;
+ (id)function_jsonWithString:(NSString *)jsonString;

@end

#define CCUIPackage(VAR) typeof(VAR) item = VAR;
#define CCView       CC_View *anView = [CC_Base.shared cc_init:CC_View.class]; CCUIPackage(anView)
#define CCLabel      CC_Label *oneLabel = [CC_Base.shared cc_init:CC_Label.class]; CCUIPackage(oneLabel)
#define CCButton     CC_Button *[CC_Base.shared cc_init:CC_Button.class] CCUIPackage()
#define CCTextView   CCUIPackage((CC_TextView *)[CC_Base.shared cc_init:CC_TextView.class])
#define CCTextField  CCUIPackage((CC_TextField *)[CC_Base.shared cc_init:CC_TextField.class])
#define CCImageView  CCUIPackage((CC_ImageView *)[CC_Base.shared cc_init:CC_ImageView.class])
#define CCScrollView CCUIPackage((CC_ScrollView *)[CC_Base.shared cc_init:CC_ScrollView.class])
#define CCTableView  CCUIPackage((CC_TableView *)[CC_Base.shared cc_init:CC_TableView.class])
#define CCWebView    CCUIPackage((CC_WebView *)[CC_Base.shared cc_init:CC_WebView.class])


@interface ccs (CCUI)

///-------------------------------
/// @name View object Provider
///-------------------------------

/**
 Usage:
 
 CC_View *someView = ccs.View;
 
 {typeof(someView) item = someView;
    item.cc_addToView(viewController.view)
        .cc_name(@"someName")
        .cc_frame(RH(10),RH(100),RH(100),RH(100))
        .cc_backgroundColor(UIColor.whiteColor);
 
    [item cc_tappedInterval:3 block:^(id view) {
        [self cc_removeViewWithName:@"abc"];
    }];
 }
 
 CC_View *v1=ccs.view;
 v1
 .cc_addToView(self.view)
 .cc_name(@"someName")
 .cc_frame(RH(10),RH(100),RH(100),RH(100))
 .cc_backgroundColor(UIColor.whiteColor)
 .cc_tappedInterval(3, ^(id view){
    [self cc_removeViewWithName:@"someName"];
 });
 
 before
 UIView *someView = [[[UIView alloc] initWithFrame:CGRectMake(RH(10),RH(100),RH(100),RH(100))];
 
 [viewController.view addSubview:someView];
 someView.backgroundColor = UIColor.whiteColor;
 someView.name = @"someName";
 
 [someView cc_tappedInterval:3 block:^(id view) {
    [self cc_removeViewWithName:@"abc"];
 }];
 
 */

+ (CC_View *)View;

+ (CC_Label *)Label;

+ (CC_Button *)Button;

+ (CC_TextView *)TextView;

+ (CC_TextField *)TextField;

+ (CC_ImageView *)ImageView;

+ (CC_ScrollView *)ScrollView;

+ (CC_TableView *)TableView;

+ (CC_WebView *)WebView;

///-------------------------------
/// @name Custom
///-------------------------------
+ (__kindof CC_View *)ViewWithClass:(Class)cls;
+ (__kindof CC_Label *)LabelWithClass:(Class)cls;
+ (__kindof CC_Button *)ButtonWithClass:(Class)cls;
+ (__kindof CC_TextView *)TextViewWtihClass:(Class)cls;
+ (__kindof CC_TextField *)TextFieldWtihClass:(Class)cls;
+ (__kindof CC_ImageView *)ImageViewWtihClass:(Class)cls;
+ (__kindof CC_ScrollView *)ScrollViewWithClass:(Class)cls;
+ (__kindof CC_TableView *)TableViewWithClass:(Class)cls;

@end

@interface ccs (CCUIExt)

/// Mask
+ (CC_Mask *)Mask;
+ (void)maskStart;
+ (void)maskStartAtView:(UIView *)view;
+ (void)maskStop;

+ (CC_LabelGroup *)LabelGroup;

@end
