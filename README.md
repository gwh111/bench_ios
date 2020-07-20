XcodeCustom 下的模板安装
```
sh copyfiles.sh 
```

1. 添加自定义模板
2. 新建工程 选择bench_ios Application > Custom Single App
3. 工程配置 targets > Build Settings > Prefix Header 添加工程预先配置的.pch
// add pch '$(SRCROOT)/projectname/projectname-prefix.pch'
4. pod 'bench_ios'


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

在.pch文件或需要的地方引入

```
import "ccs.h"
```
[有目录的文档](https://gwh111.github.io/2019/10/11/bench-ios/)  
[解析文章](https://blog.csdn.net/gwh111/article/details/100700830)   
