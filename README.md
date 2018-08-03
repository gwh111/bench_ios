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

# v1.3.8
========
CC_HttpTask;
打印结果的中文正常显示
CC_HookTrack;追踪操作路径
预先willPopOfIndex:       willPushTo:;
来源catchTrack;

# v1.3.7
========
CC_Array;
增加中文排序
CC_HttpTask;
增加额外参数addExtreDic:

# v1.3.0
========
![img](https://github.com/gwh111/bench_ios/blob/master/casGif.gif)
CC_UIAtom;
创建可以动态修改的基础控件
```
//需要先初始化布局
[[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
//创建一个view
[CC_UIAtom initAt:self.view name:@"MainVC_v_figure1" type:CCView finishBlock:^(CC_View *atom) {
}];
```

# v1.2.28
========
CC_HttpTask;
设置通用响应结果特殊处理回调逻辑
```
//添加逻辑
[[CC_HttpTask getInstance] addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:YES logicBlock:^(NSDictionary *resultDic) {
//在这里添加处理代码
}];
//重置去重
[[CC_HttpTask getInstance]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
```
CC_CodeClass    colorwithHexString:
服务端颜色的16进制NSString转成UIColor

# v1.2.23
Overview
========
network;
CC_RequestRecordTool
ResModel 增加requestUrl

# v1.2.14
Overview
========
tool;
CC_Animation 按钮闪烁动画 点击放大动画
CC_MusicBox 背景音乐淡入淡出播放 音效播放
network;
ResModel 提示只在debug出现 正式环境自由控制

# v1.2.2
Overview
========
```objective-c
//http头部信息
[[CC_HttpTask getInstance]setRequestHTTPHeaderFieldDic:
@{@"appName":@"ljzsmj_ios",
@"appVersion":@"1.0.3",
@"appUserAgent":@"e1",
}];
//签名的key 一般登录后获取
[[CC_HttpTask getInstance]setSignKeyStr:@"abc"];
//额外每个请求要传的参数
[[CC_HttpTask getInstance]setExtreDic:@{@"key":@"v"}];
NSURL *url=[NSURL URLWithString:@"http://xxx/service.json?"];
[[CC_HttpTask getInstance]post:url Params:@{@"service":@"PURCHASE_ORDRE_JOINED_SHOW_CONFIG_QUERY"} model:[[ResModel alloc]init] FinishCallbackBlock:^(NSString *error, ResModel *result) {
if (error) {
[CC_Note showAlert:error];
return ;
}

CCLOG(@"%@",result.resultDic);
}];
```
display;
    ui绘制 未完成
network;
    ResModel
    CC_HttpTask
    网络请求类
tool;
    CC_CodeClass.h
    topViewController
    获取当前最上面的controller

# v1.2.1
Overview
========
network;
    CC_CodeClass.h
        convert 字典和string转换
tool;
    CC_Envirnment 代理检测 网络环境检测

# v1.1.7 v1.1.8 v1.1.9 v1.2.0
Overview
========
PlatformConfig.h
object;
    CC_AttributedStr
display;
    CC_UIHelper

# v1.1.4 v1.1.5 v1.1.6
Overview
========
object;
    CC_Button

# v1.1.3
Overview
========
object;
    CC_Array
    CC_Notice
    CC_GCoreDataManager
    CC_GColor

# v1.1.2
Overview
========
tool;
    DESTool
    CC_CodeClass
display;
    uiviewExt

# v1.1.1
Overview
========
network;
object;
    image
    button~
    label+
tool;

# v1.1.0
Overview
========
network;
object;
    image+
    button+
tool;

# v1.0.4
Overview
========

# 初始化类[未完成 要修改]
CC_Share
启动时为user_signKey赋值 使用登陆后返回的md5 key
# example code
[[CC_Share getInstance] setUserSignKey:@"123"];
[[CC_Share getInstance] setHttpRequestWithAppName:@"app" andHTTPMethod:@"POST" andTimeoutInterval:10];

# 网络请求类
CC_GHttpSessionTask
resultDic 结果
resultStr 对于精度丢失的内容 自行解析 可用sbjson
error 错误
# example code:
NSURL *url=[NSURL URLWithString:@"http://api.jczj123.com/client/service.json"];
NSMutableDictionary *paraDic=[[NSMutableDictionary alloc]init];
[paraDic setObject:@"1" forKey:@"service"];
[CC_GHttpSessionTask postSessionWithJsonUrl:url ParamterStr:paraDic Info:nil FinishCallbackBlock:^(NSDictionary *resultDic, NSString *resultStr, NSString *error) {

}];
