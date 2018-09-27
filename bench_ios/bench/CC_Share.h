//
//  CC_Share.h
//  bench_ios
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 apple. All rights reserved.
//

/*
 platform :ios, '8.0'
 #use_frameworks!个别需要用到它，比如reactiveCocoa
 inhibit_all_warnings!
 
 target 'xxx' do
     pod 'bench_ios'
 end
 */

#ifdef TARGET_IPHONE_SIMULATOR
//XXXXX  模拟器时会编译的代码
#else
//XXXXX  不是模拟器才会编译的代码
#endif

#ifdef DEBUG
#   define CCLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CCLOG(...)
#endif

#define COLOR_BLACK [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]
#define COLOR_WHITE [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define COLOR_CLEAR [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0]

#define ccRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ccRGBHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ccRGBHexA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define ccVarStr(var) [NSString stringWithFormat:@"%s",#var]
#define ccVarStr1(var) @#var

#import <Foundation/Foundation.h>

#import "CC_Valiation.h"
#import "CC_Image.h"
#import "CC_Button.h"
#import "CC_Label.h"
#import "CC_AttributedStr.h"
#import "CC_DESTool.h"
#import "CC_UIViewExt.h"
#import "CC_UIHelper.h"
#import "CC_CodeClass.h"
#import "CC_Array.h"
#import "CC_GCoreDataManager.h"
#import "CC_GColor.h"
#import "CC_Envirnment.h"
#import "PlatformConfig.h"
#import "CC_HttpResponseModel.h"
#import "CC_GHttpSessionTask.h"
#import "CC_Note.h"
#import "CC_View.h"
#import "CC_TextField.h"
#import "CC_TextView.h"
#import "CC_LogicClass.h"
#import "CC_Date.h"
#import "CC_Parser.h"
#import "CC_Animation.h"
#import "CC_MusicBox.h"
#import "CC_RequestRecordTool.h"
#import "CC_UIAtom.h"
#import "Classy.h"
#import "CC_ClassyExtend.h"
#import "UIView+ClassyExtend.h"
#import "UIView+CCLayout.h"
#import "UIApplication+CCHook.h"
#import "UIViewController+CCHook.h"
#import "UINavigationController+CCHook.h"
#import "CC_HookTrack.h"
#import "CC_Dictionary.h"
#import "UIButton+CCExtention.h"
#import "CC_AESEncrypt.h"

@interface CC_Share : NSObject

@property (nonatomic,assign) BOOL ccDebug;
@property (nonatomic,retain) NSString *aesKey;

+ (instancetype)getInstance;

@end

#pragma mark
@interface ccs : NSObject

/**
 *  获取Bundle字典
 */
+ (NSDictionary *)getBundle;

/**
 *  获取CFBundleIdentifier
    获取CFBundleShortVersionString
 */
+ (NSString *)getBid;
+ (NSString *)getVersion;

/**
 *  存储keychain的字段
 *  在app删除再重新安装后依然可以获取
 */
+(void)saveKeychainName:(NSString *)key str:(NSString *)str;
+(NSString *)getKeychainName:(NSString *)str;

/**
 *  直接获取工程中的plist
 */
+ (NSString *)getPlistStr:(NSString *)name;
+ (NSDictionary *)getPlistDic:(NSString *)name;

/**
 *  + (NSMutableDictionary *)getLocalPlistNamed:(NSString *)name;
    获取和保存沙盒中的plist
    + (void)saveLocalPlistNamed:(NSString *)name;
    保存时先查找沙盒中是否有该plist，如果有读取并更新，如果没有，找工程中有无plist，如果有则复制一份并更新保存到沙盒，如果无则初始化一个并更新保存到沙盒
    + (void)removeLocalPlistNamed:(NSString *)name;
    删除时注意要加上文件名后缀
 */
+ (NSMutableDictionary *)getLocalPlistNamed:(NSString *)name;
+ (void)saveLocalPlistNamed:(NSString *)name;
+ (void)removeLocalPlistNamed:(NSString *)name;
+ (id)getLocalKeyNamed:(NSString *)name andKey:(NSString *)key;
+ (void)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value;

/**
 *  获取NSUserDefaults
 */
+ (id)getDefault:(NSString *)key;
+ (void)saveDefaultKey:(NSString *)key andV:(id)v;

/**
 *  安全的保存 需要设置aesKey
 */
+ (id)getSafeDefault:(NSString *)key;
+ (void)saveSafeDefaultKey:(NSString *)key andV:(id)v;

/**
 *  快速打印
 */
NSString *ccstr(NSString *format, ...);

/**
 *  快速复制
 */
+ (id)copyThis:(id)bt;

/**
 *  进入子线程
 */
+ (void)gotoThread:(void (^)(void))block;
/**
 *  回到主线程
 */
+ (void)gotoMain:(void (^)(void))block;
/**
 *  延时、延迟
 */
+ (void)delay:(double)delayInSeconds block:(void (^)(void))block;

@end

