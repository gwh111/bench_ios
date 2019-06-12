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

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#define COLOR_BLACK [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]
#define COLOR_WHITE [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]
#define COLOR_CLEAR [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0]

#define COLOR_LIGHT_GREEN [UIColor colorWithRed:107/255.0f green:221/255.0f blue:123/255.0f alpha:1]
#define COLOR_LIGHT_BLUE [UIColor colorWithRed:62/255.0f green:188/255.0f blue:202/255.0f alpha:1]
#define COLOR_LIGHT_ORANGE [UIColor colorWithRed:223/255.0f green:142/255.0f blue:57/255.0f alpha:1]
#define COLOR_LIGHT_PURPLE [UIColor colorWithRed:211/255.0f green:53/255.0f blue:226/255.0f alpha:1]
#define COLOR_LIGHT_RED [UIColor colorWithRed:247/255.0f green:126/255.0f blue:129/255.0f alpha:1]
#define COLOR_LIGHT_YELLOW [UIColor colorWithRed:255/255.0f green:251/255.0f blue:152/255.0f alpha:1]
#define COLOR_LIGHT_PINK [UIColor colorWithRed:255/255.0f green:174/255.0f blue:233/255.0f alpha:1]

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

#import "CC_Validate.h"
#import "CC_Image.h"
#import "CC_Button.h"
#import "CC_Label.h"
#import "CC_AttributedStr.h"
#import "CC_DES.h"
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
#import "CC_Notice.h"
#import "CC_View.h"
#import "CC_TextField.h"
#import "CC_TextView.h"
#import "CC_ImageView.h"
#import "CC_WebView.h"

#import "CC_LogicClass.h"
#import "CC_Date.h"
#import "CC_Parser.h"
#import "CC_Animation.h"
#import "CC_MusicBox.h"
#import "CC_RequestRecordTool.h"
#import "CC_UIAtom.h"
#import "Classy.h"
#import "CC_ClassyExtend.h"
#import "UINavigationController+CCHook.h"
#import "CC_HookTrack.h"
#import "CC_Dictionary.h"
#import "CC_AES.h"
#import "CC_RSA.h"
#import "CC_ObjectModel.h"

#import "UIView+ClassyCat.h"
#import "UIControl+CCCat.h"
#import "UIImage+CCCat.h"
#import "UIButton+CCCat.h"
#import "NSString+CCCat.h"
#import "NSMutableDictionary+CCCat.h"
#import "NSDictionary+CCCat.h"
#import "NSObject+CCCat.h"
#import "NSDate+CCCat.h"
#import "UIView+CCCat.h"

#import "UIApplication+CCHook.h"
#import "UIViewController+CCHook.h"

#import "UIView+CCLayout.h"
#import "CC_TManager.h"
#import "CC_Mask.h"
#import "CC_Loading.h"
#import "CC_Alert.h"

@interface CC_Share : NSObject

@property (nonatomic,assign) BOOL ccDebug;
@property (nonatomic,retain) NSString *aesKey;

@property (nonatomic,retain) NSString *currentUniqueTimeStamp;
@property (nonatomic,assign) int currentUniqueTimeStampCount;

@property (nonatomic,assign) float acceptEventInterval;

+ (instancetype)getInstance;
+ (void)getUpdate;

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
+ (NSString *)getBundleVersion;

/**
 *  获取沙盒路径
 */
+ (NSString *)getSandboxPath;
/**
 *  获取文件列表
    type 筛选文件类型
    directory 路径 从工程文件夹内开始 如在工程中添加了model文件夹 要取里面的文件就填model
    注意需要蓝色Folder References文件夹
 */
+ (NSArray *)getPathsOfType:(NSString *)type inDirectory:(NSString *)directory;

/**
 *  存储keychain的字段
 *  在app删除再重新安装后依然可以获取
    KeychainName一般使用appbid
 */
+ (void)saveKeychainName:(NSString *)key str:(NSString *)str;
/**
 *  根据name获取keychain里的字段 可能获取为空
 */
+ (NSString *)getKeychainName:(NSString *)str;
/**
 *  获取一个唯一UUID并存储到keychain 不会为空
 */
+ (NSString *)getKeychainUUID;

/**
 *  获取项目中一个文件的文本
 */
+ (NSString *)getFileWithPath:(NSString *)name andType:(NSString *)type;

/**
 *  获取沙盒中一个文件的文本
 */
+ (NSString *)getLocalFileWithPath:(NSString *)name andType:(NSString *)type;

/**
 *  获取沙盒中一个文件夹的文件
 */
+ (NSArray *)getLocalFileListWithDocumentName:(NSString *)name withType:(NSString *)type;

/**
 *  直接获取工程中的plist
 */
+ (NSString *)getPlistStr:(NSString *)name;
+ (NSDictionary *)getPlistDic:(NSString *)name;

/**
 *  获取沙盒中的plist
 */
+ (NSMutableDictionary *)getLocalPlistNamed:(NSString *)name;
/**
 *  保存沙盒中的plist
    保存时先查找沙盒中是否有该plist，如果有读取并更新，如果没有，找工程中有无plist，如果有则复制一份并更新保存到沙盒，如果无则初始化一个并更新保存到沙盒
 */
+ (void)saveLocalPlistNamed:(NSString *)name;
/**
 *  从沙盒移除plist
 */
+ (void)removeLocalPlistNamed:(NSString *)name;
/**
 *  获取沙盒里plist中某一字段值
 */
+ (id)getLocalKeyNamed:(NSString *)name andKey:(NSString *)key;
/**
 *  新建一个NSDictionary保存到沙盒
    path 是Documents后文件夹 如没有传nil 如文件夹不存在创建一个
 */
+ (NSString *)saveLocalKeyNamed:(NSString *)name andKey:(NSString *)key andValue:(id)value;
/**
 *  保存文件到沙盒
 */
+ (NSString *)saveLocalFile:(id)data withPath:(NSString *)name andType:(NSString *)type;

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
 *  归档
 *  用在将对象转换为NSData
 */
+ (NSData *)copyToData:(id)object;
/**
 *  归档恢复为对象
 *  用在将NSData转换为对象
 */
+ (id)dataToObject:(id)data;

/**
 *  快速复制
 */
+ (id)copyThis:(id)object;

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
/**
 *  判断是否为空或没有数据
 */
+ (BOOL)isEmpty:(id)obj;

@end

