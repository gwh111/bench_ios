# bench_ios
bench for ios

# v1.1.3
Overview
========
object;
    CC_Array

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

# 初始化类
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
