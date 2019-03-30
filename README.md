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

必须初始化布局
You must init base UI frame
```
//需要先初始化布局
[[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
```

### 模拟器动态布局
========
![img](https://github.com/gwh111/bench_ios/blob/master/casGif.gif)  
![img](https://github.com/gwh111/bench_ios/blob/master/casGif2.gif)  
CC_UIAtom;  
创建可以动态修改的基础控件  
```
//需要先初始化布局
[[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:667];
//创建一个view
[CC_UIAtom initAt:self.view name:@"MainVC_v_figure1" type:CCView finishBlock:^(CC_View *atom) {
}];
```
### 网络请求
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

### 数据处理
#### 转化map，将map数据插入数组。  
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
#### 排序
```
NSMutableArray *arr=[[NSMutableArray alloc]initWithArray:@[@{@"name":@"张三",@"id":@"xxx"},@{@"name":@"李四",@"id":@"xxx"}]];
arr=[CC_Array sortChineseArr:arr depthArr:@[@"name"]];
```
#### 解决json数据浮点数精度丢失问题
修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题。  
```
/**
 *  修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题
 例子:
 NSString *html = @"{\"71.40\":71.40,\"8.37\":8.37,\"80.40\":80.40,\"188.40\":188.40}";此段html转换成NSMutableDictionary后使用correctNumberLoss处理耗时0.000379秒
 */
- (NSMutableDictionary *)correctDecimalLoss:(NSMutableDictionary *)dic;
```  

### GCD
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
