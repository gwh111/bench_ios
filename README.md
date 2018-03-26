# bench_ios
bench for ios

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
[[CC_Share shareInstance] setUserSignKey:@"123"];
[[CC_Share shareInstance] setHttpRequestWithAppName:@"app" andHTTPMethod:@"POST" andTimeoutInterval:10];

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
