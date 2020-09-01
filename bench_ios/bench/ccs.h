//
//  ccs.h
//  testbenchios
//
//  Created by gwh on 2019/8/8.
//  Copyright © 2019 gwh. All rights reserved.
//  11

#import "CC_UIKit.h"
#import "CC_LibKit.h"
#import "CC_Macro.h"
#import "CC_UI+Atom.h"
#import <QuartzCore/QuartzCore.h>

// add pch path in 'Build Settings' - 'Prefix Header' as  '$(SRCROOT)/projectname/projectname-prefix.pch'

static inline BOOL ccs_isDebug() {
#if DEBUG
    return YES;
#endif
    return NO;
}
/**
Profile time cost.
@param block     code to benchmark
@param complete  code time cost (millisecond)
 */
static inline void ccs_timeCost(void (^block)(void), void (^complete)(double ms)) {
    extern double CACurrentMediaTime (void);
    double begin, end, ms;
    begin = CACurrentMediaTime();
    block();
    end = CACurrentMediaTime();
    ms = (end - begin) * 1000.0;
    complete(ms);
}

@interface ccs : CC_Object
//
+ (BOOL)isDebug;

// 手动配置环境 0线上 1主干 默认根据 CCBUILDTAG 打包方式选择
// release=0，trunk=1，branch1=2
+ (void)configureEnvironment:(int)tag;
+ (int)getEnvironment;

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

+ (void)configureNavigationBarWithTitleFont:(UIFont *)font
                                 titleColor:(UIColor *)titleColor
                            backgroundColor:(UIColor *)backgroundColor
                            backgroundImage:(UIImage *)backgroundImage;

//配置是否进入后台，请求是否中断，默认开启
+ (void)configureBackGroundSessionStop:(BOOL)stopSession;

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
// 去除对象警告
+ (id)convert:(id)obj;
+ (UIApplication *)appApplication;
// 当前app的appDelegate
+ (CC_AppDelegate *)appDelegate;

// cluster
// 类簇的优点：
// 1.可以将抽象基类背后的复杂细节隐藏起来
// 2.程序员不会需要记住各种创建对象的具体类实现，简化了开发成本，提高了开发效率
// 3.便于进行封装和组件化
// 4.减少了if else 这样缺乏扩展性的代码
// 5.增加新功能支持不影响其他代码
+ (NSString *)string:(NSString *)format, ...;
+ (NSString *)stringValue:(id)value;
+ (NSString *)stringInt:(int)value;
+ (NSString *)stringFloat:(float)value;
+ (NSString *)stringDouble:(double)value;

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

// 分类分组
+ (CC_UI *)ui;
+ (CC_Tool *)tool;

// 金额类
+ (CC_Money *)money;
// 数学函数
+ (CC_Math *)math;
// 崩溃管理
+ (CC_CoreCrash *)coreCrash;

#pragma mark CC_UIKit

#define APP_STANDARD(name) [ccs appStandard:name]
#pragma mark UI管理
+ (CC_CoreUI *)coreUI;
+ (CGRect)screenRect;
+ (id)appStandard:(NSString *)name;
+ (float)statusBarHeight;
+ (float)x;
+ (float)y;
+ (float)width;
+ (float)height;
+ (float)safeHeight;
+ (float)safeBottom;
+ (float)relativeHeight:(float)height;
+ (UIFont *)relativeFont:(float)fontSize;
+ (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize;
+ (id)getAView;
+ (id)getLastWindow;
+ (BOOL)isDarkMode;
+ (void)setDeviceOrientation:(UIDeviceOrientation)orientation;

+ (CC_ViewController *)currentVC;
+ (CC_TabBarController *)currentTabBarC;

#pragma mark VC控制器操作
+ (CC_NavigationController *)navigation;
+ (void)pushViewController:(id)viewController;
+ (void)pushViewController:(id)viewController animated:(BOOL)animated;
// push to viewController && remove current viewController
+ (void)pushViewController:(id)viewController withDismissVisible:(BOOL)dismissVisible;
+ (void)presentViewController:(id)viewController;
// push a navigationController which has 'viewController' as root viewController
+ (void)presentViewController:(id)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style;

+ (void)popViewController;
+ (void)popViewControllerFrom:(id)viewController userInfo:(id)userInfo;
+ (void)dismissViewController;
+ (void)popToViewController:(Class)aClass;
+ (void)popToRootViewControllerAnimated:(BOOL)animated;
+ (void)pushWebViewControllerWithUrl:(NSString *)urlStr;

#pragma mark 网络管理
+ (CC_HttpTask *)httpTask;
+ (CC_HttpHelper *)httpHelper;
+ (CC_HttpEncryption *)httpEncryption;
+ (CC_HttpConfig *)httpConfig;
+ (HttpModel *)httpModel;
// 清除所有内存的图片缓存
+ (void)clearAllMemoryWebImageCache:(void(^)(void))completionBlock;
// 清除所有磁盘的图片缓存
+ (void)clearAllDiskWebImageCache:(void(^)(void))completionBlock;
// 清除所有内存和磁盘的图片缓存
+ (void)clearAllWebImageCache:(void(^)(void))completionBlock;
// 清除指定key的图片缓存
+ (void)clearWebImageCacheForKey:(NSString*)url completionBlock:(void(^)(void))completionBlock;

#pragma mark 存储管理
// keychain
+ (NSString *)keychainValueForKey:(NSString *)name;
+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value;
+ (NSString *)keychainUUID;

// NSUserDefaults
+ (id)getDefault:(NSString *)key;
+ (void)setDefault:(NSString *)key value:(id)value;
+ (id)defaultValueForKey:(NSString *)key;
+ (void)saveDefaultKey:(NSString *)key value:(id)value;

+ (id)getSafeDefault:(NSString *)key;
+ (void)setSafeDefault:(NSString *)key value:(id)value;
+ (id)safeDefaultValueForKey:(NSString *)key;
+ (void)saveSafeDefaultKey:(NSString *)key value:(id)value;

// 应用内文件 NSBundle
+ (NSString *)appName;
+ (NSString *)appBid;
+ (NSString *)appVersion;
+ (NSString *)appBundleVersion;
+ (NSDictionary *)appBundle;

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name type:(NSString *)type;
+ (NSData *)bundleFileWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)bundlePlistWithPath:(NSString *)name;

+ (BOOL)copyBundleFileToSandboxToPath:(NSString *)name type:(NSString *)type;
+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name;

+ (UIImage *)bundleImage:(NSString *)imgName bundleName:(NSString *)bundleName;
+ (UIImage *)benchBundleImage:(NSString *)imgName;

// 沙盒 Documents
+ (CC_SandboxStore *)sandbox;
+ (NSString *)sandboxPath;
+ (NSArray *)sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type;

+ (NSData *)sandboxFileWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)sandboxPlistWithPath:(NSString *)name;

+ (void)deleteSandboxFileWithName:(NSString *)name;
+ (BOOL)saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type;

// MySQL数据库
+ (CC_DataBaseStore *)dataBaseStore;

#pragma mark 声音管理
+ (CC_Audio *)audio;

#pragma mark 线程管理
+ (CC_Thread *)thread;
+ (void)gotoThread:(void (^)(void))block;
+ (void)gotoMain:(void (^)(void))block;
+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;
// 异步创建多个任务
+ (void)threadGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block;
// 带有block的多个任务并行
+ (void)threadBlockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;
// 带有block的多个任务串行
+ (void)threadBlockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block;
// 带有block的任务结束后调用
+ (void)threadBlockFinish:(id)sema;

// 根据关键字可以取消的延时
+ (void)delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block;
+ (void)delayStop:(NSString *)key;

#pragma mark 定时器
+ (CC_Timer *)timer;
// 根据关键字注册定时器
+ (void)timerRegister:(NSString *)name interval:(float)interval block:(void (^)(void))block;
+ (void)timerCancel:(NSString *)name;

+ (NSString *)uniqueNowTimestamp;
+ (NSString *)nowTimeTimestamp;

#pragma mark CC_CoreFoundation
// Init class
+ (id)init:(Class)aClass;

// 组件生命周期注册
// + (void)load {
//    [ccs registerAppDelegate:self];
// }
+ (id)registerAppDelegate:(id)module;
+ (id)getAppDelegate:(Class)aClass;

// 单例注册
// + (instancetype)shared {
//     return [ccs registerSharedInstance:self];
// }
+ (id)registerSharedInstance:(id)shared;
+ (id)registerSharedInstance:(id)shared block:(void(^)(void))block;

// Data sharing, shared data in app, such as update a model in controller A when you are in controller B
// App共享的数据存储 如在控制器B更新控制器A里的model
+ (id)getShared:(NSString *)key;
+ (id)sharedValueForKey:(NSString *)key;
+ (id)removeShared:(NSString *)key;
+ (id)setShared:(NSString *)key value:(id)obj;
+ (id)resetShared:(NSString *)key value:(id)obj;

@end

@interface ccs (CCUI)

///-------------------------------
/// @name 生成UI控件
///-------------------------------

/// An object that manages the content for a rectangular area on the screen.
///
/// Usage:
///
/// CC_View *someView = ccs.View;
/// .cc_addToView(self.view)
/// .cc_name(@"someName")
/// .cc_frame(RH(10),RH(100),RH(100),RH(100))
/// .cc_backgroundColor(UIColor.whiteColor);
///
+ (CC_View           *)View;
+ (CC_ImageView      *)ImageView;
+ (CC_Label          *)Label;
+ (CC_StrokeLabel    *)StrokeLabel;
+ (CC_Button         *)Button;
+ (CC_TextView       *)TextView;
+ (CC_TextField      *)TextField;
+ (CC_ScrollView     *)ScrollView;
+ (CC_TableView      *)TableView;
+ (CC_TableView      *)TableViewWithStyle:(UITableViewStyle)style;
+ (CC_CollectionView *)CollectionView;
+ (CC_CollectionView *)CollectionViewWithLayout:(UICollectionViewLayout *)layout;
+ (CC_WebView        *)WebView;
+ (CC_LabelGroup     *)LabelGroup;

///-------------------------------
/// @name 生成其它对象
///-------------------------------

#define IMAGE(NAME) [UIImage imageNamed:NAME]

/// Creates an image object from the specified named asset.
+ (CC_TextAttachment         *)textAttachment;
+ (NSAttributedString        *)attributedString;
+ (NSMutableAttributedString *)mutableAttributedString;

+ (CC_Mask *)mask;
+ (CC_Notice *)notice;
+ (CC_Alert *)alert;

+ (UIColor *)primaryColor;

+ (void)maskStart;
+ (void)maskStartAtView:(UIView *)view;
+ (void)maskStop;

+ (void)showNotice:(NSString *)str;
+ (void)showNotice:(NSString *)str atView:(UIView *)view;
+ (void)showNotice:(NSString *)str atView:(UIView *)view delay:(int)delay;

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block;
+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block;
+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block;

@end
