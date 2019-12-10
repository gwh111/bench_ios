//
//  ccs.m
//  testbenchios
//
//  Created by gwh on 2019/8/8.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs.h"
#import "CC_Base.h"
#import "CC_CoreBase.h"

@implementation ccs

+ (void)configureEnvironment:(int)tag {
    CCLOG(@"\napp name:%@\napp version:%@",[ccs appName],[ccs appVersion]);
    CC_Base.shared.cc_environment = tag;
}

+ (int)getEnvironment {
    return CC_Base.shared.cc_environment;
}

+ (void)configureAppStandard:(NSDictionary *)defaultDic {
    [cc_message cc_instance:CC_CoreUI.shared method:@selector(initAppFontAndColorStandard:) params:defaultDic];
}

+ (void)configureDomainWithReqGroupList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block {
    [cc_message cc_instance:CC_HttpHelper.shared method:@selector(domainWithReqGroupList:andKey:cache:pingTest:block:) params:domainReqList,domainReqKey,[CC_Int value:cache],[CC_Int value:pingTest],block];
}

+ (void)configureDomainWithReqList:(NSArray *)domainReqList block:(void (^)(HttpModel *result))block {
    [cc_message cc_instance:CC_HttpHelper.shared method:@selector(domainWithReqList:block:) params:domainReqList,block];
}

+ (void)configureNavigationBarWithTitleFont:(UIFont *)font
                                 titleColor:(UIColor *)titleColor
                            backgroundColor:(UIColor *)backgroundColor
                            backgroundImage:(UIImage *)backgroundImage {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_initNavigationBarWithTitleFont:titleColor:backgroundColor:backgroundImage:) params:font,titleColor,backgroundColor,backgroundImage];
}

+ (void)configureBackGroundSessionStop:(BOOL)stopSession{
    CC_HttpHelper.shared.stopSession = stopSession;
}

+ (void)openLaunchMonitor:(BOOL)open {
    CC_Monitor.shared.startLaunchMonitor = open;
}

+ (void)openPatrolMonitor:(BOOL)open {
    CC_Monitor.shared.startPatrolMonitor = open;
}

+ (void)openLaunchMonitorLog:(BOOL)open {
    CC_Monitor.shared.startLaunchMonitorLog = open;
}

+ (void)openPatrolMonitorLog:(BOOL)open {
    CC_Monitor.shared.startPatrolMonitorLog = open;
}

#pragma mark object
//Resolve warning: Incompatible pointer types initializing 'xxx *' with an expression of type 'xxx *'
+ (id)convert:(id)obj {
    return obj;
}

+ (UIApplication *)appApplication {
    return [UIApplication sharedApplication];
}

+ (CC_AppDelegate *)appDelegate {
    return [CC_AppDelegate shared];
}

// cluster
+ (NSString *)string:(NSString *)format, ... {
    if (!format) {
        return @"";
    }
    va_list ap;
    va_start (ap, format);
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    return body;
}

+ (NSMutableString *)mutString {
    return [CC_Base.shared cc_init:[NSMutableString class]];
}
+ (NSMutableString *)mutString:(NSString *)format, ... {
    if (!format) {
        return @"".mutableCopy;
    }
    va_list ap;
    va_start (ap, format);
    NSMutableString *body=[[NSMutableString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    return body;
}

+ (NSArray *)array:(NSArray *)arr {
    if (!arr) {
        return [CC_Base.shared cc_init:[NSArray class]];
    }
    return [[NSArray alloc]initWithArray:arr];
}

+ (NSMutableArray *)mutArray {
    return [CC_Base.shared cc_init:[NSMutableArray class]];
}
+ (NSMutableArray *)mutArray:(NSMutableArray *)arr{
    if (!arr) {
        return [CC_Base.shared cc_init:[NSMutableArray class]];
    }
    return [[NSMutableArray alloc]initWithArray:arr];
}

+ (NSDictionary *)dictionary:(NSDictionary *)dic {
    if (!dic) {
        return [CC_Base.shared cc_init:[NSDictionary class]];
    }
    return [[NSDictionary alloc]initWithDictionary:dic];
}

+ (NSMutableDictionary *)mutDictionary {
    return [CC_Base.shared cc_init:[NSMutableDictionary class]];
}

+ (NSMutableDictionary *)mutDictionary:(NSMutableDictionary *)dic {
    if (!dic) {
        return [self mutDictionary];
    }
    return [[NSMutableDictionary alloc]initWithDictionary:dic];
}

+ (id)model:(Class)aClass {
    return [CC_Base.shared cc_init:aClass];
}

+ (HttpModel *)httpModel {
    return [CC_Base.shared cc_init:HttpModel.class];
}

+ (CC_Money *)money {
    return [CC_Base.shared cc_init:CC_Money.class];
}

+ (CC_ShareUI *)ui {
    return CC_ShareUI.shared;
}

#pragma mark CC_UIKit
+ (id)appStandard:(NSString *)name {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(appStandard:) params:name];
}

+ (float)statusBarHeight {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(statusBarHeight)]floatValue];
}

+ (float)x {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(x)]floatValue];
}

+ (float)y {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(y)]floatValue];
}

+ (float)width {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(width)]floatValue];
}

+ (float)height {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(height)]floatValue];
}

+ (float)safeHeight {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(safeHeight)]floatValue];
}

+ (float)safeBottom {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(safeBottom)]floatValue];
}

+ (float)relativeHeight:(float)height {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeHeight:) params:Float(height)]floatValue];
}

+ (UIFont *)relativeFont:(float)fontSize {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeFont:) params:Float(fontSize)];
}

+ (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeFont:fontSize:) params:fontName,Float(fontSize)];
}

+ (UIColor *)colorHexA:(NSString *)hex alpha:(float)alpha {
    return [cc_message cc_class:[UIColor class] method:@selector(cc_hexA:alpha:) params:hex,Float(alpha)];
}

+ (UIColor *)colorRgbA:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [cc_message cc_class:[UIColor class] method:@selector(cc_rgbA:green:blue:alpha:) params:Float(red),Float(blue),Float(green),Float(alpha)];
}

+ (NSString *)deviceName {
    return [cc_message cc_class:CC_Device.class method:@selector(cc_deviceName)];
}

+ (id)getAView {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(getAView) params:nil];
}

+ (BOOL)isDarkMode {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(isDarkMode) params:nil]boolValue];
}

+ (void)setDeviceOrientation:(UIDeviceOrientation)orientation {
    [cc_message cc_instance:MXRotationManager.defaultManager method:@selector(setOrientationIndex:) params:[CC_Int value:orientation]];
}

#pragma mark action
+ (void)pushViewController:(CC_ViewController *)viewController {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_pushViewController:) params:viewController];
}

+ (void)pushViewController:(CC_ViewController *)viewController withDismissVisible:(BOOL)dismissVisible {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_pushViewController:withDismissVisible:) params:viewController,[CC_Int value:dismissVisible]];
}

+ (void)presentViewController:(CC_ViewController *)viewController {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_presentViewController:) params:viewController];
}

+ (void)presentViewController:(CC_ViewController *)viewController withNavigationControllerStyle:(UIModalPresentationStyle)style {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_presentViewController:withNavigationControllerStyle:) params:viewController, style];
}

+ (void)popViewController {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_popViewController)];
}

+ (void)popViewControllerFrom:(CC_ViewController *)viewController userInfo:(id)userInfo {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_popViewControllerFrom:userInfo:) params:viewController, userInfo];
}

+ (void)dismissViewController {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_dismissViewController)];
}

+ (void)popToViewController:(Class)aClass {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_popToViewController:)params:aClass];
}

+ (void)pushWebViewControllerWithUrl:(NSString *)urlStr {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_pushWebViewControllerWithUrl:) params:urlStr];
}

#pragma mark CC_LibNetwork
+ (CC_HttpTask *)httpTask{
    return CC_HttpTask.shared;
}

+ (CC_HttpHelper *)httpHelper{
    return CC_HttpHelper.shared;
}

+ (CC_HttpEncryption *)httpEncryption{
    return CC_HttpEncryption.new;
}

+ (CC_HttpConfig *)httpConfig{
    return CC_HttpConfig.new;
}

+ (void)clearAllMemoryWebImageCache:(void (^)(void))completionBlock{
    [CC_WebImageManager.shared clearAllMemoryWebImageCache:completionBlock];
}

+ (void)clearAllDiskWebImageCache:(void (^)(void))completionBlock{
    [CC_WebImageManager.shared clearAllDiskWebImageCache:completionBlock];
}

+ (void)clearAllWebImageCache:(void (^)(void))completionBlock{
    [CC_WebImageManager.shared clearAllWebImageCache:completionBlock];
}

+ (void)clearWebImageCacheForKey:(NSString *)url completionBlock:(void (^)(void))completionBlock{
    [CC_WebImageManager.shared clearWebImageCacheForKey:url completionBlock:completionBlock];
}
#pragma mark CC_LibStore
+ (NSString *)keychainValueForKey:(NSString *)name{
    return [cc_message cc_class:CC_KeyChainStore.class method:@selector(cc_keychainWithName:) params:name];
}

+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value{
    [cc_message cc_class:CC_KeyChainStore.class method:@selector(cc_saveKeychainWithName:str:) params:key,value];
}

+ (NSString *)keychainUUID {
    return [cc_message cc_class:CC_KeyChainStore.class method:@selector(cc_keychainUUID)];
}

+ (id)getDefault:(NSString *)key {
    return [self defaultValueForKey:key];
}

+ (id)defaultValueForKey:(NSString *)key {
    return [cc_message cc_class:CC_DefaultStore.class method:@selector(cc_default:) params:key];
}

+ (void)setDefault:(NSString *)key value:(id)value {
    [self saveDefaultKey:key value:value];
}

+ (void)saveDefaultKey:(NSString *)key value:(id)value {
    [cc_message cc_class:CC_DefaultStore.class method:@selector(cc_saveDefault:value:) params:key,value];
}

+ (id)getSafeDefault:(NSString *)key {
    return [self safeDefaultValueForKey:key];
}

+ (id)safeDefaultValueForKey:(NSString *)key {
    return [cc_message cc_class:CC_DefaultStore.class method:@selector(cc_safeDefault:) params:key];
}

+ (void)setSafeDefault:(NSString *)key value:(id)value {
    [self saveSafeDefaultKey:key value:value];
}

+ (void)saveSafeDefaultKey:(NSString *)key value:(id)value {
    [cc_message cc_class:CC_DefaultStore.class method:@selector(cc_saveSafeDefault:value:) params:key,value];
}

+ (NSString *)appName{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_appName)];
}

+ (NSString *)appBid{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_appBid)];
}

+ (NSString *)appVersion{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_appVersion)];
}

+ (NSString *)appBundleVersion{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_appBundleVersion)];
}

+ (NSDictionary *)appBundle{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_appBundle)];
}

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name type:(NSString *)type{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_bundleFileNamesWithPath:type:) params:name,type];
}

+ (NSData *)bundleFileWithPath:(NSString *)name type:(NSString *)type{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_bundleFileWithPath:type:) params:name,type];
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name{
    return [cc_message cc_class:CC_BundleStore.class method:@selector(cc_bundlePlistWithPath:) params:name];
}

+ (BOOL)copyBunldFileToSandboxToPath:(NSString *)name type:(NSString *)type{
    return [[cc_message cc_class:CC_BundleStore.class method:@selector(cc_copyBunldFileToSandboxToPath:type:) params:name,type]boolValue];
}

+ (BOOL)copyBunldPlistToSandboxToPath:(NSString *)name{
    return [[cc_message cc_class:CC_BundleStore.class method:@selector(cc_copyBunldPlistToSandboxToPath:) params:name]boolValue];
}

+ (NSString *)sandboxPath{
    return [cc_message cc_class:CC_SandboxStore.class method:@selector(cc_sandboxPath)];
}

+ (NSArray *)sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type{
    return [cc_message cc_class:CC_SandboxStore.class method:@selector(cc_sandboxDirectoryFilesWithPath:type:) params:name,type];
}

+ (NSData *)sandboxFileWithPath:(NSString *)name type:(NSString *)type{
    return [cc_message cc_class:CC_SandboxStore.class method:@selector(cc_sandboxFileWithPath:type:) params:name,type];
}

+ (NSDictionary *)sandboxPlistWithPath:(NSString *)name{
    return [cc_message cc_class:CC_SandboxStore.class method:@selector(cc_sandboxPlistWithPath:) params:name];
}

+ (BOOL)deleteSandboxFileWithName:(NSString *)name{
    return [[cc_message cc_class:CC_SandboxStore.class method:@selector(cc_deleteSandboxFileWithName:) params:name]boolValue];
}

+ (BOOL)saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type{
    return [[cc_message cc_class:CC_SandboxStore.class method:@selector(cc_saveToSandboxWithData:toPath:type:) params:data,name,type]boolValue];
}

+ (CC_DataBaseStore *)dataBaseStore {
    return [CC_DataBaseStore shared];
}

#pragma mark CC_LibAudio
+ (CC_MusicBox *)musicBox {
    return CC_MusicBox.shared;
}

#pragma mark CC_CoreFoundation
+ (id)init:(Class)aClass {
    id object = [CC_Base.shared cc_init:aClass];
    [cc_message cc_instance:object method:@selector(start)];
    return object;
}

+ (void)registerAppDelegate:(id)module{
    [CC_Base.shared cc_registerAppDelegate:module];
}

+ (id)registerSharedInstance:(id)shared{
    return [CC_Base.shared cc_registerSharedInstance:shared];
}

+ (id)registerSharedInstance:(id)shared block:(void(^)(void))block{
    return [CC_Base.shared cc_registerSharedInstance:shared block:block];
}

+ (id)getShared:(NSString *)key {
    return [self sharedValueForKey:key];
}

+ (id)sharedValueForKey:(NSString *)key {
    return [CC_Base.shared cc_shared:key];
}

+ (id)removeShared:(NSString *)key {
    return [CC_Base.shared cc_removeShared:key];
}

+ (id)setShared:(NSString *)key value:(id)value {
    return [CC_Base.shared cc_setShared:key obj:value];
}

+ (id)resetShared:(NSString *)key value:(id)value {
    return [CC_Base.shared cc_resetShared:key obj:value];
}

#pragma mark CC_Function
+ (id)function_jsonWithString:(NSString *)jsonString{
    return [cc_message cc_class:CC_Function.class method:@selector(cc_jsonWithString:) params:jsonString];
}

+ (NSString *)function_stringWithJson:(id)object{
    return [cc_message cc_class:CC_Function.class method:@selector(cc_stringWithJson:) params:object];
}

+ (NSData *)function_dataWithInt:(int)i{
    return [cc_message cc_class:CC_Function.class method:@selector(cc_dataWithInt:) params:Int(i)];
}

+ (BOOL)function_isEmpty:(id)obj{
    return [[cc_message cc_class:CC_Function.class method:@selector(cc_isEmpty:) params:obj]boolValue];
}

+ (BOOL)function_isInstallFromAppStore{
    return [[cc_message cc_class:CC_Function.class method:@selector(cc_isInstallFromAppStore)]boolValue];
}

+ (BOOL)function_isJailBreak{
    return [[cc_message cc_class:CC_Function.class method:@selector(cc_isJailBreak)]boolValue];
}

+ (int)function_compareVersion:(NSString *)v1 cutVersion:(NSString *)v2{
    return [[cc_message cc_class:CC_Function.class method:@selector(cc_compareVersion:cutVersion:) params:v1,v2]intValue];
}

+ (NSString *)function_formatDate:(NSString *)date nowDate:(NSString *)nowDate{
    return [cc_message cc_class:CC_Function.class method:@selector(cc_formatDate:nowDate:) params:date,nowDate];
}

+ (NSString *)function_formatDate:(NSString *)date nowDate:(NSString *)nowDate formatArr:(NSArray *)formatArr{
    return [cc_message cc_class:CC_Function.class method:@selector(cc_formatDate:nowDate:formatArr:) params:date,nowDate,formatArr];
}

+ (NSString *)function_replaceHtmlLabel:(NSString *)htmlStr labelName:(NSString *)labelName toLabelName:(NSString *)toLabelName trimSpace:(BOOL)trimSpace{
    return [cc_message cc_class:CC_String.class method:@selector(cc_replaceHtmlLabel:labelName:toLabelName:trimSpace:) params:htmlStr,labelName,toLabelName,Int(trimSpace)];
}

+ (NSArray *)function_getHtmlLabel:(NSString *)htmlStr start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd{
    return [cc_message cc_class:CC_String.class method:@selector(cc_getHtmlLabel:start:end:includeStartEnd:) params:htmlStr,startStr,endStr,Int(includeStartEnd)];
}

+ (NSMutableString *)function_MD5SignWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [cc_message cc_class:CC_String.class method:@selector(cc_MD5SignWithDic:andMD5Key:) params:dic,MD5KeyString];
}

+ (NSMutableString *)function_MD5SignValueWithDic:(NSMutableDictionary *)dic andMD5Key:(NSString *)MD5KeyString{
    return [cc_message cc_class:CC_String.class method:@selector(cc_MD5SignValueWithDic:andMD5Key:) params:dic,MD5KeyString];
}

+ (NSMutableArray *)function_sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr{
    return [cc_message cc_class:CC_Array.class method:@selector(cc_sortChineseArr:depthArr:) params:sortMutArr,depthArr];
}

+ (NSMutableArray *)function_sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc{
    return [cc_message cc_class:CC_Array.class method:@selector(cc_sortMutArr:byKey:desc:) params:mutArr,key,Int(desc)];
}

+ (NSMutableArray *)function_mapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap{
    return [cc_message cc_class:CC_Array.class method:@selector(cc_mapParser:idKey:keepKey:pathMap:) params:pathArr,idKey,Int(keepKey),pathMap];
}

+ (NSMutableArray *)function_addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap{
    return [cc_message cc_class:CC_Array.class method:@selector(cc_addMapParser:idKey:keepKey:map:) params:pathArr,idKey,Int(keepKey),getMap];
}

+ (NSTimeInterval)function_compareDate:(id)date1 cut:(id)date2{
    return [[cc_message cc_class:CC_Date.class method:@selector(cc_compareDate:cut:) params:date1,date2]doubleValue];
}

+ (NSData *)function_archivedDataWithObject:(id)object{
    return [cc_message cc_class:CC_Data.class method:@selector(cc_archivedDataWithObject:) params:object];
}

+ (UIImage *)function_imageWithColor:(UIColor*)color width:(CGFloat)width height:(CGFloat)height{
    return [cc_message cc_class:CC_Color.class method:@selector(cc_imageWithColor:width:height:) params:color,width,height];
}

+ (id)function_unarchivedObjectWithData:(id)data{
    return [cc_message cc_class:CC_Data.class method:@selector(cc_unarchivedObjectWithData:) params:data];
}

+ (id)function_copyObject:(id)object{
    return [cc_message cc_class:CC_Object.class method:@selector(cc_copyObject:) params:object];
}

#pragma mark CC_CoreThread
+ (void)gotoThread:(void (^)(void))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_gotoThread:) params:block];
}

+ (void)gotoMain:(void (^)(void))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_gotoMain:) params:block];
}

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_delay:block:) params:[CC_Double value:delayInSeconds],block];
}

+ (void)delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_delay:key:block:) params:Int(delayInSeconds),key,block];
}

+ (void)delayStop:(NSString *)key{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(delayStop:) params:key];
}

+ (void)threadGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_group:block:) params:Int(taskCount),block];
}

+ (void)threadBlockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_blockSequence:block:) params:Int(taskCount),block];
}

+ (void)threadBlockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_blockGroup:block:) params:Int(taskCount),block];
}

+ (void)threadBlockFinish:(id)sema{
    [cc_message cc_instance:CC_CoreThread.shared method:@selector(cc_blockFinish:) params:sema];
}

#pragma mark CC_CoreTimer
+ (void)timerRegister:(NSString *)name interval:(float)interval block:(void (^)(void))block{
    [cc_message cc_instance:CC_CoreTimer.shared method:@selector(cc_registerT:interval:block:) params:name,Float(interval),block];
}

+ (void)timerCancel:(NSString *)name{
    [cc_message cc_instance:CC_CoreTimer.shared method:@selector(cc_unRegisterT:) params:name];
}

+ (NSString *)uniqueNowTimestamp{
    return [cc_message cc_instance:CC_CoreTimer.shared method:@selector(cc_uniqueNowTimestamp)];
}

+ (NSString *)nowTimeTimestamp{
    return [cc_message cc_instance:CC_CoreTimer.shared method:@selector(cc_nowTimeTimestamp)];
}


@end


@implementation ccs (CCUI)

// MARK: - CCUI Framework Provider -

+ (CC_View *)View {
    return [CC_Base.shared cc_init:CC_View.class];
}

+ (CC_Label *)Label {
    return [CC_Base.shared cc_init:CC_Label.class];
}

+ (CC_Button *)Button {
    return [CC_Base.shared cc_init:CC_Button.class];
}

+ (CC_TextView *)TextView {
    return [CC_Base.shared cc_init:CC_TextView.class];
}

+ (CC_TextField *)TextField {
    return [CC_Base.shared cc_init:CC_TextField.class];
}

+ (CC_ImageView *)ImageView {
    return [CC_Base.shared cc_init:CC_ImageView.class];
}

+ (CC_ScrollView *)ScrollView {
    return [CC_Base.shared cc_init:CC_ScrollView.class];
}

+ (CC_TableView *)TableView {
    return [CC_Base.shared cc_init:CC_TableView.class];
}

+ (CC_TableView *)TableViewWithStyle:(UITableViewStyle)style {
    id obj = [cc_message cc_instance:CC_TableView.class method:@selector(alloc)];
    return [obj initWithFrame:CGRectZero style:style];
}

+ (CC_CollectionView *)CollectionView {
    id obj = [cc_message cc_instance:CC_CollectionView.class method:@selector(alloc)];
    UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
    CC_CollectionView *collection = [obj initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.cc_flowLayout = layout;
    return collection;
}

+ (CC_CollectionView *)CollectionViewWithLayout:(UICollectionViewLayout *)layout {
    id obj = [cc_message cc_instance:CC_CollectionView.class method:@selector(alloc)];
    CC_CollectionView *collection = [obj initWithFrame:CGRectZero collectionViewLayout:layout];
    return collection;
}

+ (CC_WebView *)WebView {
    return [CC_Base.shared cc_init:CC_WebView.class];
}

+ (CC_LabelGroup *)LabelGroup {
    return [CC_Base.shared cc_init:CC_LabelGroup.class];
}

+ (CC_Image *)image:(NSString *)imageName {
    return (CC_Image *)[CC_Image imageNamed:imageName];
}

+ (CC_TextAttachment *)textAttachment {
    return [CC_Base.shared cc_init:CC_TextAttachment.class];
}

+ (NSAttributedString *)attributedString {
    return [CC_Base.shared cc_init:NSAttributedString.class];
}

+ (NSMutableAttributedString *)mutableAttributedString {
    return [CC_Base.shared cc_init:NSMutableAttributedString.class];
}

// MARK: - CCUI Custom -
+ (CC_Mask *)Mask {
    return CC_Mask.shared;
}

+ (CC_Notice *)Notice {
    return CC_Notice.shared;
}

+ (void)show {
    [CC_Mask.shared start];
}

+ (void)dismiss {
    [CC_Mask.shared stop];
}

+ (void)showWithTitle:(NSString *)title {
    [cc_message cc_instance:CC_Notice.shared method:@selector(showNotice:) params:title];
}

+ (void)showWithTitle:(NSString *)title msg:(NSString *)msg
                 btns:(NSArray<NSString *> *)bts block:(void (^)(int, NSString *))block
         atController:(UIViewController *)controller {
    
    [cc_message cc_class:CC_Alert.class method:@selector(showAltOn:title:msg:bts:block:) params:controller,title,msg,bts,block];
}

+ (void)maskStart {
    [CC_Mask.shared start];
}

+ (void)maskStop {
    [CC_Mask.shared stop];
}

+ (void)maskStartAtView:(UIView *)view {
    [CC_Mask.shared startAtView:view];
}

+ (void)showNotice:(NSString *)str {
    [cc_message cc_instance:CC_Notice.shared method:@selector(showNotice:) params:str];
}

+ (void)showNotice:(NSString *)str atView:(UIView *)view {
    [cc_message cc_instance:CC_Notice.shared method:@selector(showNotice:atView:) params:str,view];
}

+ (void)showNotice:(NSString *)str atView:(UIView *)view delay:(int)delay {
    [cc_message cc_instance:CC_Notice.shared method:@selector(showNotice:atView:delay:) params:str,view,Int(delay)];
}

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block {
    [cc_message cc_class:CC_Alert.class method:@selector(showAltOn:title:msg:bts:block:) params:controller,title,msg,bts,block];
}

+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block {
    [cc_message cc_class:CC_Alert.class method:@selector(showTextFieldAltOn:title:msg:placeholder:bts:block:) params:controller,title,msg,placeholder,bts,block];
}

+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block {
    [cc_message cc_class:CC_Alert.class method:@selector(showTextFieldsAltOn:title:msg:placeholders:bts:block:) params:controller,title,msg,placeholders,bts,block];
}

@end
