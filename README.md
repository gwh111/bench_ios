# bench_ios
<img src="https://github.com/gwh111/bench_ios/blob/master/bench_ios/icon.png" width="140">

### Podfile

To integrate bench_ios into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'bench_ios'
end
```

Then, run the following command:

```bash
$ pod install
```
========  

解析文章https://blog.csdn.net/gwh111/article/details/100700830

使用只需一步，在.pch文件或需要的地方引入

```
import "ccs.h"
```
模式是核心，工具是基础的扩展

# 模式类使用方法


## ccs调度中心介绍
ccs有最高调度权限，没有管理权限。管理由各个模块各自管理，分布式架构，ccs可以获取访问权限。

使用者只需按需调用上层，具体的实现不需要关心，如果需要添加未实现方法或者现有方法不能满足，可以联系维护bench小伙伴

### 模板使用
参考XcodeCustom文件夹下README.md
包括工程模板和类模板

## AppDelegate使用方法
main函数入口

```
#import <UIKit/UIKit.h>

int main(int argc, char * argv[]) {
@autoreleasepool {
return UIApplicationMain(argc, argv, nil, @"CC_AppDelegate");
}
}
```

新建AppDelegate继承CC_AppDelegate获得控制权限，CC_AppDelegate之后也会分发代理函数给子模块。

```
#import "CC_AppDelegate.h"

@interface AppDelegate : CC_AppDelegate

@end
```
```
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load{
[ccs registerAppDelegate:self];
}

- (void)cc_willInit {
// 配置函数 在此函数中添加初始化配置
[ccs configureAppStandard:@{
YL_SUBTITLE_FONT  :RF(13),
YL_SUBTITLE_COLOR :UIColor.whiteColor
}];

CCLOG(@"%@",APP_STANDARD(YL_SUBTITLE_FONT));

//入口单页面
//    [self cc_init:HomeVC.class withNavigationBarHidden:YES block:^{
//        [self launch];
//    }];

//入口TabBar
[self cc_init:TestTabBarController.class withNavigationBarHidden:YES block:^{
[self launch];
}];
}

#pragma mark life circle
- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//当程序载入后执行，应用程序启动入口
return YES;
}

- (void)cc_applicationWillResignActive:(UIApplication *)application {
//应用程序将要进入非活动状态，即将进入后台
}

- (void)cc_applicationDidEnterBackground:(UIApplication *)application {
//应用程序已经进入后台运行
}

- (void)cc_applicationWillEnterForeground:(UIApplication *)application {
//应用程序将要进入活动状态，即将进入前台运行
}

- (void)cc_applicationDidBecomeActive:(UIApplication *)application {
//应用程序已进入前台，处于活动状态
}

- (void)cc_applicationWillTerminate:(UIApplication *)application {
//应用程序将要退出，通常用于保存数据和一些退出前的清理工作
}

@end
```
## TabBarController使用方法
```
#import "TestTabBarController.h"
#import "HomeVC.h"
#import "ccs.h"

@interface TestTabBarController ()

@end

@implementation TestTabBarController

- (void)cc_viewDidLoad {
self.view.backgroundColor = UIColor.whiteColor;
// 纯图片 tabbar
//    [self cc_initWithClasses:@[HomeVC.class,UIViewController.class]
//                      images:@[@"tabbar_mine_high",@"tabbar_mine_high"]
//              selectedImages:@[@"tabbar_mine_high",@"tabbar_mine_high"]];
// 图片 + 文字 tabbar
[self cc_initWithClasses:@[HomeVC.class,UIViewController.class]
titles:@[@"首页",@"首页"]
images:@[@"tabbar_mine_high",@"tabbar_mine_high"]
selectedImages:@[@"tabbar_mine_high",@"tabbar_mine_high"]
titleColor:UIColor.blackColor
selectedTitleColor:UIColor.blueColor];

//    [self cc_addTabBarItemWithClass:UIViewController.class
//                              image:@"tabbar_mine_high"
//                      selectedImage:@"tabbar_mine_high"
//                              index:2];

[self cc_addTabBarItemWithClass:UIViewController.class
title:@"我的"
image:@"tabbar_mine_high"
selectedImage:@"tabbar_mine_high"
index:2];

[self cc_updateBadgeNumber:200 atIndex:2];
}
```
## ViewController使用方法

ViewController继承CC_ViewController，cc_baseView进行自定义绘制。针对ViewController业务复杂，存在ABC多个模块时，继承CC_Controller委托代理进行业务拆分，模块共享。

原来模板新建 ViewController .h文件

```
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
```
新模板新建 ViewController .h文件

```
#import "CC_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestNewViewController : CC_ViewController

@end

NS_ASSUME_NONNULL_END
```
原来模板新建 ViewController .m文件

```
#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
[super viewDidLoad];
// Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

@end
```
新模板新建 ViewController .m文件

```
#import "TestNewViewController.h"

@interface TestNewViewController ()

@end

@implementation TestNewViewController

- (void)cc_viewWillLoad {
// Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

@end
```
包含哪些方法可以具体查看

```
#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_View.h"
#import "CC_Controller.h"

@class CC_View,CC_Controller;

@interface CC_ViewController : UIViewController

@property (nonatomic,retain) CC_View *cc_baseView;
@property (nonatomic,retain) NSMutableArray *cc_controllers;

// Configuration function, adds configuration to this function
// 配置函数 在此函数中添加配置
- (void)cc_viewWillLoad;
- (void)cc_registerController:(Class)class;

// Function used in controller
// 功能函数 在控制器使用
- (void)cc_addSubview:(id)view;
- (CC_View *)cc_viewWithName:(NSString *)name;
- (void)cc_removeViewWithName:(NSString *)name;
- (CC_Controller *)cc_controllerWithName:(NSString *)name;

// Trigger function, triggering after the condition of trigger function is reached
// 触发函数 条件达到后触发
- (void)cc_viewDidLoad;
- (void)cc_viewWillAppear;
- (void)cc_viewWillDisappear;
- (void)cc_didReceiveMemoryWarning;
- (void)cc_dealloc;
```
## Controller使用方法
需要拆分的模块继承CC_Controller实现自身代理。控制器初始化注册代理类，实现代理方法。
CC_Controller通过start()函数初始化，我们在CC_Controller中方便地提供了代理，通过代理分发回调到CC_ViewController来交互，传统方法需要声明代理，以及响应判断。

将原来要写的代码：

```
// 属性声明
@property(nonatomic,assign) id <CC_LabelGroupDelegate>delegate;

// 代理
if ([self.delegate respondsToSelector:@selector(labelGroup:initWithButton:)]) {
[self.delegate labelGroup:self initWithButton:button];
}
```

变成直接代理：

```
#import "CC_Foundation.h"
#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TestControllerDelegate

- (void)methd2withA:(NSString *)a b:(NSArray *)b;

@end

@interface TestController : CC_Controller

@end

NS_ASSUME_NONNULL_END
```
```
#import "TestController.h"

@implementation TestController

- (void)cc_start {
// 初始化配置
self.cc_name = @"test1";
[ccs delay:2 block:^{
// 初始化配置完成
[self.cc_delegate cc_performSelector:@selector(methd2withA:b:) params:@"",@""];
}];
}

@end
```
在对应的CC_ViewController中便可接收到此方法

```
#import "TestViewController.h"
#import "TestController.h"
#import "ccs.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)methd2withA:(NSString *)a b:(NSArray *)b{
// TestController里的协议
CCLOG(@"callback methd2withA");
}

- (void)cc_viewWillLoad {
//  注册完可直接实现TestController里的协议'methd2withA:b:'
[self cc_registerController:TestController.class];
}

- (void)cc_viewDidLoad {
}
```

## Model使用方法
继承CC_Model添加自定义变量，同时支持replaced Key From Property Name

```
@interface Test_model : CC_Model

@property (nonatomic, copy) NSString *str1;

@property (nonatomic, copy) NSString *str2;

@end
```

```
@implementation Test_model

- (void)cc_update
{
CCLOG(@"update Test_model key value %@",self.cc_modelDic);
}

@end
```

```
Test_model *modelObj = [ccs model:[Test_model class]];
[modelObj cc_setProperty:@{@"str1":@"xin",@"str2":@"yi"}];
[modelObj cc_update];

//replace Property name 
[modelObj cc_setProperty:@{@"str1":@"xin",@"id":@"b"} modelKVDic:@{@"str2":@"id"}];
[modelObj cc_update];
```
## UIKit使用方法

```
UILabel *label = [[UILabel alloc] init];
label.text = @"mylabel";
label.frame = CGRectMake(RH(10),RH(100),RH(100),RH(100));
label.backgroundColor = HEXA(@"FFD700", 1);
```
```
//省去变量名，通过链式返回对象扩展书写
ccs.label
.cc_name(@"mylabel")
.cc_frame(RH(10),RH(100),RH(100),RH(100))
.cc_backgroundColor(HEXA(@"FFD700", 1));
```
### Alert
```
//系统弹窗 
- (void)test_Alert
{
[ccs showAltOn:self title:@"haha" msg:@"你猜" bts:@[@"取消",@"确定"] block:^(int index, NSString *name) {
CCLOG(@"showAlert index = %d btn name = %@",index,name);
}];

[ccs showTextFieldAltOn:self title:@"haha" msg:@"你猜" placeholder:@"猜不着" bts:@[@"取消",@"确定",@"ok"] block:^(int index, NSString *name, NSString *text) {
CCLOG(@"showTextFieldsAlert index = %d btn name = %@",index,name);
}];

[ccs showTextFieldsAltOn:self title:@"haha" msg:@"你猜" placeholders:@[@"猜",@"不",@"着"] bts:@[@"取消",@"确定",@"ok"] block:^(int index, NSString *name, NSArray *texts) {
CCLOG(@"showTextFieldsAlert index = %d btn name = %@ textFields text array = %@",index,name,texts);
}];
}
```
### app标准使用方法
```
//App Font And Color Standard
#define HEADLINE_FONT     @"HEADLINE_FONT"
#define HEADLINE_COLOR    @"HEADLINE_COLOR"
#define TITLE_FONT        @"TITLE_FONT"
#define TITLE_COLOR       @"TITLE_COLOR"
#define CONTENT_FONT      @"CONTENT_FONT"
#define CONTENT_COLOR     @"CONTENT_COLOR"
#define DATE_FONT         @"DATE_FONT"
#define DATE_COLOR        @"DATE_COLOR"
#define MASTER_COLOR      @"MASTER_COLOR"
#define AUXILIARY_COLOR   @"AUXILIARY_COLOR"

//针对工程添加自定义标准 如医疗项目
#define YL_SUBTITLE_FONT     @"YL_SUBTITLE_FONT"
#define YL_SUBTITLE_COLOR    @"YL_SUBTITLE_COLOR"

[ccs configureAppStandard:@{
YL_SUBTITLE_FONT  :RF(13),
YL_SUBTITLE_COLOR :UIColor.whiteColor
}];

CCLOG(@"%@",APP_STANDARD(YL_SUBTITLE_FONT));
```
### 自动适配使用方法
```
所有布局的数字包一层RH()函数，如 CGRectMake(0, 0, RH(200), RH(40)
float x = RH(30)
font = RF(14);
```
### textBind使用方法
```
//数据和视图绑定
// 绑定string
NSString *str = [ccs string:@"abc%@%d",@"a",34];
// 方法三
ccs.label
.cc_name(@"mylabel")
.cc_frame(RH(10),RH(100),RH(100),RH(100))
.cc_backgroundColor(HEXA(@"FFD700", 1))
.cc_textColor(HEXA(@"9B30FF", 1))
.cc_bindText(str)
.cc_addToView(self)
.cc_tappedInterval(0.1,^(id view) {
// 改变labele内的富文本
NSMutableAttributedString *att = [ccs mutAttributedString];
[att cc_appendAttStr:@"abc" color:COLOR_LIGHT_ORANGE];
[att cc_appendAttStr:@"123" color:[UIColor greenColor] font:RF(22)];
CC_Label *v = view;
v.attributedText = att;
// 延时5秒后退出控制器
[ccs delay:5 block:^{
[ccs popViewController];
}];
});

// 3秒后更新string view跟踪变化
[ccs delay:3 block:^{
// 无需获取控件，更新数据源自动更新视图控件
[str cc_update:@"cvb"];
}];
```

如果我们在控制器的另一个函数中要获取控件对象，我们可以声明它为全局变量或者属性：

```
@interface TestViewController () {
UILabel *label;
}
@end
```
或者使用viewWithTag()来取对象，但用tag会很不方便，如果要直观还需将tag声明成static，所以我们提供了viewWithName()的函数来取对象：

```
- (void)funtionB {
id v = [self cc_viewWithName:@"abc"];
}
```
## 单例使用方法

```
+ (instancetype)shared{
return [ccs registerSharedInstance:self];
}
```
```
+ (instancetype)shared {
return [ccs registerSharedInstance:self block:^{
//do something init
}];
}
```

## 共享数据使用方法
```
// data sharing, shared data in app, such as update a model in controller A when you are in controller B
// app共享的数据存储 如在控制器B更新控制器A里的model
//+ (id)shared:(NSString *)key;
//+ (id)removeShared:(NSString *)key;
//+ (id)setShared:(NSString *)key obj:(id)obj;
//+ (id)resetShared:(NSString *)key obj:(id)obj;

[ccs setShared:@"name" obj:@"xinyi"];
id obj = [ccs shared:@"name"];
```

## 多线程使用方法
```
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
```
```
#import "TestThread.h"

@implementation TestThread

+ (void)start{

// 一组异步任务 在多个线程执行
if ((1)) {
CCLOG(@"cc_group %@",[NSThread currentThread]);
[ccs threadGroup:3 block:^(NSUInteger taskIndex, BOOL finish) {
if (taskIndex==0) {
CCLOG(@"cc_group 0 finish %d %@",finish,[NSThread currentThread]);
}else if (taskIndex==1){
CCLOG(@"cc_group 1 finish %d %@",finish,[NSThread currentThread]);
}else if (taskIndex==2){
CCLOG(@"cc_group 2 finish %d %@",finish,[NSThread currentThread]);
}else{
CCLOG(@"cc_group 3 finish %d %@",finish,[NSThread currentThread]);
}
}];
}

// 异步完成一组有异步回调的函数后执行下一个函数
if ((1)) {
CCLOG(@"cc_blockGroup %@",[NSThread currentThread]);
[ccs threadBlockGroup:2 block:^(NSUInteger taskIndex, BOOL finish, id sema) {
if (taskIndex==0) {
CCLOG(@"cc_blockGroup 0 %@",[NSThread currentThread]);
[ccs delay:10 block:^{
[ccs threadBlockFinish:sema];
}];
}else if (taskIndex==1){
CCLOG(@"cc_blockGroup 1 %@",[NSThread currentThread]);
[ccs delay:2 block:^{
[ccs threadBlockFinish:sema];
}];
}
if (finish) {
CCLOG(@"cc_blockGroup finish %@",[NSThread currentThread]);
}
}];
}

// 顺序执行一组有异步回调的函数后执行下一个函数
if ((0)) {
CCLOG(@"cc_blockSequence %@",[NSThread currentThread]);
[ccs threadBlockSequence:2 block:^(NSUInteger taskIndex, BOOL finish, id  _Nonnull sema) {
if (taskIndex==0) {
CCLOG(@"cc_blockSequence 0 %@",[NSThread currentThread]);
[ccs delay:5 block:^{
[ccs threadBlockFinish:sema];;
}];
} else if (taskIndex==1) {
CCLOG(@"cc_blockSequence 1 %@",[NSThread currentThread]);
[ccs delay:2 block:^{
[ccs threadBlockFinish:sema];;
}];
}
if (finish) {
CCLOG(@"cc_blockSequence finish %@",[NSThread currentThread]);
}
}];

}

}

@end
```
## 定时器使用方法
```
#pragma mark CC_CoreTimer
+ (void)timerRegister:(NSString *)name interval:(float)interval block:(void (^)(void))block;
+ (void)timerCancel:(NSString *)name;

+ (NSString *)uniqueNowTimestamp;
+ (NSString *)nowTimeTimestamp;
```
```
- (void)test_foundationCoreTimer
{
//CoreTimer
[ccs timerRegister:@"testTimer1" interval:1 block:^{
CCLOG(@"CoreTimer block 1 ");
}];
[ccs timerRegister:@"testTimer2" interval:2 block:^{
CCLOG(@"CoreTimer block 2 ");
}];
[ccs timerRegister:@"testTimer3" interval:5 block:^{
CCLOG(@"CoreTimer block 3 ");
}];

[ccs timerCancel:@"testTimer2"];

CCLOG(@"CoreTimer uniqueNowTimestamp %@",[ccs uniqueNowTimestamp]);
CCLOG(@"CoreTimer nowTimeTimestamp %@",[ccs nowTimeTimestamp]);
}
```

## 组件化生命周期分发使用方法


## 组件化分类使用方法


# 工具类使用方法

## Monitor使用方法
```
目前CC_Monitor的几大功能是：
1、监控app本身和组件的生命周期（包括耗时和内存）。
2、监控app运行时的异常（包括耗时、内存和异常）。
#pragma mark monitor
// 启动监控 默认开启
+ (void)openLaunchMonitor:(BOOL)open;
// 启动监控日志 默认开启
+ (void)openLaunchMonitorLog:(BOOL)open;
// 定期检查 默认开启
+ (void)openPatrolMonitor:(BOOL)open;
// 定期检查日志 默认关闭
+ (void)openPatrolMonitorLog:(BOOL)open;
```
## 网络请求使用方法
```
// CC_CommonConfig.xcconfig
// CC_ReleaseConfig.xcconfig
// CC_TrunkConfig.xcconfig
// CC_Branch1Config.xcconfig
// ...
// GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
// CCBUILDTAG=0
// #include "CC_CommonConfig.xcconfig"
/** @[@[线上地址1,线上地址2...], @[主干地址1,主干地址2...], @[分支1地址1,分支1地址2...] ...] */
// + (void)configureDomainWithReqGroupList:(NSArray *)domainReqList andKey:(NSString *)domainReqKey cache:(BOOL)cache pingTest:(BOOL)pingTest block:(void (^)(HttpModel *result))block;

//network config
[ccs configureDomainWithReqGroupList:@[@[@"http://sssynout-eh-resource.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.kkjk123.com/eh_url.txt"],@[@"http://test-onlinetreat.oss-cn-hangzhou.aliyuncs.com/URL/eh_url.txt", @"http://dynamic.onlinetreat.net/eh_url.txt"]]
andKey:@"eh_doctor_api"
cache:NO
pingTest:YES
block:^(HttpModel *result) {

HttpModel *model = [[HttpModel alloc]init];
model.forbiddenJSONParseError = YES;
[ccs.httpTask get:@"https://www.jianshu.com/p/a1ec0db3c710" params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {

}];

}];
```
### http请求使用方法
```
- (void)post:(id)url params:(id)paramsDic model:(HttpModel *)model finishBlock:(void (^)(NSString *error, HttpModel *result))block;

- (void)get:(id)url params:(id)paramsDic model:(HttpModel *)model finishBlock:(void (^)(NSString *error, HttpModel *result))block;
```
### 图片上传使用方法
```
/**
上传多张图片-指定图片压缩比例
@param images 图片数组
@param url URL
@param paramsDic 参数
@param imageScale 上传图片缩放比例
@param times 上传失败-重新上传次数
@param uploadImageBlock 回调函数
*/
- (void)imageUpload:(NSArray<id> *)images
url:(id)url
params:(id)paramsDic
imageScale:(CGFloat)imageScale
reConnectTimes:(NSInteger)times
finishBlock:(void (^)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr))uploadImageBlock;

/**
上传多张图片-指定图片大小 单位 兆
@param images 图片数组
@param url URL
@param paramsDic 参数
@param imageSize 指定图片大小 单位 兆
@param times 上传失败-重新上传次数
@param uploadImageBlock 回调函数
*/
- (void)imageUpload:(NSArray<id> *)images
url:(id)url
params:(id)paramsDic
imageSize:(NSUInteger)imageSize
reConnectTimes:(NSInteger)times
finishBlock:(void (^)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr))uploadImageBlock;

```
### 文件上传使用方法
### 下载图片使用方法
### 加密使用方法

## 数据存储使用方法
CC_Lib/CC_LibStorage 具体使用见Test_LibViewController
> CC_KeyChainStore 钥匙串存储
> CC_DefaultStore  NSUserDefaults
> CC_BundleStore  NSBundle
> CC_SandboxStore 沙盒 Documents 存储
> CC_GCoreDataManager

```
#pragma mark CC_LibStorage
//KeyChainStore
+ (NSString *)keychainKey:(NSString *)name;
+ (void)saveKeychainKey:(NSString *)key value:(NSString *)value;
+ (NSString *)keychainUUID;

//NSUserDefaults
+ (id)defaultKey:(NSString *)key;
+ (void)saveDefaultKey:(NSString *)key value:(id)value;

+ (id)safeDefaultKey:(NSString *)key;
+ (void)saveSafeDefaultKey:(NSString *)key value:(id)value;

//NSBundle
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

//沙盒 Documents 存储
+ (NSString *)sandboxPath;
+ (NSArray *)sandboxDirectoryFilesWithPath:(NSString *)name type:(NSString *)type;

+ (NSData *)sandboxFileWithPath:(NSString *)name type:(NSString *)type;
+ (NSDictionary *)sandboxPlistWithPath:(NSString *)name;

+ (BOOL)deleteSandboxFileWithName:(NSString *)name;
+ (BOOL)saveToSandboxWithData:(id)data toPath:(NSString *)name type:(NSString *)type;
```

## 音频使用方法

## 动画使用方法
```
// 不停闪烁
// [noteTextV.layer addAnimation:[CC_Animation cc_flickerForever:.5] forKey:nil];
+ (CABasicAnimation *)cc_flickerForever:(float)time;

// 按钮点击放大动画
// [CC_Animation cc_buttonTapEnlarge:checkBt];
+ (void)cc_buttonTapEnlarge:(CC_Button *)button;
```
## 函数使用方法

CC_Lib/CC_Function 具体使用见Test_FunctionViewController

>  CC_Function 常用工具函数
> CC_String CC_Array  CC_Dictionary CC_Data CC_Date CC_Object相关类方法

```
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
```

## config使用方法
使用动态域名方案。
动态域名方案-将服务接口请求地址集合放在一个json文件里，上传到阿里云或者服务器，app拿到这个文件再获取域名，可以用于域名修改要发包的情况。
新建一个CC_CommonConfig.xcconfig文件，在里面写上

```
GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
```
新建发布

```
（CC_ReleaseConfig.xcconfig）、 主干（CC_TrunkConfig.xcconfig）、分支1（CC_Branch1Config.xcconfig）等.xcconfig文件，在里面写上tag值和导入'CC_CommonConfig.xcconfig'文件，release=0，trunk=1，branch1=2 ...
```
```
CCBUILDTAG=0
#include "CC_CommonConfig.xcconfig"
```

之后只需修改project - info里的configurations来区分线上、主干和分支。
<img src="https://github.com/gwh111/bench_ios/blob/master/resources/WX20190830-181405%402x.png" width="840">

```
//我们传入动态域名的地址来获取正确的配置域名：
[ccs configureDomainWithReqGroupList:@[@[线上地址1,线上地址2...], @[主干地址1,主干地址2...], @[分支1地址1,分支1地址2...] ...] andKey:@"eh_doctor_api" cache:NO pingTest:YES block:^(HttpModel *result) {
//从result获取域名
}];
```
