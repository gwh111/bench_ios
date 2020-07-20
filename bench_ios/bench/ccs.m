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
#import <objc/runtime.h>

@implementation ccs

+ (BOOL)isDebug {
#if DEBUG
    return YES;
#endif
    return NO;
}

+ (void)configureEnvironment:(int)tag {
    CCLOG(@"\napp name:%@\napp version:%@",[ccs appName],[ccs appVersion]);
    CC_Base.shared.environment = tag;
}

+ (int)getEnvironment {
    return CC_Base.shared.environment;
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

+ (NSString *)stringValue:(id)value {
    return [NSString stringWithFormat:@"%@",value];
}

+ (NSString *)stringInt:(int)value {
    return [NSString stringWithFormat:@"%d",value];
}

+ (NSString *)stringFloat:(float)value {
    return [NSString stringWithFormat:@"%f",value];
}

+ (NSString *)stringDouble:(double)value {
    return [NSString stringWithFormat:@"%f",value];
}

+ (NSMutableString *)mutString {
    return [self init:[NSMutableString class]];
}
+ (NSMutableString *)mutString:(NSString *)format, ... {
    if (!format) {
        return @"".mutableCopy;
    }
    va_list ap;
    va_start (ap, format);
    NSMutableString *body = [[NSMutableString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    return body;
}

+ (NSArray *)array:(NSArray *)arr {
    if (!arr) {
        return [self init:[NSArray class]];
    }
    return [[NSArray alloc]initWithArray:arr];
}

+ (NSMutableArray *)mutArray {
    return [self init:[NSMutableArray class]];
}
+ (NSMutableArray *)mutArray:(NSMutableArray *)arr{
    if (!arr) {
        return [self init:[NSMutableArray class]];
    }
    return [[NSMutableArray alloc]initWithArray:arr];
}

+ (NSDictionary *)dictionary:(NSDictionary *)dic {
    if (!dic) {
        return [self init:[NSDictionary class]];
    }
    return [[NSDictionary alloc]initWithDictionary:dic];
}

+ (NSMutableDictionary *)mutDictionary {
    return [self init:[NSMutableDictionary class]];
}

+ (NSMutableDictionary *)mutDictionary:(NSMutableDictionary *)dic {
    if (!dic) {
        return [self mutDictionary];
    }
    return [[NSMutableDictionary alloc]initWithDictionary:dic];
}

+ (HttpModel *)httpModel {
    return [self init:HttpModel.class];
}

+ (CC_Money *)money {
    return [self init:CC_Money.class];
}

+ (CC_UI *)ui {
    return CC_UI.shared;
}

+ (CC_Tool *)tool {
    return CC_Tool.shared;
}

+ (CC_NavigationController *)navigation {
    return CC_NavigationController.shared;
}

+ (CC_SandboxStore *)sandbox {
    return CC_SandboxStore.shared;
}

+ (CC_Math *)math {
    return CC_Math.math;
}

+ (CC_CoreCrash *)coreCrash {
    return CC_CoreCrash.shared;
}

#pragma mark CC_UIKit
+ (UIColor *)primaryColor {
    return CC_CoreUI.shared.primaryColor;
}

+ (CC_CoreUI *)coreUI {
    return [cc_message cc_class:CC_CoreUI.class method:@selector(shared)];
}

+ (CGRect)screenRect {
    return self.coreUI.screenRect;
}

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
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeHeight:) params:CC_FLOAT(height)]floatValue];
}

+ (UIFont *)relativeFont:(float)fontSize {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeFont:) params:CC_FLOAT(fontSize)];
}

+ (UIFont *)relativeFont:(NSString *)fontName fontSize:(float)fontSize {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(relativeFont:fontSize:) params:fontName,CC_FLOAT(fontSize)];
}

+ (UIColor *)colorHexA:(NSString *)hex alpha:(float)alpha {
    return [cc_message cc_class:[UIColor class] method:@selector(cc_hexA:alpha:) params:hex,CC_FLOAT(alpha)];
}

+ (UIColor *)colorRgbA:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [cc_message cc_class:[UIColor class] method:@selector(cc_rgbA:green:blue:alpha:) params:CC_FLOAT(red),CC_FLOAT(blue),CC_FLOAT(green),CC_FLOAT(alpha)];
}

+ (NSString *)deviceName {
    return [cc_message cc_class:CC_Device.class method:@selector(deviceName)];
}

+ (id)getAView {
    return [cc_message cc_instance:CC_CoreUI.shared method:@selector(getAView) params:nil];
}

+ (id)getLastWindow {
    return CC_CoreUI.shared.getLastWindow;
}

+ (BOOL)isDarkMode {
    return [[cc_message cc_instance:CC_CoreUI.shared method:@selector(isDarkMode) params:nil]boolValue];
}

+ (void)setDeviceOrientation:(UIDeviceOrientation)orientation {
    [cc_message cc_instance:MXRotationManager.defaultManager method:@selector(setOrientationIndex:) params:[CC_Int value:orientation]];
}

+ (CC_ViewController *)currentVC {
    return [cc_message cc_instance:[self navigation] method:@selector(currentVC) params:nil];
}

+ (CC_TabBarController *)currentTabBarC {
    return [cc_message cc_instance:[self navigation] method:@selector(currentTabBarC) params:nil];
}

#pragma mark action
+ (void)pushViewController:(CC_ViewController *)viewController {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_pushViewController:) params:viewController];
}

+ (void)pushViewController:(CC_ViewController *)viewController animated:(BOOL)animated {
    [CC_NavigationController.shared cc_pushViewController:viewController animated:animated];
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

+ (void)popToRootViewControllerAnimated:(BOOL)animated {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_popToRootViewControllerAnimated:)params:CC_INT(animated)];
}

+ (void)pushWebViewControllerWithUrl:(NSString *)urlStr {
    [cc_message cc_instance:CC_NavigationController.shared method:@selector(cc_pushWebViewControllerWithUrl:) params:urlStr];
}

#pragma mark CC_LibNetwork
+ (CC_HttpTask *)httpTask {
    return CC_HttpTask.shared;
}

+ (CC_HttpHelper *)httpHelper {
    return CC_HttpHelper.shared;
}

+ (CC_HttpEncryption *)httpEncryption {
    return CC_HttpEncryption.new;
}

+ (CC_HttpConfig *)httpConfig {
    return CC_HttpConfig.new;
}

+ (void)clearAllMemoryWebImageCache:(void (^)(void))completionBlock {
    [CC_WebImageManager.shared clearAllMemoryWebImageCache:completionBlock];
}

+ (void)clearAllDiskWebImageCache:(void (^)(void))completionBlock {
    [CC_WebImageManager.shared clearAllDiskWebImageCache:completionBlock];
}

+ (void)clearAllWebImageCache:(void (^)(void))completionBlock {
    [CC_WebImageManager.shared clearAllWebImageCache:completionBlock];
}

+ (void)clearWebImageCacheForKey:(NSString *)url completionBlock:(void (^)(void))completionBlock {
    [CC_WebImageManager.shared clearWebImageCacheForKey:url completionBlock:completionBlock];
}

#pragma mark CC_LibStore
+ (NSString *)keychainValueForKey:(NSString *)name {
    return [CC_KeyChainStore keychainWithName:name];
}

+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value {
    [CC_KeyChainStore saveKeychainWithName:key str:value];
}

+ (NSString *)keychainUUID {
    return [CC_KeyChainStore keychainUUID];
}

+ (id)getDefault:(NSString *)key {
    return [CC_DefaultStore getDefault:key];
}

+ (id)defaultValueForKey:(NSString *)key {
    return [CC_DefaultStore getDefault:key];
}

+ (void)setDefault:(NSString *)key value:(id)value {
    [CC_DefaultStore saveDefault:key value:value];
}

+ (void)saveDefaultKey:(NSString *)key value:(id)value {
    [CC_DefaultStore saveDefault:key value:value];
}

+ (id)getSafeDefault:(NSString *)key {
    return [CC_DefaultStore getSafeDefault:key];
}

+ (id)safeDefaultValueForKey:(NSString *)key {
    return [CC_DefaultStore getSafeDefault:key];
}

+ (void)setSafeDefault:(NSString *)key value:(id)value {
    [CC_DefaultStore saveSafeDefault:key value:value];
}

+ (void)saveSafeDefaultKey:(NSString *)key value:(id)value {
    [CC_DefaultStore saveSafeDefault:key value:value];
}

+ (NSString *)appName {
    return [CC_BundleStore appName];
}

+ (NSString *)appBid {
    return [CC_BundleStore appBid];
}

+ (NSString *)appVersion {
    return [CC_BundleStore appVersion];
}

+ (NSString *)appBundleVersion {
    return [CC_BundleStore appBundleVersion];
}

+ (NSDictionary *)appBundle {
    return [CC_BundleStore appBundle];
}

+ (NSArray *)bundleFileNamesWithPath:(NSString *)name type:(NSString *)type {
    return [CC_BundleStore bundleFileNamesWithPath:name type:type];
}

+ (NSData *)bundleFileWithPath:(NSString *)name type:(NSString *)type {
    return [CC_BundleStore bundleFileWithPath:name type:type];
}

+ (NSDictionary *)bundlePlistWithPath:(NSString *)name {
    return [CC_BundleStore bundlePlistWithPath:name];
}

+ (BOOL)copyBundleFileToSandboxToPath:(NSString *)name type:(NSString *)type {
    return [CC_BundleStore copyBundleFileToSandboxToPath:name type:type];
}

+ (BOOL)copyBundlePlistToSandboxToPath:(NSString *)name {
    return [CC_BundleStore copyBundlePlistToSandboxToPath:name];
}

+ (UIImage *)bundleImage:(NSString *)imgName bundleName:(NSString *)bundleName {
    return [CC_BundleStore bundleImage:imgName bundleName:bundleName];
}

+ (UIImage *)benchBundleImage:(NSString *)imgName {
    return [CC_BundleStore benchBundleImage:imgName];
}

+ (NSString *)sandboxPath {
    return [self.sandbox documentsPath];
}

+ (NSArray *)sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type {
    return [self.sandbox documentsDirectoryFilesWithPath:name type:type];
}

+ (NSData *)sandboxFileWithPath:(NSString *)name type:(NSString *)type {
    return [self.sandbox documentsFileWithPath:name type:type];
}

+ (NSDictionary *)sandboxPlistWithPath:(NSString *)name {
    return [self.sandbox documentsPlistWithPath:name];
}

+ (void)deleteSandboxFileWithName:(NSString *)name {
    [self.sandbox deleteDocumentsFileWithName:name];
}

+ (BOOL)saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type {
    return [self.sandbox saveToDocumentsWithData:data toPath:name type:type];
}

+ (CC_DataBaseStore *)dataBaseStore {
    return [CC_DataBaseStore shared];
}

#pragma mark CC_LibAudio
+ (CC_Audio *)audio {
    return CC_Audio.shared;
}

#pragma mark CC_CoreFoundation
+ (id)init:(Class)aClass {
    id object = [CC_Base.shared cc_init:aClass];
    [cc_message cc_instance:object method:@selector(start)];
    return object;
}

+ (id)registerAppDelegate:(id)module {
    return [CC_Base.shared cc_registerAppDelegate:module];
}

+ (id)getAppDelegate:(Class)aClass {
    return [CC_Base.shared cc_getAppDelegate:aClass];
}

+ (id)registerSharedInstance:(id)shared {
    return [CC_Base.shared cc_registerSharedInstance:shared];
}

+ (id)registerSharedInstance:(id)shared block:(void(^)(void))block {
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

#pragma mark CC_CoreThread
+ (CC_Thread *)thread {
    return CC_Thread.shared;
}

+ (void)gotoThread:(void (^)(void))block {
    [self.thread gotoThread:block];
}

+ (void)gotoMain:(void (^)(void))block {
    [self.thread gotoMain:block];
}

+ (void)delay:(double)delayInSeconds block:(void (^)(void))block {
    [self.thread delay:delayInSeconds block:block];
}

+ (void)delay:(double)delayInSeconds key:(NSString *)key block:(void (^)(void))block {
    [self.thread delay:delayInSeconds key:key block:block];
}

+ (void)delayStop:(NSString *)key {
    [self.thread delayStop:key];
}

+ (void)threadGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish))block {
    [self.thread group:taskCount block:block];
}

+ (void)threadBlockSequence:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block {
    [self.thread blockSequence:taskCount block:block];
}

+ (void)threadBlockGroup:(NSUInteger)taskCount block:(void(^)(NSUInteger taskIndex, BOOL finish, id sema))block {
    [self.thread blockGroup:taskCount block:block];
}

+ (void)threadBlockFinish:(id)sema {
    [self.thread blockFinish:sema];
}

#pragma mark CC_CoreTimer
+ (CC_Timer *)timer {
    return CC_Timer.shared;
}

+ (void)timerRegister:(NSString *)name interval:(float)interval block:(void (^)(void))block {
    [self.timer registerT:name interval:interval block:block];
}

+ (void)timerCancel:(NSString *)name {
    [self.timer unRegisterT:name];
}

+ (NSString *)uniqueNowTimestamp {
    return self.timer.uniqueNowTimestamp;
}

+ (NSString *)nowTimeTimestamp {
    return self.timer.nowTimeTimestamp;;
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

+ (CC_StrokeLabel *)StrokeLabel {
    return [CC_Base.shared cc_init:CC_StrokeLabel.class];
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
    return [self init:CC_WebView.class];
}

+ (CC_LabelGroup *)LabelGroup {
    return [self init:CC_LabelGroup.class];
}

+ (CC_TextAttachment *)textAttachment {
    return [self init:CC_TextAttachment.class];
}

+ (NSAttributedString *)attributedString {
    return [self init:NSAttributedString.class];
}

+ (NSMutableAttributedString *)mutableAttributedString {
    return [self init:NSMutableAttributedString.class];
}

// MARK: - CCUI Custom -
+ (CC_Mask *)mask {
    return CC_Mask.shared;
}

+ (CC_Notice *)notice {
    return CC_Notice.shared;
}

+ (CC_Alert *)alert {
    return CC_Alert.new;
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
    [self.notice showNotice:str];
}

+ (void)showNotice:(NSString *)str atView:(UIView *)view {
    [self.notice showNotice:str atView:view];
}

+ (void)showNotice:(NSString *)str atView:(UIView *)view delay:(int)delay {
    [self.notice showNotice:str atView:view delay:delay];
}

+ (void)showAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg bts:(NSArray *)bts block:(void (^)(int index, NSString *name))block {
    [self.alert showAltOn:controller title:title msg:msg bts:bts block:block];
}

+ (void)showTextFieldAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholder:(NSString *)placeholder bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSString *text))block {
    [self.alert showTextFieldAltOn:controller title:title msg:msg placeholder:placeholder bts:bts block:block];
}

+ (void)showTextFieldsAltOn:(UIViewController *)controller title:(NSString *)title msg:(NSString *)msg placeholders:(NSArray *)placeholders bts:(NSArray *)bts block:(void (^)(int index, NSString *name, NSArray *texts))block {
    [self.alert showTextFieldsAltOn:controller title:title msg:msg placeholders:placeholders bts:bts block:block];
}

@end
