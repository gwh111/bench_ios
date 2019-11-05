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

+ (id)model:(Class)aClass;

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
+ (float)safeBottom;
+ (float)relativeHeight:(float)height;
+ (UIFont *)relativeFont:(float)fontSize;
+ (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize;
+ (id)getAView;

#pragma mark action
+ (void)pushViewController:(CC_ViewController *)viewController;
// push to viewController && remove current viewController
+ (void)pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)dismissVisible;
+ (void)presentViewController:(CC_ViewController *)viewController;
// push a navigationController which has 'viewController' as root viewController
+ (void)presentViewController:(CC_ViewController *)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style;

+ (void)popViewController;
+ (void)dismissViewController;
+ (void)popToViewController:(Class)aClass;
+ (void)pushWebViewControllerWithUrl:(NSString *)urlStr;

#pragma mark CC_LibNetwork
+ (CC_HttpTask *)httpTask;
+ (CC_HttpHelper *)httpHelper;
+ (CC_HttpEncryption *)httpEncryption;
+ (CC_HttpConfig *)httpConfig;

#pragma mark CC_LibStorage
// keychain
+ (NSString *)keychainValueForKey:(NSString *)name;
+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value;
+ (NSString *)keychainUUID;

// NSUserDefaults
+ (id)defaultValueForKey:(NSString *)key;
+ (void)saveDefaultKey:(NSString *)key value:(id)value;

+ (id)safeDefaultValueForKey:(NSString *)key;
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

// DataBase
+ (CC_DataBaseStore *)dataBaseStore;

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
+ (id)init:(Class)aClass;

+ (void)registerAppDelegate:(id)module;
// Shared Instance
+ (id)registerSharedInstance:(id)shared;
+ (id)registerSharedInstance:(id)shared block:(void(^)(void))block;

// data sharing, shared data in app, such as update a model in controller A when you are in controller B
// app共享的数据存储 如在控制器B更新控制器A里的model
+ (id)sharedValueForKey:(NSString *)key;
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

/// An object that displays a single image or a sequence of animated
/// images in your interface
+ (CC_ImageView      *)ImageView;

/// A view that displays one or more lines of read-only text,
/// often used in conjunction with controls to describe their intended purpose.
+ (CC_Label          *)Label;

/// A control that executes your custom code in response to
/// user interactions.
+ (CC_Button         *)Button;

/// A scrollable, multiline text region.
+ (CC_TextView       *)TextView;

/// An object that displays an editable text area in your interface.
+ (CC_TextField      *)TextField;

/// A view that allows the scrolling and zooming of its
/// contained views.
+ (CC_ScrollView     *)ScrollView;

/// A view that presents data using rows arranged in a
/// single column.
/// must specify style at creation. -initWithFrame: calls this with UITableViewStylePlain
+ (CC_TableView      *)TableView;
+ (CC_TableView      *)TableViewWithStyle:(UITableViewStyle)style;

/// An object that manages an ordered collection of data items
/// and presents them using customizable layouts.
+ (CC_CollectionView *)CollectionView;
+ (CC_CollectionView *)CollectionViewWithLayout:(UICollectionViewLayout *)layout;

/// An object that displays interactive web content, such as
/// for an in-app browser.
+ (CC_WebView        *)WebView;

+ (CC_LabelGroup     *)LabelGroup;

///-------------------------------
/// @name 生成其它对象
///-------------------------------

#define IMAGE(NAME) [ccs image:NAME]

/// Creates an image object from the specified named asset.
+ (CC_Image                  *)image:(NSString *)imageName;

/// The values for the attachment attributes of attributed strings and related objects.
+ (CC_TextAttachment         *)textAttachment;

/// A string that has associated attributes (such as visual style, hyperlinks,
/// or accessibility data) for portions of its text.
+ (NSAttributedString        *)attributedString;

/// A mutable string object that also contains attributes (such as visual style, hyperlinks,
/// or accessibility data) associated with various portions of its text content.
+ (NSMutableAttributedString *)mutableAttributedString;

+ (id)anObject:(Class)cls;

///-------------------------------
/// @name 生成过渡视图
///-------------------------------

/**
 是否有标题 否 CC_Mask
 是
    是否有msg 否 CC_Notice
 是
    UIAlertController
 */

//+ (void)show;
//+ (void)dismiss;
//
///// CC_Notice
//+ (void)showWithTitle:(NSString *)title;
//
///// AlertController
//+ (void)showWithTitle:(NSString *)title
//                  msg:(NSString *)msg
//                 btns:(NSArray <NSString *>*)bts
//                block:(void (^)(int index, NSString *name))block;

+ (CC_Mask *)Mask;
+ (void)maskStart;
+ (void)maskStartAtView:(UIView *)view;
+ (void)maskStop;

+ (CC_Notice *)Notice;

+ (void)showNotice:(NSString *)str;
+ (void)showNotice:(NSString *)str atView:(UIView *)view;
+ (void)showNotice:(NSString *)str atView:(UIView *)view delay:(int)delay;

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block;

+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block;

+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block;

@end
