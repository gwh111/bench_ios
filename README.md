
# bench_ios开发指南

<img width=128px src="https://github.com/gwh111/bench_ios/blob/master/bench_ios/icon.png?raw=true" >  

以增加开发效率为目的集成bench_ios开发。  
bench_ios 不仅仅是它本身，还提供的是一种调度模式，可以根据自己业务需求接入不同模块来使用。详见 **组件化分类使用方法**。

## 模板使用
参考XcodeCustom文件夹下README.md
包括工程模板和类模板，模板只需添加一次，**Xcode更新后需要重新添加**。

### Xcode 工程模板
模板文件在XcodeCustom文件夹下。  
使用工程模板会初始化 CC_AppDelegate  CC_ViewController pch 文件。  
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/Project\ Templates/Base
目录下面添加bench_ios Application文件夹即可。  
1. 打开Xcode选择 ***File - New - Project***
2. 滚到下面选择 bench_ios Application > Custom Single App 创建一个新工程。
3. 在 targets > Build Settings > Prefix Header 添加 **xxx** 工程的pch的路径。**$(SRCROOT)/xxx/xxx-prefix.pch**
4. 使用pod安装bench_ios。

### Xcode 类模板
类模板支持 CC_AppDelegate CC_ViewController CC_TabBarController  
/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates 目录下面添加bench_ios Class文件夹即可。  
新建类使用 New File > bench_ios Class > Cocoa Touch Class

## Podfile 安装

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

在.pch文件或需要的地方引入，如使用工程模板会自动引入。

```ruby
import "ccs.h"
```
模式是核心，工具是基础的扩展

# 模式类使用方法

## ccs调度中心介绍
通过ccs只用一种调用方式，获得bench_ios中所有功能。  
```
// 获取实例或执行函数
ccs.xxx;
// 调用类方法
[ccs xxx];
```

ccs有最高调度权限，没有管理权限。管理由各个模块各自管理，分布式架构，ccs可以获取访问权限。  
使用者只需按需调用上层，具体的实现不需要关心，如果需要添加未实现方法或者现有方法不能满足，可以联系维护bench小伙伴

## AppDelegate使用方法
修改main函数入口，如使用模板自动生成。

```ruby
#import <UIKit/UIKit.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, @"CC_AppDelegate");
    }
}
```

新建AppDelegate继承CC_AppDelegate获得控制权限，CC_AppDelegate之后也会分发代理函数给子模块。如使用模板自动生成。  

```ruby
#import "CC_AppDelegate.h"

@interface AppDelegate : CC_AppDelegate

@end
```

```ruby
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
//    [self cc_initViewController:HomeVC.class withNavigationBarHidden:NO block:^{
//        [self launch];
//    }];

    //入口TabBar
    [self cc_initTabbarViewController:TestTabBarController.class block:^{
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
可使用模板类创建。  
```ruby
#import "TestTabBarController.h"
#import "HomeVC.h"
#import "ccs.h"

@interface TestTabBarController ()

@end

@implementation TestTabBarController

- (void)cc_viewWillLoad {
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

    // 动态添加item
    //    [self cc_addTabBarItemWithClass:UIViewController.class
    //                              image:@"tabbar_mine_high"
    //                      selectedImage:@"tabbar_mine_high"
    //                              index:2];
    [self cc_addTabBarItemWithClass:UIViewController.class
                              title:@"我的"
                              image:@"tabbar_mine_high"
                      selectedImage:@"tabbar_mine_high"
                              index:2];
    // 消息角标
    [self cc_updateBadgeNumber:200 atIndex:2];
}
```

## CC_ViewController使用方法

1. 使用 ViewController 继承 CC_ViewController。
2. cc_displayView 进行自定义绘制。它的frame即可显示内容的区域。（如有状态栏，会去除状态栏的部分，如有导航栏，会去除导航栏的部分）
3. 针对 ViewController 业务复杂，存在ABC多个模块时，新建控制器继承 CC_Controller 委托代理进行业务拆分，模块共享。这个控制器也可放入其他 ViewController 使用。

对比传统开发和模板开发：  
原来模板新建 ViewController.h文件

```ruby
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
```
新模板新建 ViewController .h文件

```ruby
#import "CC_ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestNewViewController : CC_ViewController

@end

NS_ASSUME_NONNULL_END
```
原来模板新建 ViewController .m文件

```ruby
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
    // Do any additional setup before loading the view.
}

- (void)cc_viewDidLoad {
    // Do any additional setup after loading the view.
}

@end
```

使用 cc_xxx 替换原先 UIViewController 的 xxx 方法。如 cc_viewDidLoad 代替 viewDidLoad 。  

设置标题：  
```ruby
- (void)cc_viewWillLoad{
    self.cc_title = @"首页";
}
```

根据可选区域 cc_displayView 创建一个 tableview：  
```ruby
- (void)cc_viewDidLoad {
    ccs.TableView
    .cc_addToView(self)
    .cc_frame(0, 0, WIDTH(), self.cc_displayView.height)
    .cc_delegate(self)
    .cc_dataSource(self)
    .cc_backgroundColor(UIColor.whiteColor);
}
```

在 TestNewViewController 获取名为 abc 的视图：  
```ruby
CC_View *view = [self cc_viewWithName:@"abc"];
```

在 TestNewViewController 获取名为 Comment 的控制器C：  
```ruby
TestController *controller = [self cc_controllerWithName:@"Comment"];
```

## Controller使用方法
需要拆分的模块继承 CC_Controller 实现自身代理。控制器初始化注册代理类，实现代理方法。
CC_Controller 通过start() 函数初始化，我们在 CC_Controller 中方便地提供了代理，通过代理分发回调到 CC_ViewController 来交互，传统方法需要声明代理，以及响应判断。

在 TestNewViewController 中注册控制器后可接收控制器中的代理：   
```ruby
- (void)cc_viewWillLoad {
    //  注册完可直接实现TestController里的协议'methd2withA:b:'
    [self cc_registerController:TestController.class];
}
```

声明协议原来要写的代码：

```ruby
// 属性声明
@property(nonatomic,assign) id <CC_LabelGroupDelegate>delegate;

// 代理
if ([self.delegate respondsToSelector:@selector(labelGroup:initWithButton:)]) {
    [self.delegate labelGroup:self initWithButton:button];
}
```

变成直接代理：

```ruby
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

```ruby
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

在对应的 CC_ViewController 中便可接收到此方法

```ruby
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

## CC_Model 使用方法
TestModel 继承 CC_Model 后声明属性。  
将 json 赋值给 CC_Model：  
```ruby
TestModel *modelObj = [ccs model:[TestModel class]];
[modelObj cc_setProperty:@{@"str1":@"xin",@"str2":@"yi"}];
[modelObj cc_update];

//replace Property name
[modelObj cc_setProperty:@{@"str1":@"xin",@"id":@"b"} modelKVDic:@{@"str2":@"id"}];
[modelObj cc_update];
```

通过 TestModel 中的 cc_update 函数做模型的个性化处理，如拼接字符串：  
```ruby
@implementation Test_model

- (void)cc_update {
    CCLOG(@"update Test_model key value %@",self.cc_modelDic);
}

@end
```

## CC_UIKit使用方法
使用链式声明一个ui控件可减少变量名的出现。包含常用ui控件button、label、view、...   

### 控件使用
对比传统方法，创建一个label：  
```ruby
UILabel *label = [[UILabel alloc] init];
label.text = @"mylabel";
label.frame = CGRectMake(RH(10),RH(100),RH(100),RH(100));
label.backgroundColor = HEXA(@"FFD700", 1);
```

使用 CC_UIKit 中的CC_Label：  
```ruby
//省去变量名，通过链式返回对象扩展书写
ccs.label
.cc_name(@"mylabel")
.cc_frame(RH(10),RH(100),RH(100),RH(100))
.cc_backgroundColor(HEXA(@"FFD700", 1));
```

### CC_Alert
系统弹窗快速调用：  
```ruby
- (void)test_Alert {
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
通过配置一些app标准后可全局调用，默认属性有：  
```ruby
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
```

也可自定义配置更多标准，如医疗项目：  
```ruby
#define YL_SUBTITLE_FONT     @"YL_SUBTITLE_FONT"
#define YL_SUBTITLE_COLOR    @"YL_SUBTITLE_COLOR"

[ccs configureAppStandard:@{
                            YL_SUBTITLE_FONT  :RF(13),
                            YL_SUBTITLE_COLOR :UIColor.whiteColor
                            }];

CCLOG(@"%@",APP_STANDARD(YL_SUBTITLE_FONT));
```

### 自动适配使用方法
包含布局和字号：  
所有布局的数字包一层RH()函数（Relative Height），如 CGRectMake(0, 0, RH(200), RH(40)
```ruby
float x = RH(30)
```

字号使用RF()函数（Relative Font）：  
```ruby
UIFont *font = RF(14);
```

### textBind使用方法
```ruby
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

```ruby
@interface TestViewController () {
    UILabel *label;
}
@end
```
或者使用viewWithTag()来取对象，但用tag会很不方便，如果要直观还需将tag声明成static，所以我们提供了viewWithName()的函数来取对象：

```ruby
- (void)funtionB {
    id v = [self cc_viewWithName:@"abc"];
}
```

## 单例使用方法
将单例注册到ccs中即可：  
```ruby
+ (instancetype)shared {
    return [ccs registerSharedInstance:self];
}
```

包含一个返回block，可配置初始化变量，这个block只会走一次：  
```ruby
+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        //do something init
    }];
}
```

## 共享数据使用方法
共享全局的对象，比如在控制器B更新控制器A的 model 。  
设置共享参数：  
```ruby
[ccs setShared:@"name" obj:@"xinyi"];
```

获取共享参数：  
```ruby
NSString *name = [ccs sharedValueForKey:@"name"];
```

更新共享参数：  
```ruby
[ccs resetShared:@"name" obj:@"apple"];
```
移除共享参数：  
```ruby
[ccs removeShared:@"name"];
```

## 多线程使用方法

进入子线程：  
```ruby
[ccs gotoThread:^{
        // do something in thread.
    }];
```

进入主线程：  
```ruby
[ccs gotoMain:^{
        // do something in main.
    }];
```

延时执行：  
```ruby
[ccs delay:3 block:^{
        // do something after 3s.
    }];
```

可取消的名为 notice 的延时执行：  
```ruby
[ccs delay:3 key:@"notice" block:^{

    }];
```

取消名为 notice 的延时，在延时完成前取消才有效，如延时是3秒需在3秒前调用停止就不会执行block中的函数：  
```ruby
[ccs delayStop:@"notice"];
```

一组异步任务 在多个线程执行。如3个异步任务，在3个线程同时执行：  
```ruby
CCLOG(@"cc_group %@",[NSThread currentThread]);
[ccs threadGroup:3 block:^(NSUInteger taskIndex, BOOL finish) {
    if (taskIndex == 0) {
        CCLOG(@"cc_group 0 finish %d %@",finish,[NSThread currentThread]);
    } else if (taskIndex == 1){
        CCLOG(@"cc_group 1 finish %d %@",finish,[NSThread currentThread]);
    } else if (taskIndex == 2){
        CCLOG(@"cc_group 2 finish %d %@",finish,[NSThread currentThread]);
    } else {
        CCLOG(@"cc_group 3 finish %d %@",finish,[NSThread currentThread]);
    }
}];
```

异步完成一组有异步回调的函数后执行下一个函数。如在两个线程同时执行两个任务后再去执行下一个任务：  
```ruby
CCLOG(@"cc_blockGroup %@",[NSThread currentThread]);
[ccs threadBlockGroup:2 block:^(NSUInteger taskIndex, BOOL finish, id sema) {
    if (taskIndex == 0) {
        CCLOG(@"cc_blockGroup 0 %@",[NSThread currentThread]);
        [ccs delay:10 block:^{
            [ccs threadBlockFinish:sema];
        }];
    } else if (taskIndex == 1){
        CCLOG(@"cc_blockGroup 1 %@",[NSThread currentThread]);
        [ccs delay:2 block:^{
            [ccs threadBlockFinish:sema];
        }];
    }
    if (finish) {
        CCLOG(@"cc_blockGroup finish %@",[NSThread currentThread]);
    }
}];
```

顺序执行一组有异步回调的函数后执行下一个函数。如顺序执行任务1和任务2后再执行下一个任务：  
```ruby
CCLOG(@"cc_blockSequence %@",[NSThread currentThread]);
[ccs threadBlockSequence:2 block:^(NSUInteger taskIndex, BOOL finish, id  _Nonnull sema) {
    if (taskIndex == 0) {
        CCLOG(@"cc_blockSequence 0 %@",[NSThread currentThread]);
        [ccs delay:5 block:^{
            [ccs threadBlockFinish:sema];;
        }];
    } else if (taskIndex == 1) {
        CCLOG(@"cc_blockSequence 1 %@",[NSThread currentThread]);
        [ccs delay:2 block:^{
            [ccs threadBlockFinish:sema];;
        }];
    }
    if (finish) {
        CCLOG(@"cc_blockSequence finish %@",[NSThread currentThread]);
    }
}];
```

## 定时器使用方法
获取当前时间戳：  
```ruby
NSTimeInterval *t = [ccs nowTimeTimestamp];
```

获取当前唯一时间戳，比如并发在两个子线程获取也会返回不一样的时间戳：  
```ruby
NSTimeInterval *t = [ccs uniqueNowTimestamp];
```

注册一个定时任务：  
```ruby
[ccs timerRegister:@"testTimer1" interval:1 block:^{
    CCLOG(@"CoreTimer block 1 ");
}];
```

取消一个定时任务：  
```ruby
[ccs timerCancel:@"testTimer2"];
```

## 组件化生命周期分发使用方法
App 生命周期的分发，将耦合在 AppDelegate 中逻辑拆分，每个模块以微应用的形式独立存在。一个工程就会有多个 AppDelegate 存在，包括主工程 AppDelegate 以及部分组件库中的 AppDelegate 。  
执行步骤：  
1. 需要所有组件库依赖 bench_ios 。
2. 在组件库内创建一个 module_delegate 继承 CC_AppDelegate 。  
3. 用pod集成组件后 module_delegate 就会像传统 AppDelegate 一样工作。

## 组件化分类使用方法
通过 bench_ios 中的 cc_message 发送消息来调用组件化模块。因为没有 include 或者 import 组件化库，不会参与链接过程，会在运行时调用组件库。  
执行步骤：
1. 需要所有组件库依赖 bench_ios 。
2. 创建一个 ccs 的分类。如推送组件创建 ccs+APNs.h 和 ccs+APNs.m 。
3. 在分类的h文件声明API：  
```ruby
+ (void)APNs_updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock;
```

4. 在m文件声明实现。在m文件的实现使用 cc_message 发送库的调用消息：  
```ruby
+ (void)APNs_updateTokenToServerWithDomainUrl:(NSURL *)domainUrl authedUserId:(NSString *)authedUserId pushMessageBlock:(void(^)(NSDictionary *messageDic, BOOL lanchFromRemote))pushMessageBlock {
    [cc_message cc_targetAppDelegate:@"AppDelegate_APNs" method:@"updateTokenToServerWithDomainUrl:authedUserId:pushMessageBlock:" block:^(BOOL success) {
        if (!success) {
            CCLOGAssert(@"you need add pod 'bench_ios_APNs' in podfile.");
        }
    } params:domainUrl,authedUserId,pushMessageBlock];
}
```

5. 在项目中使用，使用pod安装APNs库，导入头文件：  
```ruby
// 在pch或指定位置导入组件化分类
#import "ccs+APNs.h"
```

调用：  
```ruby
// 组件化方法 调用推送库
[ccs APNs_updateTokenToServerWithDomainUrl:[NSURL URLWithString:@"http://xxx.com"] authedUserId:@"123456" pushMessageBlock:^(NSDictionary * _Nonnull messageDic, BOOL lanchFromRemote) {

}];
```

## config使用方法
使用动态域名方案。 动态域名方案-将服务接口请求地址集合放在一个json文件里，上传到阿里云或者服务器，app拿到这个文件再获取域名，可以用于域名修改要发包的情况。   
新建一个CC_CommonConfig.xcconfig文件，在里面写上：  
```ruby
GCC_PREPROCESSOR_DEFINITIONS = $(inherited) CCBUILDTAG='$(CCBUILDTAG)'
```

新建发布：  
```ruby
（CC_ReleaseConfig.xcconfig）、 主干（CC_TrunkConfig.xcconfig）、分支1（CC_Branch1Config.xcconfig）等.xcconfig文件，在里面写上tag值和导入'CC_CommonConfig.xcconfig'文件，release=0，trunk=1，branch1=2 ...
```

```ruby
CCBUILDTAG=0
#include "CC_CommonConfig.xcconfig"
```

之后只需修改project - info里的configurations来区分线上、主干和分支。
<img width=840px src="https://github.com/gwh111/bench_ios/blob/master/resources/WX20190830-181405@2x.png?raw=true" >

```ruby
//我们传入动态域名的地址来获取正确的配置域名：
[ccs configureDomainWithReqGroupList:@[@[线上地址1,线上地址2...], @[主干地址1,主干地址2...], @[分支1地址1,分支1地址2...] ...] andKey:@"eh_doctor_api" cache:NO pingTest:YES block:^(HttpModel *result) {
    //从result获取域名
}];
```

# 工具类使用方法
是一些常用方法的工具库。也是从 ccs 中获取。  

## CC_Monitor使用方法
目前CC_Monitor的几大功能是：  
1. 监控app本身和组件的生命周期（包括耗时和内存）。
2. 监控app运行时的异常（包括耗时、内存和异常）。

打开监控和监控日志：  
```ruby
[ccs openLaunchMonitor:YES];
[ccs openLaunchMonitorLog:YES];
```

打开日志后会在启动时打印app和各组件启动耗时情况和内存使用情况：  
```log
2019-10-10 17:59:10.890059+0800 CatPhotoPicker[16705:372162] -[CC_Monitor reviewLaunchFinish] [Line 128]
{
    AppDelegate =     {
        "execution time-consuming" =         {
            "cc_application:didFinishLaunchingWithOptions:" = "0.0001050233840942383";
            "cc_willInit" = "0.01480793952941895";
        };
        "malloc_size" = 32;
    };
}
```

打开app运行定期检查监控和日志：  
```ruby
[ccs openPatrolMonitor:YES];
[ccs openPatrolMonitorLog:YES];
```

打开后如注册的实例在某段时间段过大会打印相关日志。

## 网络请求使用方法
通过 ccs.httpTask 来实现网络相关的任务。  

### http请求使用方法
一个简单的 get 请求：  
```ruby
[ccs.httpTask get:@"https://blog.csdn.net/gwh111/article/details/100700830" params:nil model:nil finishBlock:^(NSString *error, HttpModel *result) {

}];
```

一个有特例配置的 get 请求：  
```ruby
HttpModel *model = [[HttpModel alloc]init];
model.forbiddenJSONParseError = YES;
[ccs.httpTask get:@"https://blog.csdn.net/gwh111/article/details/100700830" params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {

}];
```

### 加密请求
如需使用加密请求，需要先做加密准备：  
```ruby
[ccs.httpEncryption prepare:^{

}];
```
准备完毕后，所有使用 httpTask 的请求会默认加密。加密方法为 AES+RSA  
如单个请求不加密，需对单个接口配置 forbiddenEncrypt 的属性：  
```ruby
HttpModel *model = [[HttpModel alloc]init];
model.forbiddenEncrypt = YES;
[ccs.httpTask get:@"https://blog.csdn.net/gwh111/article/details/100700830" params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {

}];
```

### 图片上传使用方法
上传一组图片，（通过特定接口上传）：  
```ruby
[ccs.httpTask imageUpload:@[IMAGE(@"abc")] url:[NSURL URLWithString:@"xxx"] params:nil imageSize:1024 reConnectTimes:3 finishBlock:^(NSArray<HttpModel *> *errorModelArr, NSArray<HttpModel *> *successModelArr) {

}];
```

根据图片压缩比例上传：  
```ruby
[ccs.httpTask imageUpload:@[IMAGE(@"abc")] url:[NSURL URLWithString:@"xxx"] params:nil imageScale:0.3 reConnectTimes:3 finishBlock:^(NSArray<HttpModel *> *errorModelArr, NSArray<HttpModel *> *successModelArr) {

}];
```

### 文件上传使用方法
暂无

### 下载图片使用方法
不带占位图：  
```ruby
UIImageView *imgV = ccs.ImageView;
imgV.showProgressView = YES;
[self.view addSubView:imgV];

[imgV cc_setImageWithURL:[NSURL URLWithString:@"imageUrl"]];
```

带占位图下载：  
```ruby
[imgV cc_setImageWithURL:[NSURL URLWithString:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
```

带占位图、进度回调、完成回调：  
```ruby
[imgV cc_setImageWithURL:[NSURL URLWithString:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"placeholder"] processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
  //进度回调
} completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
  //完成回调
}];
```

带占位图、进度图、完成回调
```ruby
[imgV cc_setImageWithURL:[NSURL URLWithString:@"imageUrl"] placeholderImage:[UIImage imageNamed:@"placeholder"] showProgressView:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
  //完成回调
}];
```

### 加密使用方法
MD5 唯一性校验：  
```ruby
NSString *md5Str = [CC_MD5Object cc_signString:@"testString"];
```

将所有参数加上MD5Key 做 MD5 后带上 sign 字段：  
```ruby
NSString *md5Str = [ccs function_MD5SignWithDic:@{@"key":@"value"} andMD5Key:@"abc123"];
```

将所有参数加上MD5Key 做 MD5 后获得 sign 值：  
```ruby
NSString *sign = [ccs function_MD5SignValueWithDic:@{@"key":@"value"} andMD5Key:@"abc123"];
```

DES加密：  
```ruby
NSString *desEncryptStr = [CC_DES cc_encryptUseDES:@"testString" key:@"xxxxxxxxx"];
```

DES解密：  
```ruby
NSString *desDecryptStr = [CC_DES cc_decryptUseDES:desEncryptStr key:@"xxxxxxxxx"];
```

AES加密：  
```ruby
//AES加密
//加密-带偏移量
NSData *aesEncryptData = [CC_AES cc_encryptWithKey:@"testKey" iv:@"testIV" data:[@"testString" cc_convertToUTF8data]];
//加密-不带偏移量
NSData *aesEncryptData = [CC_AES cc_encryptWithKey:@"testKey" data:[@"testString" cc_convertToUTF8data]];
```

AES解密：
```ruby
//解密-带偏移量
NSData *aesDecryptData = [CC_AES cc_decryptWithKey:@"testKey" iv:@"testIV" data:aesEncryptData];
//解密-不带偏移量
NSData *aesDecryptData = [CC_AES cc_decryptWithKey:@"testKey" data:aesEncryptData];
```

RSA加密：  
```ruby
//公钥加密
NSString *rsaencryptStr = [CC_RSA cc_encryptStr:@"testString" publicKey:@"testPublicKey"];
//私钥加密
NSString *rsaDecryptStr = [CC_RSA cc_encryptStr:@"testString" privateKey:@"testPrivateKey"];

```

RSA解密：
```ruby
//公钥解密
NSString *rsaencryptStr = [CC_RSA cc_decryptStr:@"testString" publicKey:@"testPublicKey"];
//私钥解密
NSString *rsaDecryptStr = [CC_RSA cc_decryptStr:@"testString" privateKey:@"testPrivateKey"];
```

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
```
CC_MusicBox *musicBox = CC_MusicBox.shared;
// 淡入淡出
musicBox.cc_fadeIn = Yes;
// 音效循环次数
musicBox._cc_soundReplayTimes=10000;
// 音乐循环次数
// musicBox.cc_musicReplayTimes=10000;
// 设置最大音量 （0.0~1.0）
musicBox.cc_defaultVolume=0.8;
// 播放音乐
[musicBox cc_playMusic:@"testMusicName" type:@"wav"];
// 播放音效
//[musicBox cc_playSound:@"testMusicName" type:@"wav"];
// 关闭音乐
[musicBox cc_stopMusic];
```
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
