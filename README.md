# bench_ios
bench for ios

#### Podfile

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

在.pch文件或需要的地方引入  
```
#import "CC_Share.h"
```
必须先初始化布局  

```
//设置基准 效果图的尺寸 比如效果图是iphone6的尺寸
[[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:667];

```

<img src="https://github.com/gwh111/bench_ios/blob/master/ccui说明.jpg" width="440">
我们默认采用方案B 所以嵌套getRH和getRFS函数来实现缩放，为什么字体不也用getRH呢？因为字体缩放系数和frame的缩放系数不同，会稍微低一些，如果字体用等比缩放会在小设备看上去适合，但在大屏幕由于放大过多有点像老年机。  

```
//使用frame时 原bt.top=10;  转换为 bt.top=[ccui getRH:10];  
[ccui getRH:10];
//使用font时 原titleL.font=[UIFont systemFontOfSize:14];  转换位 titleL.font=[ccui getRFS:14];  
[ccui getRFS:14];
```  
通过包一层ccui函数，会对其他尺寸自动缩放适配。v1.3.78后也可以使用RH()和RF()来减少代码量 如：  
```
UILabel *l=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, RH(200), RH(40))];
l.font=RF(14);
[self.view addSubview:l];
```

### 模拟器动态布局
========  
<img src="https://github.com/gwh111/bench_ios/blob/master/casGif.gif" width="640">
<img src="https://github.com/gwh111/bench_ios/blob/master/casGif2.gif" width="640">  
<!--![img](https://github.com/gwh111/bench_ios/blob/master/casGif.gif)  -->
<!--![img](https://github.com/gwh111/bench_ios/blob/master/casGif2.gif)  -->
[解析文章](https://blog.csdn.net/gwh111/article/details/81094304)  
CC_UIAtom 创建可以动态修改的基础控件  
```
//需要先初始化布局
[[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:667];
//引入cas文件y及路径
NSString *absoluteFilePath=CASAbsoluteFilePath(@"stylesheet.cas");
[CC_ClassyExtend initSheet:absoluteFilePath];
//解析并存储布局配置
[CC_ClassyExtend parseCas];
//创建一个view 即可在对应的cas文件修改布局 保存后模拟器自动刷新布局
[CC_UIAtom initAt:self.view name:@"MainVC_v_figure1" type:CCView finishBlock:^(CC_View *atom) {
}];
```
### CC_HttpTask网络请求
#### get和post
解决了打印日志对于Unicode编码不能正常显示中文的问题，只需要将文件导入工程，不需要引用，就能达到打印日志显示Unicode编码中文数据。
```
//get
[[CC_HttpTask getInstance]get:@"https://www.baidu.com/" params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {

}];
//post
[[CC_HttpTask getInstance]post:@"https://www.baidu.com/" params:@{@"getDate":@""} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {

}];
```
#### 接口统一处理回调
比如对其他地方登陆逻辑处理  
```
[[CC_HttpTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:NO logicBlock:^(NSDictionary *resultDic) {
    CCLOG(@"%@",@"PARAMETER_ERROR");

    //取消这个配置    
    [[CC_HttpTask getInstance]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
}];
```
#### http请求头设置
```
[[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:
@{@"appName":@"ljzsmj_ios",
  @"appVersion":@"1.0.3",
  @"appUserAgent":@"e1",
  }];
```
#### 多图上传
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
-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<ResModel*> *errorModelArr, NSArray<ResModel*> *successModelArr))uploadImageBlock;

/**
 上传多张图片-指定图片大小 单位 兆

 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageSize 指定图片大小 单位 兆
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<ResModel*> *errorModelArr, NSArray<ResModel*> *successModelArr))uploadImageBlock;
```

### 数据处理
#### CC_Parser转化map，将map数据插入数组。  
```
/**
 * 将map的数据移置list中
 *
 * NSMutableArray *parr=[CC_Parser getMapParser:result[@"response"][@"purchaseOrders"] idKey:@"order" keepKey:YES pathMap:result[@"response"][@"paidFeeMap"]];
 * parr=[CC_Parser addMapParser:parr idKey:@"prize" keepKey:NO map:result[@"response"][@"prizeFeeMap"]];
 *
 * pathArr 需要获取的list路径 如result[@"response"][@"purchaseOrders"]
 * idKey 要取的map字段key 如purchseNo
 * keepKey 是否保留原字段 如purchseNo 本身含有意义要保留 会在key最后添加_map区分" 如xxxid 本身没有意义，为了取值而生成的id不保留 被map相应id的数据替换
 * mapPath 要取的map的路径 如result[@"response"][@"paidFeeMap"] map中可以是nsstring 也可以是nsdictionary
 */
+ (NSMutableArray *)getMapParser:(NSArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey pathMap:(NSDictionary *)pathMap;

/**
 * 将map的数据移置list中 多个map时添加
 */
+ (NSMutableArray *)addMapParser:(NSMutableArray *)pathArr idKey:(NSString *)idKey keepKey:(BOOL)keepKey map:(NSDictionary *)getMap;

/**
 *  冒泡排序
 *  desc=1 降序
    key=nil 直接对mutArr取值排序
 */
+ (NSMutableArray *)sortMutArr:(NSMutableArray *)mutArr byKey:(NSString *)key desc:(int)desc;
```

```
NSDictionary *result=@{@"response":
@{@"purchaseOrders":
@[
@{@"name":@"111",@"order":@"1111",@"prize":@"aaa"},
@{@"name":@"222",@"order":@"2222",@"prize":@"bbb"}],

  @"paidFeeMap":
@{@"1111":@"100yuan",@"2222":@"120yuan"},

  @"prizeFeeMap":
@{@"aaa":@{@"name":@"a",@"time":@"ac"},
  @"bbb":@{@"name":@"b",@"time":@"bc"}}
                                     }};

NSMutableArray *parr=[CC_Parser getMapParser:result[@"response"][@"purchaseOrders"] idKey:@"order" keepKey:YES pathMap:result[@"response"][@"paidFeeMap"]];
parr=[CC_Parser addMapParser:parr idKey:@"prize" keepKey:NO map:result[@"response"][@"prizeFeeMap"]];
```
#### CC_Array排序
```
/**
 *  中文的排序
 *  proMutArr 需要排序的数组
 *  depthArr 字典深度的路径数组
 *  如排序一层中文 如@[@"张三",@"李四"];
    depthArr=nil;
 *  如排序嵌套字典的数组 如@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}];
    depthArr=@[@"name"];
 */
+ (NSMutableArray *)sortChineseArr:(NSMutableArray *)sortMutArr depthArr:(NSArray *)depthArr;

/**
 * 从小到大排序
 */
+ (NSArray *)arrayAscending:(NSArray *)arr;

/**
 * 从大到小排序
 */
+ (NSArray *)arrayDescending:(NSArray *)arr;
```

```
NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}]];
arr=[CC_Array sortChineseArr:arr depthArr:@[@"name"]];
```
#### NSMutableDictionary解决json数据浮点数精度丢失问题
修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题。  
```
/**
 *  修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题
 例子:
 NSString *html = @"{\"71.40\":71.40,\"8.37\":8.37,\"80.40\":80.40,\"188.40\":188.40}";此段html转换成NSMutableDictionary后使用correctNumberLoss处理耗时0.000379秒
 */
- (NSMutableDictionary *)correctDecimalLoss:(NSMutableDictionary *)dic;
```  
#### CC_Logic版本号的对比
```
/**
 *  版本号对比 如1.3.1 比 1.4.2版本低 返回-1
 *  1 v1>v2
 *  0 v1=v2
 * -1 v1<v2
 */
+ (int)compareV1:(NSString *)v1 cutV2:(NSString *)v2;
```

### CC_HookTrack无感知埋点统计
[解析文章](https://blog.csdn.net/gwh111/article/details/81479040)  
```
//CC_HookTrack 路径跟踪开启 app启动时开启一次
[CC_HookTrack catchTrack];
//获取此时刻调用的前三个方法名
NSString *actions=[CC_HookTrack getInstance].triggerActionStr;
//目前所在控制器名
NSString *currentVCStr=[CC_HookTrack getInstance].currentVCStr;
//堆栈中所有的控制器名字们
NSArray *lastVCs=[CC_HookTrack getInstance].lastVCs;
//记录控制器进出的记录 ViewController1-pushTo-ViewController2
NSString *pushPopActionStr=[CC_HookTrack getInstance].pushPopActionStr;
```

### CC_Date日期的比较
```
/**
 *  NSString转NSDate
 */
+ (NSDate *)ccgetDate:(NSString *)dateStr formatter:(NSString *)formatterStr;

/**
 *  NSDate转NSString
 */
+ (NSString *)ccgetDateStr:(NSDate *)date formatter:(NSString *)formatterStr;

/**
 *  比较时间间隔
    <0 date1 在date2 之前
    >0 date1 在date2 之后
 */
+ (NSTimeInterval)compareDate:(NSDate *)date1 cut:(NSDate *)date2;
```

### CC_Convert格式的转换
```
/**
 *  string to data, utf8编码
 */
+ (NSData *)strToData_utf8:(NSString *)str;

/**
 *  data to string, utf8编码
 */
+ (NSString *)dataToStr_utf8:(NSData *)data;

/**
 *  data to string, base64
 */
+ (NSString *)dataToStr_base64:(NSData *)data;

/**
 *  int转data
 */
+ (NSData *)intToData:(int)i;

/**
 *  JSON转NSString
 */
+ (NSString *)convertToJSONData:(id)infoDict;

/**
 *  NSString转NSDictionary(JSON)
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 *  颜色的16进制NSString转成UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;
```

### CC_Code常用代码封装
```
/**
 *  获取当前控制器
 */
+ (UIViewController *)getCurrentVC;

/**
 *  获取最上层window
 */
+ (UIWindow *)getLastWindow;

/**
 *  获取当前可以展示的view
    先取CurrentVC.view 如果没有 取LastWindow
 */
+ (UIView *)getAView;

/**
 *  设置圆角
 */
+ (void)setRadius:(float)radius view:(UIView *)view;

/**
 *  设置阴影
 */
+ (void)setShadow:(UIColor *)color view:(UIView *)view;
+ (void)setShadow:(UIColor *)color view:(UIView *)view offset:(CGSize)size opacity:(float)opacity;

/**
 *  设置描边
 */
+ (void)setLineColor:(UIColor *)color width:(float)width view:(UIView *)view;
```

### CC_Validate一些规则的验证
```
/**
 *  纯数字
 */
+ (BOOL)isPureInt:(NSString *)str;

/**
 *  纯字母
 */
+ (BOOL)isPureLetter:(NSString *)str;

/**
 *  只有数字字母和中文
 */
+ (BOOL)isMatchNumberWordChinese:(NSString *)str;

/**
 *  有中文
 */
+ (BOOL)hasChinese:(NSString *)str;

/**
 *  手机号码验证
 */
+ (BOOL)validateMobile:(NSString *)mobileStr;

/**
 *  邮箱
 */
+ (BOOL)validateEmail:(NSString *)emailStr;
```

### 常用加密解密
#### CC_DES
```
/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;

//解密
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
```
#### CC_AES
```
/**
 *  CBC模式使用偏移量
    https://www.jianshu.com/p/2e68a91d4681
 */
+ (NSData *)encryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;
+ (NSData *)decryptWithKey:(NSString *)key iv:(NSString *)iv data:(NSData *)data;
/**
 *  没有偏移量
 */
+ (NSData *)encryptData:(NSData *)data key:(NSData *)key;
+ (NSData *)decryptData:(NSData *)data key:(NSData *)key;
```
#### CC_RSA
```
/**
 *  公钥加密
    NSString格式
 */
+ (NSString *)encryptStr:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  公钥加密
    NSData格式
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 *  私钥加密
    NSString格式
 */
+ (NSString *)encryptStr:(NSString *)str privateKey:(NSString *)privKey;

/**
 *  私钥加密
    NSData格式
 */
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

/**
 *  公钥解密
    NSString格式
 */
+ (NSString *)decryptStr:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  公钥解密
    NSData格式
 */
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 *  私钥解密
    NSString格式
 */
+ (NSString *)decryptStr:(NSString *)str privateKey:(NSString *)privKey;

/**
 *  私钥解密
    NSData格式
 */
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
```

### ccs快速开发
使用ccs快速调用基本方法，可实现如获取版本号、获取沙盒文件、获取加密的userdefault等一系列功能，具体可查看CC_Share.h文件。  
在.pch文件或需要的地方引入  
```
#import "CC_Share.h"
```
#### 子线程和主线程切换
```
NSLog(@"1");
[ccs gotoThread:^{
    NSLog(@"2");
    NSLog(@"3");
    [ccs gotoMain:^{
        NSLog(@"4");
    }];
}];
NSLog(@"5");
```
#### 延时
```
[ccs delay:1.1 block:^{

}];
```
#### CC_Notice（黑底白字）、CC_Mask（可视遮罩）、CC_Loading（隐藏遮罩）提示封装
```
//黑底白字提示
[CC_Notice show:@"黑底白字提示~"];

//加载中Mask
[[CC_Mask getInstance]setText:@"加载中"];
[[CC_Mask getInstance]start];
//...
[[CC_Mask getInstance]stop];

//加载中纯文字
[[CC_Loading getInstance]setText:@"加载中"];
[[CC_Loading getInstance]start];
//...
[[CC_Loading getInstance]stop];
```

### CC_MusicBox音乐和音效
```
/**
 * 淡入淡出
 * 使背景音乐过渡不突兀 当切换场景时检查是否有背景音乐在播放 如果有将它淡出 然后将新的背景音乐淡入 起到平滑作用
 */
@property(nonatomic,assign) BOOL fade;

/**
 *  音效循环次数
 */
@property(nonatomic,assign) int effectReplayTimes;

/**
 *  音乐循环次数
 */
@property(nonatomic,assign) int musicReplayTimes;

/**
 *  设置最大音量
    注意：如不设置 最大音量为手机设置的音量
 */
@property(nonatomic,assign) float defaultVolume;

- (void)stopMusic;
- (void)playMusic:(NSString *)name type:(NSString *)type;
- (void)playEffect:(NSString *)name type:(NSString *)type;
```

### DEBUG插件
目前包含历史请求查看  
<img src="https://github.com/gwh111/bench_ios/blob/master/reqHistory.png" width="320">
```
#import "CC_YCFloatWindow.h"
......

//可在任意控制器的生命周期方法中添加，尽量避开app启动业务
#if DEBUG
[CC_Share getInstance].ccDebug=1;
[CC_FloatWindow addWindowOnTarget:self];
#endif

```
#### 3D视图插件
```
#import "CC_3DWindow.h"
......

//展示3D视图绘层

#if DEBUG
[CC_3DWindow show];
#endif

```
